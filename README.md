# Beautiful Presentations

Clean, on-brand Microsoft slide decks written in plain Markdown, powered by
[reveal.js](https://revealjs.com/) 6. Pick a **light** or **dark** theme, write
your slides in a `.md` file, and present.

![Light theme preview](README.assets/presentation-preview-light.png)
![Dark theme preview](README.assets/presentation-preview-dark.png)

Every deck is just **two files** — an `.html` and a `.md` — that reference a
shared set of assets (the reveal.js engine, the Microsoft themes, fonts,
backgrounds and plugins). You can use those assets straight from the web, or
install them locally for a fully offline workflow.

## Quick start — online (no install)

Download the two files for the theme you want and open them with a local web
server (the [Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer)
extension for VS Code works great):

```shell
mkdir my_talk && cd my_talk
# dark theme
wget https://raw.githubusercontent.com/wesleyit/my_reveal/main/samples/dark.html
wget https://raw.githubusercontent.com/wesleyit/my_reveal/main/samples/dark.md
# ...or light theme
# wget https://raw.githubusercontent.com/wesleyit/my_reveal/main/samples/light.html
# wget https://raw.githubusercontent.com/wesleyit/my_reveal/main/samples/light.md
```

Edit the `.md`, then click **Go Live**. The assets load from GitHub Pages, so
you need an internet connection.

## Quick start — offline (install once)

Install the assets locally and get a command that scaffolds new decks:

```shell
curl -fsSL https://www.wesleyrodrigues.com.br/my_reveal/install.sh | bash
```

This copies the assets to `~/.my_reveal` and installs two commands to
`~/.local/bin`: `nova_apresentacao_md` (scaffold a deck) and `apresentar`
(open an offline deck). Then, in any folder:

```shell
nova_apresentacao_md dark minha_palestra
#   -> creates ./minha_palestra.html and ./minha_palestra.md
```

The generated deck references the local assets via `file://`. Present it with
the companion command, which opens it in Chrome with the right flag:

```shell
apresentar minha_palestra.html
```

> **Why `apresentar` instead of a double-click?** Chrome blocks `file://` pages
> from reading other local files (the Markdown is loaded via `XMLHttpRequest`),
> so a plain double-click shows an empty deck. `apresentar` launches the deck
> with `--allow-file-access-from-files` in a dedicated browser profile, which
> lifts that restriction. If you prefer to do it by hand:
>
> ```shell
> google-chrome --allow-file-access-from-files --user-data-dir=/tmp/reveal minha_palestra.html
> ```

```text
Usage: nova_apresentacao_md [light|dark] [name] [--online]
  theme   light (default) or dark
  name    output name       (default: apresentacao)
  --online  reference the assets from GitHub Pages instead of ~/.my_reveal
```

> Linux only. The installer uses bash and writes to `~/.my_reveal` and
> `~/.local/bin` (both overridable via the `MY_REVEAL_DIR` and `BIN_DIR`
> environment variables).

## Writing slides

The `.md` file is standard reveal.js Markdown:

- `---` separates horizontal slides, `--` separates vertical slides.
- Set a per-slide background with
  `<!-- .slide: data-background="#1860C5" -->` (a color) or a background image.
- Fenced code blocks get syntax highlighting (Monokai), e.g. ` ```js [1-2|3] `.
- Reveal fragments: `- item <!-- .element: class="fragment" -->`.

### Chalkboard

Each deck ships with a chalkboard for live annotation:

| Key | Action |
| --- | ------ |
| `B` | Toggle the chalkboard |
| `C` | Toggle the notes canvas (draw over the slide) |
| `X` / `Y` | Next / previous pen color |
| `DEL` | Clear the current board |

There are also on-screen buttons in the bottom-right corner.

## Themes

| Light | Dark |
| ----- | ---- |
| White background, dark-blue text, blue headings | Dark-blue background, off-white text, light-blue headings |

Both themes share the same structure and differ only in their semantic color
tokens. To tweak colors, edit the `:root` block of
`assets/theme/microsoft_light_theme.css` or `..._dark_theme.css`.

## Repository layout

```text
my_reveal/
├── install.sh                 # offline installer (Linux)
├── bin/
│   ├── nova_apresentacao_md   # the deck generator
│   └── apresentar             # offline deck launcher (Chrome + flag)
├── templates/                 # deck .html / .md templates
├── assets/                    # the shared runtime assets
│   ├── reveal/                #   reveal.js 6 engine + bundled plugins
│   ├── plugins/               #   chalkboard + customcontrols
│   ├── fontawesome/           #   Font Awesome 6
│   └── theme/                 #   Microsoft themes, fonts, backgrounds, logos
├── samples/                   # ready-to-download online decks
├── index.html + presentation.md   # the live demo (GitHub Pages landing)
└── README.md
```

## License

Released under the [MIT License](LICENSE).
