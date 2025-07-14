# 📁 ffm — Fish File Manager

`ffm` is a minimalist, interactive file manager built entirely in [Fish shell](https://fishshell.com/). It uses `fzf` for fuzzy navigation, with Vim-style keybindings and colorful file previews powered by `exa` and `bat`.
![demo](https://pouch.jumpshare.com/preview/9Sj6zxlKqgpp1J3T2c7UndMoNoKC3kZmDQRbJ47c8xaatyodXyM92KtdrUbBaJBHslFdDuEWkorMOw2aGUXQt1AePW8aVeHPVGwtOjn3i6E)


## ✨ Features

- Navigate with `hjkl` or arrow keys
- Filtering/Search
- Directory preview
- Text file preview
- Icons and color support with Nerd Fonts
- Open files with `xdg-open`

(Operations like copy, cut, paste, rename, etc. Will be added soon) 

## ⚙️ Dependencies

Make sure the following are installed:

- [Fish shell](https://fishshell.com/)
- [`fzf`](https://github.com/junegunn/fzf)
- [`bat`](https://github.com/sharkdp/bat)
- [`exa`](https://github.com/ogham/exa)
- [`xdg-utils`](https://freedesktop.org/wiki/Software/xdg-utils/)
- A [Nerd Font](https://www.nerdfonts.com/) enabled in your terminal


## 🛠 Installation

### One-liner

```bash
curl -fsSL https://raw.githubusercontent.com/AngelJumbo/ffm/main/ffm.fish -o ~/.config/fish/functions/ffm.fish && fish -c 'source ~/.config/fish/functions/ffm.fish'

```

### Manual

Download and paste ffm.fish in:

```
~/.config/fish/functions
```


## 🚀 Usage

To launch the file manager, run:

```fish
ffm
```


## 📚 Keybindings

| Key             | Action                                                     |
|-----------------|------------------------------------------------------------|
| `ctrl-h` / ←    | Go to parent directory                                     |
| `ctrl-l` / →    | Enter selected directory                                   |
| `ctrl-j` / ↓    | Move down the list                                         |
| `ctrl-k` / ↑    | Move up the list                                           |
| `Enter`         | Open file or directory                                     |
| `Esc` / `ctrl-c`| Exit the file manager and cd to the current directory      |


## 🔎 Preview Behavior

- **Directories**: previewed with `exa`
- **Text files**: shows first 20 lines using `bat`, falls back to `head`
