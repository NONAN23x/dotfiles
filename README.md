# dotfiles

![alt text](assets/images/output.png "Rice")
> Above images are from an older rice, which most likely won't work now; but if you still want the configs then checkout the `icicle-jellypop` branch :)

## 🌸 Featuring a cozy, zen setup powered by goodness of linux for a locked-in dev environment



1. Get OhMyZsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

2. Get all the necessary plugins
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```

3. Copy the the .zshrc file

4. Setup Tmux
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

5. Installing Catppuccin Theme
```bash
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

6. Then reload the tmux config, or run `CTRL + I` (I needs to be in uppercase)

7. Install nvchad
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```
