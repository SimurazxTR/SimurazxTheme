# Update packages
pkg update && pkg upgrade

# Install dependencies
pkg install curl git

# Buat file script
nano ~/termux-theme-master.sh

# Paste semua kode di atas, lalu simpan (Ctrl+X, Y, Enter)

# Beri izin execute
chmod +x ~/termux-theme-master.sh

# Jalankan
bash ~/termux-theme-master.sh
