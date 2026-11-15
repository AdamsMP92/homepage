#!/usr/bin/env ruby
# frozen_string_literal: true

require "net/http"
require "uri"

SOURCE = URI("https://raw.githubusercontent.com/AdamsMP92/publication_bibliography/main/AdamsPublications.bib")
TARGET = File.expand_path("../_bibliography/papers.bib", __dir__)
SELECTED_KEYS = %w[
  Adams2026Landscape
  Adams2026minimal
  Adams2026NuMagSANS
  Titov2025SpinDisorder
].freeze

def fetch(uri, redirects_left = 5)
  raise "Too many redirects while fetching #{SOURCE}" if redirects_left.zero?

  response = Net::HTTP.get_response(uri)
  case response
  when Net::HTTPSuccess
    response.body
  when Net::HTTPRedirection
    fetch(URI.join(uri, response.fetch("location")), redirects_left - 1)
  else
    raise "Could not fetch bibliography: HTTP #{response.code} #{response.message}"
  end
end

def decorate(raw_bib)
  bib = raw_bib.sub(
    "% Michael P. Adams -- full publication record",
    "% Michael P. Adams -- full publication record\n" \
      "% Source: https://github.com/AdamsMP92/publication_bibliography\n" \
      "% Website-only fields (selected, bibtex_show, code) are added by scripts/sync_publications.rb."
  )

  bib.gsub!(/^(@\w+\{[^,\n]+,\n)/, "\\1  bibtex_show = {true},\n")

  SELECTED_KEYS.each do |key|
    pattern = /(@\w+\{#{Regexp.escape(key)},\n(?:  bibtex_show = \{true\},\n))/
    raise "Publication key not found: #{key}" unless bib.match?(pattern)

    bib.sub!(pattern, "\\1  selected = {true},\n")
  end

  numag_pattern = /(bibtex_show = \{true\},\n  selected = \{true\},\n)(  author = \{Adams, Michael P\. and Michels, Andreas\},\n  title = \{\{\{NuMagSANS\})/
  raise "NuMagSANS entry could not be decorated" unless bib.match?(numag_pattern)

  bib.sub!(numag_pattern, "\\1  code = {https://github.com/AdamsMP92/NuMagSANS},\n\\2")
  "---\n---\n\n#{bib.strip}\n"
end

output = decorate(fetch(SOURCE))
File.write(TARGET, output)
puts "Updated #{TARGET}"
