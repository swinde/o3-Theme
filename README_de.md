
# O3 Theme

## 1. General Information

**O3 Theme** is a responsive theme for all O3 Shop editions.

### Key Features
- Bootstrap 5.3.8
- Custom build process (Gulp)
- PurgeCSS for optimized CSS output
- SplideJS for sliders

## 2. Installation
Das Theme wird mit dem o3-Shop System ausgeliefert und muss nicht installiert werden.

## 3. Update
Das Theme wird mit dem o3-Shop System mit jedem neuen Release aktualisiert.

## 4. Entwicklung

**Verwenden Sie diese Methode, wenn:** Sie das Thema anpassen oder neue Funktionen entwickeln möchten.

| Requirement | Minimum Version | Notes |
|------------|----------------|-------|
| Node.js | v22.13.0 | [Download](https://nodejs.org/) |
| npm | 10.x | Included with Node.js |
| Gulp CLI | 3.0.0 | [Download](https://gulpjs.com/) |

#### Step 2: Copy Assets to Out Directory

```bash
cp -r <DOCUMENT_ROOT>/vendor/o3-shop/o3-theme/build <DOCUMENT_ROOT>/source/Application/views/<THEME_NAME>
cp -r <DOCUMENT_ROOT>/vendor/o3-shop/o3-theme/package.json <DOCUMENT_ROOT>/source/Application/views/<THEME_NAME>
```
#### Erstellung eines Child-Themes

1. Views Ordner anlegen und Dateien kopieren

```bash
mkdir <DOCUMENT_ROOT>/source/Application/views/<THEME_NAME>
cp -r <DOCUMENT_ROOT>/vendor/o3-shop/o3-theme/* <DOCUMENT_ROOT>/source/Application/views/<THEME_NAME>
```

2. Out Ordner <THEME_NAME> anlegen und Dateien kopieren

```bash
mkdir <DOCUMENT_ROOT>/source/out/<THEME_NAME>
cp -r <DOCUMENT_ROOT>/vendor/o3-shop/o3-theme/out/o3-theme* <DOCUMENT_ROOT>/source/out/<THEME_NAME>
```

3. theme.php
im root des Childordners eine theme.php ersttellen.
```php
declare(strict_types=1);

$aTheme = [
    'id' => 'o3-shop-child',
    'title' => 'CHILD',
    'description' => 'A child theme from o3-shop.',
    'parentTheme' => 'o3-shop',
    'parentVersions' => ['1.1.0','1.3.0'],
];
```

> **Important:**
> - <THEME_NAME> = Name des benutzten Themes bei verwendung eines Child-Themes. Default o3-theme
> - <THEME_NAME> in packagist.json ändern.
> - Copy the entire `o3-theme` directory, not just its contents
> - The target should be `source/out/o3-theme/`, not `source/out/` directly

## 5. Install Build Tools


**5.1 Install Node.js & npm**

**Ubuntu/Debian:**
```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs
```

**Other Systems:**  
Download from [nodejs.org](https://nodejs.org/)

**Verify Installation:**
```bash
node --version  # Should show v22.13.0 or higher
npm --version   # Should show 10.x or higher
```

**5.2 Install Gulp CLI Globally**
```bash
npm install --global gulp-cli
```

**5.3 Install Theme Dependencies**
```bash
cd <DOCUMENT_ROOT>/source/Application/views/o3-theme/
npm install
```

@ralftrapp braucht man das unbedingt?
#### Step 4: Prepare the Database

Import the database setup (same as Composer method):

**Command Line:**
```bash
mysql -u MYSQL_USER -p SHOP_DATABASE < setup.sql
```

**Or via Shop Admin:** Service → Tools → Upload `setup.sql`

#### Step 5: Activate Theme

1. Log into Shop Admin
2. Navigate to **Extensions → Themes**
3. Find **O3 Theme** and click **Activate**

**✅ Installation complete!** You can now start developing.

---

## 3. Development

All source files for CSS and JavaScript are located in the `build/` directory.

### Available Commands

Run these commands from the theme root directory:

| Command | Description | Use Case |
|---------|-------------|----------|
| `gulp` | Production build | Minified JS/CSS with PurgeCSS |
| `gulp dev` | Development watcher | Auto-rebuild on changes + TMP cleanup |

### Development Workflow

**Start the watcher:**
```bash
gulp dev
```

> **During development, make sure production-mode is disabled**. Only then will you be able to view the source maps and unminified assets.
>
> **💡 Tip:** Use the mode-tool, which shows you in the frontend which mode the shop is in. You can activate it in the theme settings.

The watcher monitors:
- `build/js/**/*.js` → Rebuilds JavaScript bundles
- `build/scss/**/*.scss` → Rebuilds CSS
- `**/*.tpl` → Clears OXID TMP directory
- `Application/translations/**/*.php` → Clears OXID TMP directory

**Production build:**
```bash
gulp
```

This will:
- Minify JavaScript and CSS
- Remove unused CSS with PurgeCSS
- Optimize assets for production

### PurgeCSS Safelist

PurgeCSS removes unused CSS classes. If you dynamically generate class names in JavaScript or templates, add them to the safelist.

**Example dynamic classes:**
```smarty
{* Template with dynamic class *}
<div class="[{$type}]-view"></div>
```

**Add to safelist in `gulpfile.js`:**
```javascript
safelist: [
    'grid-view',    // Add your dynamic classes here
    'line-view',
    /^custom-/,        // Or use patterns
]
```

**Location:** Line ~81 in `gulpfile.js` in the PurgeCSS configuration.

---

## 5. Asset Integration

### JavaScript
- Main JS bundle:   
  ``<DOCUMENT_ROOT>/source/Application/views/o3-theme/build/js/main.bundle.js``
- ``import`` new scripts here to include them in the **main JS**.
- Files in `build/js/widgets/` are standalone and must be explicitly loaded in templates:
  ``[{oxscript include="js/widgets/checkagb.js" priority=10}]``
> JavaScript from modules can also be integrated into ``main.bundle.js``. Descriptions and examples can be found in the bundle-file.

### SCSS


- Main SCSS bundle:  
  ``<DOCUMENT_ROOT>/source/Application/views/o3-theme/build/scss/main.bundle.scss``
- ``@import`` new styles here to include them globally.

> CSS/SCSS from the modules can also be integrated into ``main.bundle.scss``. Descriptions and examples can be found in the bundle-file.

---

## 6. jQuery

- This theme uses Bootstrap 5.3.8, which means that vanilla JS is used instead of jQuery.
- If jQuery is absolutely necessary, enable it in theme settings (same version as theme wave).
- Deprecation warnings during build are harmless and will disappear when updating Bootstrap.


## 7. Compatibility with PayPal
The PayPal module checks the active theme ID in one of its templates:
``[{if $oViewConf->getActiveTheme()=='flow'}]`` 
Change ``'flow'`` to ``'o3-theme'`` for compatibility.


## 8. Issues

Please forward all issues to [https://github.com/o3-shop/o3-shop/issues](https://github.com/o3-shop/o3-shop/issues) for the project **O3 Theme**.
