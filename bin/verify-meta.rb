#!/usr/bin/env ruby

require "cgi"
require "json"
require "set"

TARGET_PATHS = ["/", "/blog/", "/fractional-cto/", "/projects/", "/publications/", "/music/"].freeze
LAYOUT_PAGE_PATHS = Set.new(["/fractional-cto/", "/projects/", "/publications/", "/music/"]).freeze
DESCRIPTION_RANGE = (120..160)
VISIBLE_DESCRIPTION_MAX_LENGTH = 70

ATTRIBUTE_PATTERN = /([^\s=\/>]+)\s*=\s*(?:"([^"]*)"|'([^']*)'|([^\s"'=<>`]+))/m
META_TAG_PATTERN = /<meta\b(?:[^>"']|"[^"]*"|'[^']*')*>/im
SCRIPT_TAG_PATTERN = /<script\b((?:[^>"']|"[^"]*"|'[^']*')*)>(.*?)<\/script\s*>/im
PARAGRAPH_TAG_PATTERN = /<p\b((?:[^>"']|"[^"]*"|'[^']*')*)>(.*?)<\/p\s*>/im

def attributes(tag)
  tag.scan(ATTRIBUTE_PATTERN).to_h do |name, double_quoted, single_quoted, unquoted|
    [name.downcase, double_quoted || single_quoted || unquoted]
  end
end

def decode_html(value)
  CGI.unescapeHTML(value.to_s)
end

# Collapse runs of whitespace and trim. Search engines normalize attribute whitespace before
# displaying a snippet, so this is what the 120-160 bound must be measured against. Without it a
# YAML folded scalar (`description: >`) contributes a trailing newline and inflates every count by
# one -- a 160-char description would report 161 and fail for a reason nothing in the output names.
def normalized_text(value)
  decode_html(value).gsub(/\s+/, " ").strip
end

def visible_text(value)
  normalized_text(value.gsub(/<[^>]*>/m, " "))
end

def meta_content(html, attribute_name, attribute_value)
  html.scan(META_TAG_PATTERN).each do |tag|
    tag_attributes = attributes(tag)
    next unless tag_attributes[attribute_name]&.casecmp?(attribute_value)

    return [true, tag_attributes["content"] && normalized_text(tag_attributes["content"])]
  end

  [false, nil]
end

def json_ld_nodes(document)
  case document
  when Array
    document
  when Hash
    graph = document["@graph"]
    return [document] if graph.nil?

    graph.is_a?(Array) ? graph : [graph]
  else
    [document]
  end
end

def type_label(types)
  types.empty? ? "(missing @type)" : types.to_a.map(&:to_s).sort.join(", ")
end

def verify_json_ld(path, html, failures)
  node_count = 0
  json_ld_index = 0
  nodes_by_id = Hash.new { |hash, id| hash[id] = Hash.new { |types, type| types[type] = [] } }

  html.scan(SCRIPT_TAG_PATTERN).each do |raw_attributes, body|
    next unless attributes(raw_attributes)["type"]&.casecmp?("application/ld+json")

    json_ld_index += 1
    begin
      document = JSON.parse(body)
    rescue JSON::ParserError => error
      failures << "#{path}: JSON-LD block #{json_ld_index} is invalid JSON (#{error.message.lines.first.strip})"
      next
    end

    json_ld_nodes(document).each_with_index do |node, node_index|
      node_count += 1
      unless node.is_a?(Hash)
        failures << "#{path}: JSON-LD block #{json_ld_index}, node #{node_index + 1} is not an object"
        next
      end

      id = node["@id"]
      unless id.is_a?(String) && !id.strip.empty?
        failures << "#{path}: JSON-LD block #{json_ld_index}, node #{node_index + 1} is missing @id"
        next
      end

      types = Set.new(Array(node["@type"]))
      nodes_by_id[id][types] << "block #{json_ld_index}, node #{node_index + 1}"
    end
  end

  nodes_by_id.each do |id, declarations|
    next unless declarations.size > 1

    details = declarations.map do |types, locations|
      "#{type_label(types)} at #{locations.join(" and ")}"
    end
    failures << "#{path}: JSON-LD @id #{id.inspect} is declared with different @type values: #{details.join("; ")}"
  end

  node_count
end

def verify_visible_descriptions(path, html, failures)
  lengths = []

  html.scan(PARAGRAPH_TAG_PATTERN).each do |raw_attributes, body|
    classes = attributes(raw_attributes).fetch("class", "").split
    next unless classes.include?("post-description")

    text = visible_text(body)
    lengths << text.length
    next unless text.length > VISIBLE_DESCRIPTION_MAX_LENGTH

    failures << "#{path}: visible post-description is #{text.length} characters; maximum is #{VISIBLE_DESCRIPTION_MAX_LENGTH}"
  end

  lengths
end

def verify_page(path, html)
  failures = []
  description = nil

  description_tag, description = meta_content(html, "name", "description")
  if !description_tag
    failures << "#{path}: missing <meta name=\"description\">"
  elsif description.nil?
    failures << "#{path}: <meta name=\"description\"> is missing its content attribute"
  elsif !DESCRIPTION_RANGE.cover?(description.length)
    failures << "#{path}: meta description is #{description.length} characters; required length is 120-160"
  end

  [["property", "og:description"], ["name", "twitter:description"]].each do |attribute_name, tag_name|
    tag_found, content = meta_content(html, attribute_name, tag_name)
    if !tag_found
      failures << "#{path}: missing #{tag_name} meta tag"
    elsif content.nil?
      failures << "#{path}: #{tag_name} meta tag is missing its content attribute"
    elsif !description.nil? && content != description
      failures << "#{path}: #{tag_name} does not match the meta description"
    end
  end

  json_ld_count = verify_json_ld(path, html, failures)
  visible_lengths = LAYOUT_PAGE_PATHS.include?(path) ? verify_visible_descriptions(path, html, failures) : []

  description_summary = description.nil? ? "description missing" : "description #{description.length} chars"
  visible_summary = if LAYOUT_PAGE_PATHS.include?(path)
                      longest = visible_lengths.max
                      longest ? ", visible description #{longest} chars" : ", visible description absent"
                    else
                      ""
                    end

  ["#{path}: #{description_summary}, #{json_ld_count} JSON-LD node(s)#{visible_summary}", description, failures]
end

if ARGV.length > 1
  warn "Usage: #{File.basename($PROGRAM_NAME)} [SITE_ROOT]"
  exit 2
end

site_root_argument = ARGV.first || "_site"
if site_root_argument.empty?
  warn "FAIL: site root must not be empty"
  exit 2
end

begin
  site_root = File.expand_path(site_root_argument)
rescue ArgumentError => error
  warn "FAIL: invalid site root #{site_root_argument.inspect} (#{error.message})"
  exit 2
end
unless File.directory?(site_root)
  warn "FAIL: build output directory #{site_root.inspect} does not exist; build the site first"
  exit 1
end

failures = []
descriptions = Hash.new { |hash, description| hash[description] = [] }

TARGET_PATHS.each do |path|
  relative_path = path == "/" ? "index.html" : File.join(path.delete_prefix("/"), "index.html")
  page_file = File.join(site_root, relative_path)

  unless File.file?(page_file)
    failures << "#{path}: missing built page #{page_file.inspect}; build the site first"
    next
  end

  begin
    html = File.binread(page_file).force_encoding(Encoding::UTF_8).scrub
  rescue SystemCallError => error
    failures << "#{path}: could not read built page #{page_file.inspect} (#{error.message}); build the site first"
    next
  end

  summary, description, page_failures = verify_page(path, html)
  puts summary
  descriptions[description] << path unless description.nil?
  failures.concat(page_failures)
end

descriptions.each do |description, paths|
  next unless paths.length > 1

  failures << "#{paths.join(" and ")}: duplicate meta description #{description.inspect}"
end

if failures.empty?
  puts "Meta verification passed."
  exit 0
end

failures.each { |failure| warn "FAIL: #{failure}" }
warn "Meta verification failed with #{failures.length} failure(s)."
exit 1
