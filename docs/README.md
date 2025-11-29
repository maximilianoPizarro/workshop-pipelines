# GitHub Pages Documentation

This directory contains the Jekyll site for GitHub Pages with Red Hat Design System styling.

## Structure

- `_config.yml` - Jekyll configuration
- `_layouts/default.html` - Main layout template with Red Hat Design System
- `index.md` - Main documentation page
- `Gemfile` - Ruby dependencies for Jekyll

## Local Development

To test the site locally:

```bash
cd docs
bundle install
bundle exec jekyll serve
```

Then visit `http://localhost:4000/workshop-pipelines/`

## GitHub Pages

GitHub Pages will automatically build and deploy this site when you push to the repository.

Make sure GitHub Pages is enabled in your repository settings:
1. Go to Settings > Pages
2. Source: Deploy from a branch
3. Branch: main /docs folder

