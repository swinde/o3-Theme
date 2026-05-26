# O3 Theme

Responsive theme for O3-Shop, built on Bootstrap 5.

## Who this README is for

This file is for **contributors working on the o3-theme codebase
itself** — the people who edit SCSS in `build/scss/`, change JS in
`build/js/`, tweak the gulp build, run the Playwright suite, or
otherwise hack on the theme inside the O3-Shop organisation.

If you fall into one of the other two audiences, you're in the
wrong place:

- **Shop operator running an o3-shop site?** You don't need to do
  anything special with this repo. `composer require o3-shop/o3-theme`
  (or the metapackage that pulls it in), then activate the theme via
  **Admin → Extensions → Themes → O3 Theme → Activate**. The shop's
  install wizard / `Theme::activate()` writes the defaults from
  `theme.php`; there is no separate SQL import step on o3-shop 1.6+.

- **Building a child theme or shop customization on top of o3-theme?**
  Extension-developer documentation will land on the public docs site
  shortly: <https://docs.o3-shop.com/en/latest/>. Until then, ask in
  an issue if you need orientation.

The rest of this README assumes you're in the first audience.

---

## 1. Repo layout

```
o3-theme/
├── build/          source files for SCSS + JS (this is what you edit)
│   ├── scss/       SCSS sources; main.bundle.scss is the entry point
│   └── js/         JS sources; main.bundle.js + widgets/
├── out/            compiled CSS/JS/images served by the shop
├── tpl/            Smarty templates
├── de/, en/        Smarty translations
├── tests/          Playwright + unit tests
├── gulpfile.js     build pipeline (Sass → PostCSS → PurgeCSS, JS bundling)
├── package.json    Node/npm dependencies for the gulp build
├── theme.php       theme metadata (id, version, settings) consumed by Theme::activate()
├── setup.sql       legacy SQL setup; no longer needed on 1.6+ (Theme::activate handles defaults)
└── composer.json   composer package metadata
```

The composer install ships everything **except** `build/**`,
`gulpfile.js` files referenced only by the build, `package*.json`,
and dotfiles (see `extra.oxideshop.blacklist-filter` in `composer.json`).
That's why a composer-installed o3-theme isn't dev-ready: you only get
the compiled `out/` assets. To work on the sources you need a git
clone of this repo, which is what the rest of this document is about.

---

## 2. Getting a dev checkout

The o3-shop dev environment (`./docker.sh start` in the
[shop-ce repo](https://github.com/o3-shop/shop-ce)) already clones
this repo into `source/Application/views/o3-theme/` — it's a real
git working tree pointing at this upstream. If that's how you're set
up, you're done: open the directory, branch off `main`, edit, build,
push.

If you need a standalone clone (e.g. you're working outside the
shop-ce dev container or you've nuked the views directory), the
canonical location is GitHub:

```bash
git clone https://github.com/o3-shop/o3-Theme.git
```

Note the repo name's case (`o3-Theme`, with capital T on GitHub).
The composer package and the on-disk directory are `o3-theme`
(lower-case).

If you're cloning into an existing shop-ce install whose theme
directory already exists:

```bash
cd <shop-ce>/source/Application/views/
rm -rf o3-theme            # only if it's NOT already a git working tree;
                           # './docker.sh start' makes it one, in which case
                           # you can just `git pull` instead.
git clone https://github.com/o3-shop/o3-Theme.git o3-theme
```

---

## 3. Build toolchain

| Tool | Version | Notes |
|---|---|---|
| Node.js | ≥ 22.13 | https://nodejs.org/ |
| npm | ≥ 10 | bundled with Node |
| Gulp CLI | ≥ 3 | `npm install --global gulp-cli` |

Install the theme's npm dependencies once after cloning:

```bash
cd <shop-ce>/source/Application/views/o3-theme
npm install
```

Available gulp tasks (run from the theme root):

| Command | What it does | When |
|---|---|---|
| `gulp` | Production build: minified JS/CSS, PurgeCSS pruning, asset optimization | before shipping |
| `gulp dev` | Watcher: rebuilds JS on `build/js/**` change, rebuilds CSS on `build/scss/**` change, clears the shop's Smarty `tmp/` on `**/*.tpl` and translation-file changes | day-to-day |

While running `gulp dev`, keep the shop in dev mode (theme settings
→ disable production mode) so the browser serves the un-minified
assets and source maps.

There's a small in-frontend **mode-tool** widget that surfaces which
mode the shop is currently in; enable it from the theme settings to
avoid the "why isn't my change showing up?" tax.

---

## 4. PurgeCSS safelist

Production builds run PurgeCSS over the compiled CSS and drop any
class that isn't seen in the templates / JS. Classes constructed
dynamically slip through:

```smarty
{* dynamic class — PurgeCSS doesn't see "grid-view" or "line-view" anywhere literal *}
<div class="[{$type}]-view"></div>
```

Add those to the safelist in `gulpfile.js` (the PurgeCSS config
block, around line 81):

```javascript
safelist: [
    'grid-view',
    'line-view',
    /^custom-/,   // patterns work too
]
```

---

## 5. Where to put new SCSS / JS

### JavaScript

- **Main bundle** — `build/js/main.bundle.js`. `import` new modules
  here to ship them in the main page bundle.
- **Standalone widgets** — `build/js/widgets/`. Loaded explicitly
  from templates:

  ```smarty
  [{oxscript include="js/widgets/checkagb.js" priority=10}]
  ```

JavaScript shipped by modules can also be folded into
`main.bundle.js`; the file's header comments give worked examples.

### SCSS

- **Main bundle** — `build/scss/main.bundle.scss`. `@import` your
  partials here to include them globally.

Same pattern for module SCSS: examples in the bundle file's comments.

---

## 6. jQuery

The theme targets Bootstrap 5, which uses vanilla JS rather than
jQuery, so the global jQuery is not loaded by default.

If a third-party module genuinely needs jQuery, enable it from the
theme settings (same version the legacy wave theme used). Build-time
deprecation warnings around jQuery are harmless and will disappear
once Bootstrap moves past its current compat shims.

---

## 7. PayPal compatibility

The PayPal module's template checks the active theme literal:

```smarty
[{if $oViewConf->getActiveTheme()=='flow'}]
```

If you're integrating PayPal with o3-theme, change `'flow'` to
`'o3-theme'` in that template. (Tracked separately as something the
module should handle itself.)

---

## 8. Issues

Report bugs and feature requests on the umbrella project tracker:

<https://github.com/o3-shop/o3-shop/issues>

Tag with the project name **O3 Theme** so triage finds them.
Issues that are clearly theme-internal (build, SCSS, JS bundling)
can also go straight on this repo's tracker:
<https://github.com/o3-shop/o3-Theme/issues>.
