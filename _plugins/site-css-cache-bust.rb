require "digest/md5"

module Jekyll
  module SiteCssCacheBust
    def bust_site_css_cache(file_name)
      site_source = @context.registers[:site].source
      source_paths = ["assets/css/main.scss"] + Dir[File.join(site_source, "_sass/**/*")].reject { |path| File.directory?(path) }.sort
      digest = Digest::MD5.hexdigest(
        source_paths.filter_map do |path|
          file_path = path.start_with?(site_source) ? path : File.join(site_source, path)
          File.read(file_path) if File.file?(file_path)
        end.join
      )

      "#{file_name}?v=#{digest}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::SiteCssCacheBust)
