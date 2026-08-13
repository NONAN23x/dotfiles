#!/usr/bin/env bash

set -Eeuo pipefail

usage() {
    printf '%s\n' \
        'Usage: ./install.sh [--dry-run]' \
        '' \
        'Create symlinks for the dotfiles without installing packages.' \
        'Existing files are moved to a timestamped backup directory.'
}

die() {
    printf 'Error: %s\n' "$1" >&2
    exit 1
}

dry_run=0
for argument in "$@"; do
    case "$argument" in
        --dry-run)
            dry_run=1
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            usage >&2
            die "unknown option: $argument"
            ;;
    esac
done

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
backup_started=0

sources=(
    "$repo_dir/config/kitty/current-theme.conf"
    "$repo_dir/config/kitty/kitty.app.png"
    "$repo_dir/config/kitty/kitty.conf"
    "$repo_dir/config/fastfetch/arch.png"
    "$repo_dir/config/fastfetch/config.jsonc"
    "$repo_dir/config/fastfetch/sakura.png"
    "$repo_dir/config/hypr/hypridle.conf"
    "$repo_dir/config/hypr/hyprland.conf"
    "$repo_dir/config/hypr/hyprlock/status.sh"
    "$repo_dir/config/hypr/hyprlock.conf"
    "$repo_dir/config/hypr/switchwall.sh"
    "$repo_dir/config/hypr/themes/frappe.conf"
    "$repo_dir/config/hypr/wall.sh"
    "$repo_dir/config/oh-my-posh/mytheme.omp.toml"
    "$repo_dir/config/oh-my-posh/uew.conf.toml"
    "$repo_dir/config/oh-my-posh/uew.omp.json"
    "$repo_dir/config/rofi/config.rasi"
    "$repo_dir/config/tmux/tmux.conf"
    "$repo_dir/config/yazi/keymap.toml"
    "$repo_dir/config/yazi/theme.toml"
    "$repo_dir/config/yazi/yazi.toml"
    "$repo_dir/config/.zshrc"
)

targets=(
    "$config_dir/kitty/current-theme.conf"
    "$config_dir/kitty/kitty.app.png"
    "$config_dir/kitty/kitty.conf"
    "$config_dir/fastfetch/arch.png"
    "$config_dir/fastfetch/config.jsonc"
    "$config_dir/fastfetch/sakura.png"
    "$config_dir/hypr/hypridle.conf"
    "$config_dir/hypr/hyprland.conf"
    "$config_dir/hypr/hyprlock/status.sh"
    "$config_dir/hypr/hyprlock.conf"
    "$config_dir/hypr/switchwall.sh"
    "$config_dir/hypr/themes/frappe.conf"
    "$config_dir/hypr/wall.sh"
    "$config_dir/oh-my-posh/mytheme.omp.toml"
    "$config_dir/oh-my-posh/uew.conf.toml"
    "$config_dir/oh-my-posh/uew.omp.json"
    "$config_dir/rofi/config.rasi"
    "$config_dir/tmux/tmux.conf"
    "$config_dir/yazi/keymap.toml"
    "$config_dir/yazi/theme.toml"
    "$config_dir/yazi/yazi.toml"
    "$HOME/.zshrc"
)

prepare_backup_dir() {
    if (( backup_started == 0 )); then
        if [[ -e "$backup_root" ]]; then
            backup_root="${backup_root}-$$"
        fi
        mkdir -p -- "$backup_root"
        backup_started=1
    fi
}

link_path() {
    local source="$1"
    local target="$2"
    local source_relative
    local top_name
    local source_top
    local target_top
    local backup_target

    [[ -e "$source" || -L "$source" ]] || die "source does not exist: $source"

    source_relative="${source#"$repo_dir/config/"}"
    if [[ "$source_relative" == */* ]]; then
        top_name="${source_relative%%/*}"
        source_top="$repo_dir/config/$top_name"
        target_top="$config_dir/$top_name"

        if [[ -L "$target_top" ]]; then
            if [[ "$(readlink -f -- "$target_top")" == "$(readlink -f -- "$source_top")" ]]; then
                printf 'Already linked directory: %s\n' "$target_top"
                return
            fi

            backup_target="${backup_root}${target_top}"
            if (( dry_run == 1 )); then
                printf 'Would back up: %s -> %s\n' "$target_top" "$backup_target"
            else
                prepare_backup_dir
                backup_target="${backup_root}${target_top}"
                mkdir -p -- "$(dirname -- "$backup_target")"
                mv -- "$target_top" "$backup_target"
                printf 'Backed up: %s -> %s\n' "$target_top" "$backup_target"
            fi
        fi
    fi

    if [[ -L "$target" ]] && [[ "$(readlink -- "$target")" == "$source" ]]; then
        printf 'Already linked: %s\n' "$target"
        return
    fi

    if [[ -e "$target" || -L "$target" ]]; then
        backup_target="${backup_root}${target}"
        if (( dry_run == 1 )); then
            printf 'Would back up: %s -> %s\n' "$target" "$backup_target"
        else
            prepare_backup_dir
            backup_target="${backup_root}${target}"
            mkdir -p -- "$(dirname -- "$backup_target")"
            mv -- "$target" "$backup_target"
            printf 'Backed up: %s -> %s\n' "$target" "$backup_target"
        fi
    fi

    if (( dry_run == 1 )); then
        printf 'Would link: %s -> %s\n' "$target" "$source"
    else
        mkdir -p -- "$(dirname -- "$target")"
        ln -s -- "$source" "$target"
        printf 'Linked: %s -> %s\n' "$target" "$source"
    fi
}

if (( dry_run == 1 )); then
    printf '%s\n' 'Dry run. No files will be changed.'
fi

for index in "${!sources[@]}"; do
    link_path "${sources[index]}" "${targets[index]}"
done

nvim_config="$config_dir/nvim/lua/chadrc.lua"
if [[ -f "$config_dir/nvim/init.lua" ]]; then
    link_path "$repo_dir/config/nvim/lua/chadrc.lua" "$nvim_config"
else
    printf '%s\n' 'Note: skipping config/nvim/lua/chadrc.lua because NvChad was not found.'
fi

if (( backup_started == 1 )); then
    printf 'Backups: %s\n' "$backup_root"
fi

printf '%s\n' 'Done.'
