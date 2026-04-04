# dotfiles

![alt text](assets/images/output.png "Rice")
> Above images are from an older rice, which most likely won't work now; but if you still want the configs then checkout the `icicle-jellypop` branch :)

## 🌸 Featuring a cozy, zen setup powered by the goodness of Linux for a locked-in dev environment
![alt text](assets/images/redRose.png "Red Rice")

---

## 📦 Dependencies

The following packages are utilized in this configuration. Make sure they are installed on your system:

```text
- KDE Plasma (Primary Desktop Environment)
- Zsh & Oh-My-Zsh (Shell)
- Kitty (Terminal Emulator)
- Neovim (Text Editor - powered by NvChad)
- Tmux (Terminal Multiplexer)
- Yazi (Terminal File Manager)
- Oh-My-Posh (Prompt Theme Engine)
- Fastfetch (System Information Tool)
- Zoxide (Smarter cd command)
- Ripgrep (Fast grep replacement)
- Git & Curl (For downloading plugins)
```

---

## 🛠️ Setting up the Dotfiles

You can symlink these configurations to your local `~/.config` (and `~/`) directories to apply the dotfiles.

### 1. Linking Configurations
Run the following commands to symlink the copied configs:
```bash
ln -s /opt/dotfiles/config/kitty ~/.config/kitty
ln -s /opt/dotfiles/config/fastfetch ~/.config/fastfetch
ln -s /opt/dotfiles/config/oh-my-posh ~/.config/oh-my-posh
ln -s /opt/dotfiles/config/yazi ~/.config/yazi
ln -s /opt/dotfiles/config/nvim ~/.config/nvim
ln -s /opt/dotfiles/config/tmux ~/.config/tmux
ln -s /opt/dotfiles/config/.zshrc ~/.zshrc
```

### 2. Zsh & Zinit Setup
Install Zinit (a flexible and fast Zsh plugin manager):
```bash
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

Once installed, your plugins and completions will automatically be fetched upon opening a new shell or reloading your `~/.zshrc`.

### 3. Tmux Setup
Install the Tmux Plugin Manager (TPM):
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install the Catppuccin Theme for Tmux:
```bash
mkdir -p ~/.config/tmux/plugins/catppuccin
git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```
*Note: After setting this up, start tmux and press `PREFIX + I` (usually `CTRL + B` then `Shift + I`) to install the plugins.*

### 4. Neovim Setup
Install NvChad:
```bash
git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
```

---

## 🪟 Hyprland Specific Setup

While my primary workflow is currently centered around KDE, this repository also includes configurations for the Hyprland Window Manager.

### Hyprland Dependencies
```text
- Hyprland
- hypridle (Idle daemon)
- hyprlock (Screen locker)
- rofi (Application Launcher)
```

### Setting up Hyprland
You can symlink the Hyprland and Rofi configurations using the following commands:
```bash
ln -s /opt/dotfiles/config/hypr ~/.config/hypr
ln -s /opt/dotfiles/config/rofi ~/.config/rofi
```
*(Make sure to review the custom scripts in `config/hypr/` like `switchwall.sh` and `wall.sh` to adjust any paths if necessary.)*
ds:
```bash
ln -s /opt/dotfiles/config/hypr ~/.config/hypr
ln -s /opt/dotfiles/config/rofi ~/.config/rofi
```
*(Make sure to review the custom scripts in `config/hypr/` like `switchwall.sh` and `wall.sh` to adjust any paths if necessary.)*
