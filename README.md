# Dotfiles

Dotfiles for my MacBook setup. These are quite specific to my needs but could be adapted for others.


Currently working on:

💿 MacOS 14.2 Sonoma

🖥️ Apple M3

## Setup 

1) Install Xcode developer tools 🛠️

```bash
git --version
```
A pop-up should show up to install the developer tools

2) Install Rosetta 🪨 - For compatibility with older x86 programs

```bash
./scripts/install_rosetta.sh 
```

3) Install Homebrew 🍺 - Package manager to install our other tools

```bash
./scripts/install_homebrew.sh
```

4) Install [oh-my-zsh](https://ohmyz.sh/#install) 🙀

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

5) Install [Powerlevel10k](https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#oh-my-zsh) 🏋️

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
6) Run script to symlink dotfiles 🔗

```bash
./scripts/create_symlinks.sh
```

7) Install tools using Homebrew ⚙️ - Check the `Brewfile` in this repo to see if the tools in there are required.

```bash
brew bundle install 
```



## References
I have begged, borrowed and, stolen from some other great dotfiles repos:

* [jthegedus/dotfiles](https://github.com/jthegedus/dotfiles)
* [ImaginateScata/dotfiles](https://github.com/ImaginateScata/dotfiles)