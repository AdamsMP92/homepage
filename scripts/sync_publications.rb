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
ARXIV_IDS = {
  "Hortschitz2026MagneticOntology" => "2609.11464",
  "Adams2026ReducedVortex" => "2608.16720",
  "Holt2026BeyondStonerWohlfarth" => "2607.29249",
  "Rai2026PolarizedVortexAssemblies" => "2606.18791",
  "Adams2026Landscape" => "2603.29830",
  "Adams2026NuMagSANS" => "2601.18444",
  "Adams2026minimal" => "2601.17176",
  "Titov2025SpinDisorder" => "2507.01666",
  "Jefremovas2025OxidizedMagnetite" => "2506.20571",
  "Kuchkin2025BlochPoints" => "2405.20798",
  "Adams2024Nutation" => "2405.14586",
  "Rai2024FeNbB" => "2405.14324",
  "Adams2024TractorMagnets" => "2405.06402",
  "Adams2024vortex" => "2404.15826",
  "Sinaga2024DMI" => "2402.00558",
  "Adams2024Signature" => "2311.05706",
  "Bersweiler2023Fingerprint" => "2303.15330",
  "Adams2023GreensFunction" => "2302.05773",
  "Adams2023AngularIUCrJ" => "2210.08406",
  "Sinaga2023PoreDefects" => "2207.09164",
  "Adams2022NeelAtomistic" => "2205.07552",
  "Adams2022NeelAnalytical" => "2205.07549",
  "Bersweiler2022Softness" => "2109.04107"
}.freeze

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
      "% Website-only fields (selected, bibtex_show, code, arxiv) are added by scripts/sync_publications.rb."
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

  ARXIV_IDS.each do |key, arxiv_id|
    entry_pattern = /^@\w+\{#{Regexp.escape(key)},\n.*?(?=^@\w+\{|\z)/m
    entry = bib[entry_pattern]
    raise "Publication key not found for arXiv link: #{key}" unless entry

    existing_id = entry[/^\s*arxiv\s*=\s*\{([^}]+)\}/, 1]
    if existing_id
      raise "Unexpected arXiv ID for #{key}: #{existing_id}" unless existing_id == arxiv_id

      next
    end

    bib.sub!(/^(@\w+\{#{Regexp.escape(key)},\n)/, "\\1  arxiv = {#{arxiv_id}},\n")
  end

  "---\n---\n\n#{bib.strip}\n"
end

output = decorate(fetch(SOURCE))
File.write(TARGET, output)
puts "Updated #{TARGET}"
