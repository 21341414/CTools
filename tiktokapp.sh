sudo dpkg --configure -a && \
sudo apt update && sudo apt install -y nodejs npm chromium && \
sudo npm install -g nativefier && \
nativefier --name TikTok --single-instance --disable-dev-tools --no-sandbox https://www.tiktok.com && \
mkdir -p ~/.local/share/applications && \
cat > ~/.local/share/applications/tiktok.desktop << 'EOF'
[Desktop Entry]
Name=TikTok
Comment=TikTok Web Wrapper
Exec=/home/linux/TikTok-linux-x64/TikTok --disable-gpu
Icon=/home/linux/TikTok-linux-x64/resources/app/icon.png
Terminal=false
Type=Application
Categories=Network;Video;
StartupWMClass=TikTok
EOF
update-desktop-database ~/.local/share/applications && \
echo "TikTok Wrapper Installed! Launching..\n Thank KHXGVNG" && \
~/TikTok-linux-x64/TikTok --disable-gpu
