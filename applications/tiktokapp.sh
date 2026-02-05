APP_DIR="$HOME/TikTok-linux-x64"
DESKTOP_FILE="$HOME/.local/share/applications/tiktok.desktop"

if [ -d "$APP_DIR" ] || [ -f "$DESKTOP_FILE" ]; then
    echo "Old TikTok Wrapper Found \nRmoving..."
    rm -rf "$APP_DIR"
    rm -f "$DESKTOP_FILE"
    update-desktop-database "$HOME/.local/share/applications"
else
    echo "Skip"
fi

sudo dpkg --configure -a
sudo apt update
sudo apt install -y nodejs npm chromium-browser wget

if ! command -v nativefier >/dev/null 2>&1; then
    sudo npm install -g nativefier
fi

nativefier --name TikTok --single-instance --disable-dev-tools --no-sandbox https://www.tiktok.com

mkdir -p "$APP_DIR"
wget -O "$APP_DIR/tiktok.png" https://raw.githubusercontent.com/21341414/CTools/refs/heads/main/applications/tiktok.png

mkdir -p "$HOME/.local/share/applications"
cat > "$DESKTOP_FILE" << 'EOF'
[Desktop Entry]
Name=TikTok KX Launcher
Comment=TikTok Web Wrapper Client
Exec=/home/linux/TikTok-linux-x64/TikTok --disable-gpu
Icon=/home/linux/TikTok-linux-x64/tiktok.png
Terminal=false
Type=Application
Categories=Network;Video;
StartupWMClass=TikTok
EOF

update-desktop-database "$HOME/.local/share/applications"

echo -e "TikTok Wrapper Installed! Launching..\nThank KHXNGVNG \nNOTE : IT TAKES A WHILE TO LOAD, WAIT"
"$APP_DIR/TikTok" --disable-gpu
