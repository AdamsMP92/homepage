# Michael P. Adams — academic homepage

Source code for the Jekyll/al-folio website that will replace the current WordPress site. It is configured as a GitHub Pages project site at:

https://adamsmp92.github.io/homepage/

The production domain can later be moved to michaelphilippadams.com without changing the content model.

## Structure

- _pages/: home, publications, software, teaching, awards, posters, and legal/privacy content
- _bibliography/papers.bib: publication data rendered by jekyll-scholar
- _data/socials.yml: professional and scholarly profile links
- _sass/_custom.scss: site-specific visual design
- assets/img/: profile and poster images migrated from WordPress
- .github/workflows/deploy.yml: build and deployment to GitHub Pages

The theme runtime is pinned through Gemfile.lock; local content and styling stay separate from al-folio internals.

## First deployment

1. In the GitHub repository, open **Settings → Pages**.
2. Set **Build and deployment → Source** to **GitHub Actions**.
3. Push the source to main.
4. Follow the **Deploy GitHub Pages** workflow in the Actions tab.

The workflow builds the custom Jekyll plugins and uploads the generated site with GitHub's official Pages actions.
See GitHub's [custom workflow documentation](https://docs.github.com/en/pages/getting-started-with-github-pages/using-custom-workflows-with-github-pages) for the corresponding repository setting.

## Local preview

Use Ruby 3.3.5 (see .ruby-version). To keep resource usage bounded:

~~~bash
BUNDLE_JOBS=2 bundle install
bundle exec jekyll serve
~~~

Then open http://127.0.0.1:4000/homepage/.

## Update publications

The canonical bibliography remains in [AdamsMP92/publication_bibliography](https://github.com/AdamsMP92/publication_bibliography). Regenerate the website copy with:

~~~bash
ruby scripts/sync_publications.rb
~~~

The script keeps the website-only fields for selected publications, BibTeX buttons, and the NuMagSANS code link.

## Move the custom domain

When the GitHub Pages version is approved:

1. Change url in _config.yml to https://michaelphilippadams.com.
2. Set baseurl to an empty value.
3. Configure the custom domain under **Settings → Pages**.
4. Update the DNS records only after the GitHub Pages build is healthy.

A CNAME file alone does not configure the domain in GitHub; use the repository settings as the source of truth.
GitHub documents the DNS and verification steps in its [custom-domain guide](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).

## Content policy

No analytics, advertising, comments, or marketing cookies are enabled. External scholarly profiles and download links remain links to their respective providers.
