rm -rf ~/TikTok-linux-x64 && \
rm -f ~/.local/share/applications/tiktok.desktop && \
update-desktop-database ~/.local/share/applications && \
sudo dpkg --configure -a && sudo apt update && sudo apt install -y nodejs npm chromium && \
sudo npm install -g nativefier && \
nativefier --name TikTok --single-instance --disable-dev-tools --no-sandbox https://www.tiktok.com && \
mkdir -p ~/TikTok-linux-x64 && \
wget -O ~/TikTok-linux-x64/tiktok.png https://raw.githubusercontent.com/21341414/CTools/refs/heads/main/applications/tiktok.png && \
mkdir -p ~/.local/share/applications && \
cat > ~/.local/share/applications/tiktok.desktop << 'EOF'
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
update-desktop-database ~/.local/share/applications && \
echo -e "TikTok Wrapper Installed! Launching..\nThank KHXNGVNG \nNOTE: IT TAKES A WHILE TO LOAD, WAIT" && \
~/TikTok-linux-x64/TikTok --disable-gpu

