document.addEventListener("click", (event) => {
  if (!event.target || typeof event.target.closest !== "function") return;

  const anchor = event.target.closest("a[href]");
  if (!anchor) return;

  let url;
  try {
    const href = anchor.getAttribute("href");
    url = new URL(href, window.location.href);
  } catch {
    return;
  }

  const hostname = url.hostname;
  const isCalendly = hostname === "calendly.com" || hostname.endsWith(".calendly.com");

  if (isCalendly && typeof fathom !== "undefined" && typeof fathom.trackEvent === "function") {
    fathom.trackEvent("Calendly CTA clicked");
  }
});
