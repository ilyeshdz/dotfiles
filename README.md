<div align="center">
  <h1>Dotfiles</h1>
  <i>This repository contains all my personal dotfiles and configuration files for the tools I use.</i>
</div>

---

## Usage

To install and link these dotfiles into your system, use the `setup.sh` script provided in the repository.  
The script handles:

- Creating symlinks for all files in the `home/` directory (including hidden dotfiles) into your `$HOME` directory.
- Creating symlinks for all directories in the `config/` folder into `~/.config/`.
- Backing up existing files to `~/.config/backup/` before replacing them.
- Logging all actions in `setup.log`.
- Colored output and user prompts for a better terminal experience.

## Installation

```bash
git clone https://github.com/ilyeshdz/dotfiles
cd dotfiles
chmod +x setup.sh
./setup.sh
```
