# O3-Theme

Responsive theme for O3-Shop, built on Bootstrap 5.

## Overview

O3-Theme is the official responsive theme for O3-Shop. It provides a full
Bootstrap 5 frontend including compiled CSS/JS, Smarty templates, translations,
and a complete set of theme settings configurable via the shop admin.

Current version: **1.5** — see [CHANGELOG.md](CHANGELOG.md) for what changed.

---

## Directory layout

```
o3-theme/
├── build/          SCSS + JS source files (entry point: main.bundle.scss / main.bundle.js)
├── out/o3-theme/
│   └── src/
│       ├── css/    main.css, main.min.css, photoswipe.css
│       ├── js/     main.js, main.min.js, widget/*.js
│       ├── img/    theme images and background
│       └── fonts/  web fonts
├── tpl/            Smarty templates (layout, pages, widgets, email, forms)
├── de/             German translations (lang.php, theme_options.php)
├── en/             English translations (lang.php, theme_options.php)
├── theme.php       Theme metadata, version, and all configurable settings
├── setup.sql       Default config values (legacy; Theme::activate() handles this on O3-Shop 1.6+)
├── composer.json   Composer package metadata
├── CHANGELOG.md    Version history
└── README.md       This file
```

---

## CSS build

The build toolchain requires Node.js ≥ 22.13 and Gulp CLI ≥ 3.

```bash
npm install          # install dependencies once
gulp                 # production build (minified, PurgeCSS)
gulp dev             # watcher for day-to-day development
```

`gulp dev` also clears the shop's Smarty `tmp/` on template and translation changes.
Run the shop in dev mode (admin → Theme settings → disable production mode) while
developing so the browser loads unminified assets.

To rebuild only the CSS without the full gulp pipeline:

```bash
cd out/o3-theme/src/css
npx sass --style=compressed --no-source-map main.css main.min.css
```

---

## Child themes

O3-Theme is designed to be extended via child themes. Set `parentTheme => 'o3-theme'`
in the child theme's `theme.php`. O3-Shop resolves templates and assets from the
child theme first, then o3-theme, so only files that actually differ need to be
present in the child theme.

---

## Clearing the Smarty cache

```bash
docker exec <shop-container> bash -c "rm -rf /var/www/html/source/tmp/smarty/"
```

---

## Issues

<https://github.com/o3-shop/o3-Theme/issues>
