#!/bin/bash

# Define paths
CONFIG_DIR="./config"
HOME_DIR="./home"
BACKUP_DIR="$HOME/.config/backup"
LOG_FILE="setup.log"

# Create a log file (clear if exists)
> "$LOG_FILE"

# Function to log actions
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Function to create symlink
create_symlink() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" || -L "$dest" ]]; then
        log "Target '$dest' already exists."
        read -p "Do you want to replace it? (y/n): " choice
        if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
            # Backup the existing file or symlink
            mkdir -p "$BACKUP_DIR"
            local backup_file="$BACKUP_DIR/$(basename "$dest")_$(date '+%Y%m%d%H%M%S')"
            log "Backing up '$dest' to '$backup_file'"
            mv "$dest" "$backup_file"
        else
            log "Skipping replacement of '$dest'"
            return
        fi
    fi

    # Create the symlink
    ln -sfn "$src" "$dest"
    if [[ -L "$dest" ]]; then
        log "Created symlink: '$src' -> '$dest'"
    else
        log "Error: Failed to create symlink for '$src' -> '$dest'"
    fi
}

# ASCII art for "SETUP.SH" with colors
print_banner() {
    echo -e "\e[1;36m"
    echo "           _                    _     "
    echo "          | |                  | |    "
    echo "  ___  ___| |_ _   _ _ __   ___| |__  "
    echo " / __|/ _ \ __| | | | '_ \ / __| '_ \ "
    echo " \__ \  __/ |_| |_| | |_) |\__ \ | | |"
    echo " |___/\___|\__|\__,_| .__(_)___/_| |_|"
    echo "                    | |               "
    echo "                    |_|               "
    echo -e "\e[0m"
}

# Print the banner
print_banner

# Handle config symlinks
if [[ -d "$CONFIG_DIR" ]]; then
    log "Processing config directory: '$CONFIG_DIR'"

    # Iterate over all subdirectories in config
    for config_folder in "$CONFIG_DIR"/*; do
        if [[ -d "$config_folder" ]]; then
            dest="$HOME/.config/$(basename "$config_folder")"
            create_symlink "$config_folder" "$dest"
        fi
    done
else
    log "Error: '$CONFIG_DIR' directory not found!"
fi

# Handle home symlinks (including hidden files)
if [[ -d "$HOME_DIR" ]]; then
    log "Processing home directory: '$HOME_DIR'"

    # Iterate over all files and directories in home, including hidden ones
    shopt -s dotglob  # Include hidden files in the globbing
    for home_folder in "$HOME_DIR"/*; do
        if [[ -d "$home_folder" || -f "$home_folder" ]]; then
            dest="$HOME/$(basename "$home_folder")"
            create_symlink "$home_folder" "$dest"
        fi
    done
    shopt -u dotglob  # Restore the default globbing behavior
else
    log "Error: '$HOME_DIR' directory not found!"
fi

log "Script execution completed."
