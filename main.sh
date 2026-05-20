#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
#  TERMUX THEME MASTER v1.0
#  Premium Theme Manager for Termux
#  Author: Project Simura
#  Mode: UNRESTRICTED
# ============================================================

VERSION="1.0"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TERMUX_CONFIG="$HOME/.termux"
TERMUX_PROPERTIES="$TERMUX_CONFIG/colors.properties"
TERMUX_FONT="$TERMUX_CONFIG/font.ttf"
BACKUP_DIR="$HOME/.termux_themes_backup"

# Warna untuk UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# ==================== FUNGSI UTILITY ====================

print_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                                                              ║"
    echo "║   ████████╗███████╗██████╗ ███╗   ███╗██╗   ██╗██╗  ██╗     ║"
    echo "║   ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║██║   ██║╚██╗██╔╝     ║"
    echo "║      ██║   █████╗  ██████╔╝██╔████╔██║██║   ██║ ╚███╔╝      ║"
    echo "║      ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║██║   ██║ ██╔██╗      ║"
    echo "║      ██║   ███████╗██║  ██║██║ ╚═╝ ██║╚██████╔╝██╔╝ ██╗     ║"
    echo "║      ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝     ║"
    echo "║                                                              ║"
    echo "║            T H E M E   M A S T E R   v$VERSION                ║"
    echo "║                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

show_menu() {
    echo -e "${GREEN}${BOLD}┌─────────────────────────────────────────────────────────┐${NC}"
    echo -e "${GREEN}${BOLD}│                    MENU UTAMA                           │${NC}"
    echo -e "${GREEN}${BOLD}├─────────────────────────────────────────────────────────┤${NC}"
    echo -e "${YELLOW}│  ${WHITE}[1]${CYAN} 🎨 Ganti Tema Warna                         ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[2]${CYAN} 🔤 Ganti Font Terminal                      ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[3]${CYAN} 👁️  Preview Tema Sekarang                   ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[4]${CYAN} 💾 Backup Tema Saat Ini                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[5]${CYAN} 🔄 Restore Backup Tema                      ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[6]${CYAN} 🌐 Download Tema dari URL                   ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[7]${CYAN} ✨ Reset ke Tema Default                    ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[8]${CYAN} ℹ️  Informasi Sistem                        ${YELLOW}│${NC}"
    echo -e "${YELLOW}│  ${WHITE}[0]${CYAN} 🚪 Keluar                                   ${YELLOW}│${NC}"
    echo -e "${GREEN}${BOLD}└─────────────────────────────────────────────────────────┘${NC}"
    echo -ne "${WHITE}${BOLD}Pilih menu: ${NC}"
}

# ==================== FUNGSI TEMA ====================

list_themes() {
    echo -e "\n${CYAN}${BOLD}📋 Daftar Tema Tersedia:${NC}\n"
    
    # Tema built-in
    echo -e "${GREEN}${BOLD}━━━━━━━ TEMA CLASSIC ━━━━━━━${NC}"
    echo -e "  ${WHITE}1)${YELLOW} Default      ${WHITE}- Tema standar Termux${NC}"
    echo -e "  ${WHITE}2)${YELLOW} Gruvbox      ${WHITE}- Dark theme khas editor${NC}"
    echo -e "  ${WHITE}3)${YELLOW} Nord         ${WHITE}- Tema dingin biru kehijauan${NC}"
    echo -e "  ${WHITE}4)${YELLOW} Dracula      ${WHITE}- Tema ungu gelap populer${NC}"
    echo -e "  ${WHITE}5)${YELLOW} Solarized    ${WHITE}- Tema klasik kontras rendah${NC}"
    echo -e "  ${WHITE}6)${YELLOW} Monokai      ${WHITE}- Tema colorful khas editor kode${NC}"
    echo -e "  ${WHITE}7)${YELLOW} One Dark     ${WHITE}- Tema gelap dari Atom editor${NC}"
    
    echo -e "\n${GREEN}${BOLD}━━━━━━━ TEMA PREMIUM ━━━━━━━${NC}"
    echo -e "  ${WHITE}8)${YELLOW} Cyberpunk    ${WHITE}- Neon neon cyberpunk style${NC}"
    echo -e "  ${WHITE}9)${YELLOW} Matrix       ${WHITE}- Hacker green style${NC}"
    echo -e " ${WHITE}10)${YELLOW} Sunset       ${WHITE}- Oranye merah sunset glow${NC}"
    echo -e " ${WHITE}11)${YELLOW} Oceanic      ${WHITE}- Biru dalam lautan${NC}"
    echo -e " ${WHITE}12)${YELLOW} Forest       ${WHITE}- Hijau hutan alami${NC}"
    
    echo -e "\n${GREEN}${BOLD}━━━━━━━ TEMA KUSTOM ━━━━━━━${NC}"
    echo -e " ${WHITE}13)${YELLOW} Buat Tema Sendiri${NC}"
    echo -e " ${WHITE}14)${YELLOW} Import dari File${NC}\n"
}

apply_theme() {
    local theme_name=$1
    local theme_file="$SCRIPT_DIR/themes/${theme_name}.properties"
    
    # Buat folder themes jika belum ada
    mkdir -p "$SCRIPT_DIR/themes"
    
    # Cek apakah tema sudah ada di folder
    if [ ! -f "$theme_file" ]; then
        # Buat tema dari template built-in
        create_theme_file "$theme_name" "$theme_file"
    fi
    
    # Backup konfigurasi lama
    if [ -f "$TERMUX_PROPERTIES" ]; then
        cp "$TERMUX_PROPERTIES" "$BACKUP_DIR/last_theme.properties"
    fi
    
    # Terapkan tema
    cp "$theme_file" "$TERMUX_PROPERTIES"
    
    # Reload konfigurasi
    termux-reload-settings
    
    echo -e "${GREEN}✓ Tema ${WHITE}$theme_name${GREEN} berhasil diterapkan!${NC}"
    echo -e "${YELLOW}💡 Tips: Tutup dan buka kembali Termux untuk melihat perubahan maksimal${NC}"
}

create_theme_file() {
    local name=$1
    local file=$2
    
    case $name in
        "Default")
            cat > "$file" << 'EOF'
# Default Termux Theme
background=#000000
foreground=#ffffff
cursor=#ffffff
color0=#000000
color1=#aa0000
color2=#00aa00
color3=#aa5500
color4=#0000aa
color5=#aa00aa
color6=#00aaaa
color7=#aaaaaa
color8=#555555
color9=#ff5555
color10=#55ff55
color11=#ffff55
color12=#5555ff
color13=#ff55ff
color14=#55ffff
color15=#ffffff
EOF
            ;;
        "Gruvbox")
            cat > "$file" << 'EOF'
# Gruvbox Dark Theme
background=#282828
foreground=#ebdbb2
cursor=#ebdbb2
color0=#282828
color1=#cc241d
color2=#98971a
color3=#d79921
color4=#458588
color5=#b16286
color6=#689d6a
color7=#a89984
color8=#928374
color9=#fb4934
color10=#b8bb26
color11=#fabd2f
color12=#83a598
color13=#d3869b
color14=#8ec07c
color15=#ebdbb2
EOF
            ;;
        "Nord")
            cat > "$file" << 'EOF'
# Nord Theme
background=#2e3440
foreground=#d8dee9
cursor=#d8dee9
color0=#3b4252
color1=#bf616a
color2=#a3be8c
color3=#ebcb8b
color4=#81a1c1
color5=#b48ead
color6=#88c0d0
color7=#e5e9f0
color8=#4c566a
color9=#bf616a
color10=#a3be8c
color11=#ebcb8b
color12=#81a1c1
color13=#b48ead
color14=#8fbcbb
color15=#eceff4
EOF
            ;;
        "Dracula")
            cat > "$file" << 'EOF'
# Dracula Theme
background=#282a36
foreground=#f8f8f2
cursor=#f8f8f2
color0=#000000
color1=#ff5555
color2=#50fa7b
color3=#f1fa8c
color4=#bd93f9
color5=#ff79c6
color6=#8be9fd
color7=#bfbfbf
color8=#4d4d4d
color9=#ff6e67
color10=#5af78e
color11=#f4f99d
color12=#caa9fa
color13=#ff92d0
color14=#9aedfe
color15=#e6e6e6
EOF
            ;;
        "Solarized")
            cat > "$file" << 'EOF'
# Solarized Dark Theme
background=#002b36
foreground=#839496
cursor=#839496
color0=#073642
color1=#dc322f
color2=#859900
color3=#b58900
color4=#268bd2
color5=#d33682
color6=#2aa198
color7=#eee8d5
color8=#002b36
color9=#cb4b16
color10=#586e75
color11=#657b83
color12=#839496
color13=#6c71c4
color14=#93a1a1
color15=#fdf6e3
EOF
            ;;
        "Monokai")
            cat > "$file" << 'EOF'
# Monokai Theme
background=#272822
foreground=#f8f8f2
cursor=#f8f8f2
color0=#272822
color1=#f92672
color2=#a6e22e
color3=#f4bf75
color4=#66d9ef
color5=#ae81ff
color6=#a1efe4
color7=#f8f8f2
color8=#75715e
color9=#f92672
color10=#a6e22e
color11=#f4bf75
color12=#66d9ef
color13=#ae81ff
color14=#a1efe4
color15=#f9f8f5
EOF
            ;;
        "One Dark")
            cat > "$file" << 'EOF'
# One Dark Theme
background=#282c34
foreground=#abb2bf
cursor=#528bff
color0=#282c34
color1=#e06c75
color2=#98c379
color3=#e5c07b
color4=#61afef
color5=#c678dd
color6=#56b6c2
color7=#abb2bf
color8=#5c6370
color9=#e06c75
color10=#98c379
color11=#e5c07b
color12=#61afef
color13=#c678dd
color14=#56b6c2
color15=#c8ccd4
EOF
            ;;
        "Cyberpunk")
            cat > "$file" << 'EOF'
# Cyberpunk Theme
background=#0a0a0a
foreground=#00ffcc
cursor=#00ffcc
color0=#0a0a0a
color1=#ff0055
color2=#00ffcc
color3=#ffcc00
color4=#0055ff
color5=#cc00ff
color6=#00ccff
color7=#cccccc
color8=#333333
color9=#ff3377
color10=#33ffdd
color11=#ffdd33
color12=#3377ff
color13=#dd33ff
color14=#33ddff
color15=#ffffff
EOF
            ;;
        "Matrix")
            cat > "$file" << 'EOF'
# Matrix Theme
background=#000000
foreground=#00ff00
cursor=#00ff00
color0=#000000
color1=#003300
color2=#00ff00
color3=#33ff33
color4=#006600
color5=#009900
color6=#00cc00
color7=#66ff66
color8=#004400
color9=#008800
color10=#00ff00
color11=#44ff44
color12=#00aa00
color13=#00dd00
color14=#55ff55
color15=#88ff88
EOF
            ;;
        *)
            # Default fallback
            cat > "$file" << 'EOF'
background=#000000
foreground=#ffffff
cursor=#ffffff
color0=#000000
color1=#aa0000
color2=#00aa00
color3=#aa5500
color4=#0000aa
color5=#aa00aa
color6=#00aaaa
color7=#aaaaaa
color8=#555555
color9=#ff5555
color10=#55ff55
color11=#ffff55
color12=#5555ff
color13=#ff55ff
color14=#55ffff
color15=#ffffff
EOF
            ;;
    esac
}

# ==================== FUNGSI FONT ====================

list_fonts() {
    echo -e "\n${CYAN}${BOLD}📋 Daftar Font Tersedia:${NC}\n"
    echo -e "  ${WHITE}1)${YELLOW} Default       ${WHITE}- Font standar Termux${NC}"
    echo -e "  ${WHITE}2)${YELLOW} Hack          ${WHITE}- Font monospace populer${NC}"
    echo -e "  ${WHITE}3)${YELLOW} Fira Code     ${WHITE}- Dengan ligatures${NC}"
    echo -e "  ${WHITE}4)${YELLOW} Source Code   ${WHITE}- Font dari Adobe${NC}"
    echo -e "  ${WHITE}5)${YELLOW} JetBrains     ${WHITE}- Font dari JetBrains${NC}"
    echo -e "  ${WHITE}6)${YELLOW} Cascadia      ${WHITE}- Font dari Microsoft${NC}"
    echo -e "  ${WHITE}7)${YELLOW} Ubuntu Mono   ${WHITE}- Font khas Ubuntu${NC}"
}

apply_font() {
    local font_name=$1
    local font_url=""
    
    case $font_name in
        "Hack")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf"
            ;;
        "Fira Code")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf"
            ;;
        "Source Code")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/SauceCodeProNerdFont-Regular.ttf"
            ;;
        "JetBrains")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
            ;;
        "Cascadia")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/CascadiaCode/Regular/CaskaydiaCoveNerdFont-Regular.ttf"
            ;;
        "Ubuntu Mono")
            font_url="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/UbuntuMono/Regular/UbuntuMonoNerdFont-Regular.ttf"
            ;;
        *)
            echo -e "${RED}Font tidak dikenal, menggunakan default${NC}"
            rm -f "$TERMUX_FONT"
            termux-reload-settings
            return
            ;;
    esac
    
    echo -e "${YELLOW}⏳ Mengunduh font $font_name...${NC}"
    curl -L -o "$TERMUX_FONT" "$font_url"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Font $font_name berhasil diunduh${NC}"
        termux-reload-settings
        echo -e "${YELLOW}💡 Restart Termux untuk melihat perubahan font${NC}"
    else
        echo -e "${RED}✗ Gagal mengunduh font${NC}"
    fi
}

# ==================== FUNGSI PREVIEW ====================

preview_theme() {
    echo -e "\n${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}${BOLD}                    PREVIEW TEMA                          ${NC}"
    echo -e "${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${RED}  ██ ${GREEN}██ ${YELLOW}██ ${BLUE}██ ${PURPLE}██ ${CYAN}██ ${WHITE}██ ${NC}- Warna foreground"
    echo -e "${RED}  ██ ${GREEN}██ ${YELLOW}██ ${BLUE}██ ${PURPLE}██ ${CYAN}██ ${WHITE}██ ${NC}- Warna background\n"
    
    echo -e "${WHITE}┌─────────────────────────────────────────────────┐${NC}"
    echo -e "${WHITE}│${GREEN}  user@termux ${WHITE}:${BLUE}~${WHITE}\$ ${YELLOW}ls -la${WHITE}                          │${NC}"
    echo -e "${WHITE}│${CYAN}  total 48${WHITE}                                          │${NC}"
    echo -e "${WHITE}│${GREEN}  drwx------${WHITE}  ${PURPLE}user${WHITE}  ${PURPLE}user${WHITE}  4096 ${YELLOW}Jan 20 10:00${WHITE}  .${NC}"
    echo -e "${WHITE}│${GREEN}  -rw-r--r--${WHITE}  ${PURPLE}user${WHITE}  ${PURPLE}user${WHITE}  1234 ${YELLOW}Jan 20 09:00${WHITE}  README.md${NC}"
    echo -e "${WHITE}│${GREEN}  -rwxr-xr-x${WHITE}  ${PURPLE}user${WHITE}  ${PURPLE}user${WHITE}  5678 ${YELLOW}Jan 19 15:30${WHITE}  script.sh${NC}"
    echo -e "${WHITE}│${RED}  error: file not found${WHITE}                              │${NC}"
    echo -e "${WHITE}└─────────────────────────────────────────────────┘${NC}\n"
    
    echo -e "${CYAN}💡 Ini adalah tampilan perkiraan. Warna asli akan terlihat setelah diterapkan.${NC}\n"
    
    echo -ne "${WHITE}Tekan Enter untuk kembali...${NC}"
    read
}

# ==================== FUNGSI BACKUP & RESTORE ====================

backup_theme() {
    mkdir -p "$BACKUP_DIR"
    
    if [ -f "$TERMUX_PROPERTIES" ]; then
        cp "$TERMUX_PROPERTIES" "$BACKUP_DIR/backup_$(date +%Y%m%d_%H%M%S).properties"
        echo -e "${GREEN}✓ Backup berhasil disimpan di $BACKUP_DIR${NC}"
    else
        echo -e "${RED}✗ Tidak ada konfigurasi tema yang ditemukan${NC}"
    fi
    
    if [ -f "$TERMUX_FONT" ]; then
        cp "$TERMUX_FONT" "$BACKUP_DIR/font_$(date +%Y%m%d_%H%M%S).ttf"
        echo -e "${GREEN}✓ Backup font berhasil disimpan${NC}"
    fi
}

restore_backup() {
    echo -e "\n${CYAN}${BOLD}📋 Daftar Backup Tersedia:${NC}\n"
    
    backups=($(ls -t "$BACKUP_DIR"/*.properties 2>/dev/null))
    
    if [ ${#backups[@]} -eq 0 ]; then
        echo -e "${RED}✗ Tidak ada backup ditemukan${NC}"
        return
    fi
    
    for i in "${!backups[@]}"; do
        backup_name=$(basename "${backups[$i]}")
        echo -e "  ${WHITE}$((i+1)))${YELLOW} $backup_name${NC}"
    done
    
    echo -ne "\n${WHITE}Pilih backup (0 untuk batal): ${NC}"
    read choice
    
    if [ "$choice" -gt 0 ] && [ "$choice" -le "${#backups[@]}" ]; then
        selected="${backups[$((choice-1))]}"
        cp "$selected" "$TERMUX_PROPERTIES"
        termux-reload-settings
        echo -e "${GREEN}✓ Backup berhasil direstorasi${NC}"
    fi
}

# ==================== FUNGSI DOWNLOAD TEMA ====================

download_theme() {
    echo -ne "\n${WHITE}Masukkan URL file tema (.properties): ${NC}"
    read url
    
    if [ -z "$url" ]; then
        echo -e "${RED}✗ URL tidak boleh kosong${NC}"
        return
    fi
    
    echo -e "${YELLOW}⏳ Mengunduh tema...${NC}"
    mkdir -p "$SCRIPT_DIR/themes"
    
    filename="custom_$(date +%Y%m%d_%H%M%S).properties"
    
    curl -L -o "$SCRIPT_DIR/themes/$filename" "$url"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Tema berhasil diunduh${NC}"
        echo -e "${YELLOW}💡 Gunakan menu 1 dan pilih tema 'custom' untuk menerapkan${NC}"
    else
        echo -e "${RED}✗ Gagal mengunduh tema${NC}"
    fi
}

# ==================== FUNGSI RESET ====================

reset_to_default() {
    echo -e "${YELLOW}⚠️  Anda akan mereset semua pengaturan tema ke default${NC}"
    echo -ne "${WHITE}Yakin? (y/n): ${NC}"
    read confirm
    
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        rm -f "$TERMUX_PROPERTIES"
        rm -f "$TERMUX_FONT"
        termux-reload-settings
        echo -e "${GREEN}✓ Pengaturan telah direset ke default${NC}"
        echo -e "${YELLOW}💡 Restart Termux untuk melihat perubahan${NC}"
    else
        echo -e "${CYAN}Reset dibatalkan${NC}"
    fi
}

# ==================== FUNGSI INFORMASI ====================

show_info() {
    echo -e "\n${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}${BOLD}                    INFORMASI SISTEM                       ${NC}"
    echo -e "${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${WHITE}📱 Aplikasi:${NC} Termux Theme Master"
    echo -e "${WHITE}📌 Versi:${NC} $VERSION"
    echo -e "${WHITE}👤 Author:${NC} Project Simura"
    echo -e "${WHITE}📁 Config Dir:${NC} $TERMUX_CONFIG"
    echo -e "${WHITE}💾 Backup Dir:${NC} $BACKUP_DIR\n"
    
    if [ -f "$TERMUX_PROPERTIES" ]; then
        echo -e "${GREEN}✓ Tema aktif terdeteksi${NC}"
    else
        echo -e "${YELLOW}○ Menggunakan tema default${NC}"
    fi
    
    if [ -f "$TERMUX_FONT" ]; then
        echo -e "${GREEN}✓ Font kustom terdeteksi${NC}"
    else
        echo -e "${YELLOW}○ Menggunakan font default${NC}"
    fi
    
    echo -e "\n${CYAN}💡 Tips:${NC}"
    echo -e "  • Gunakan fitur backup sebelum mengganti tema"
    echo -e "  • Restart Termux untuk hasil maksimal"
    echo -e "  • Cari lebih banyak tema di GitHub: 'termux style'"
    echo -e "\n${WHITE}Tekan Enter untuk kembali...${NC}"
    read
}

# ==================== FUNGSI BUAT TEMA SENDIRI ====================

create_custom_theme() {
    echo -e "\n${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}${BOLD}                 BUAT TEMA SENDIRI                        ${NC}"
    echo -e "${CYAN}${BOLD}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
    
    echo -e "${WHITE}Masukkan nilai warna dalam format HEX (contoh: #ff0000)${NC}\n"
    
    echo -ne "${RED}Warna 1 (merah)   : ${NC}"
    read c1
    echo -ne "${GREEN}Warna 2 (hijau)   : ${NC}"
    read c2
    echo -ne "${YELLOW}Warna 3 (kuning) : ${NC}"
    read c3
    echo -ne "${BLUE}Warna 4 (biru)    : ${NC}"
    read c4
    echo -ne "${PURPLE}Warna 5 (ungu)   : ${NC}"
    read c5
    echo -ne "${CYAN}Warna 6 (cyan)    : ${NC}"
    read c6
    echo -ne "${WHITE}Background       : ${NC}"
    read bg
    echo -ne "${WHITE}Foreground       : ${NC}"
    read fg
    
    # Simpan tema custom
    mkdir -p "$SCRIPT_DIR/themes"
    custom_file="$SCRIPT_DIR/themes/custom_$(date +%Y%m%d_%H%M%S).properties"
    
    cat > "$custom_file" << EOF
background=$bg
foreground=$fg
cursor=$fg
color0=$bg
color1=$c1
color2=$c2
color3=$c3
color4=$c4
color5=$c5
color6=$c6
color7=$fg
color8=${bg}80
color9=$c1
color10=$c2
color11=$c3
color12=$c4
color13=$c5
color14=$c6
color15=$fg
EOF
    
    echo -e "\n${GREEN}✓ Tema custom berhasil dibuat: $(basename $custom_file)${NC}"
    echo -ne "${WHITE}Terapkan sekarang? (y/n): ${NC}"
    read apply_now
    
    if [ "$apply_now" = "y" ] || [ "$apply_now" = "Y" ]; then
        cp "$custom_file" "$TERMUX_PROPERTIES"
        termux-reload-settings
        echo -e "${GREEN}✓ Tema custom diterapkan!${NC}"
    fi
}

# ==================== MAIN PROGRAM ====================

# Setup awal
setup() {
    # Buat direktori Termux config jika belum ada
    mkdir -p "$TERMUX_CONFIG"
    mkdir -p "$BACKUP_DIR"
    mkdir -p "$SCRIPT_DIR/themes"
    
    # Cek apakah termux-reload-settings ada
    if ! command -v termux-reload-settings &> /dev/null; then
        echo -e "${YELLOW}⚠️  Perintah 'termux-reload-settings' tidak ditemukan${NC}"
        echo -e "${YELLOW}   Pastikan Anda menjalankan script ini di Termux${NC}"
    fi
}

# Main loop
main() {
    setup
    
    while true; do
        print_banner
        show_menu
        read choice
        
        case $choice in
            1)
                list_themes
                echo -ne "\n${WHITE}Pilih tema (1-14): ${NC}"
                read theme_choice
                case $theme_choice in
                    1) apply_theme "Default" ;;
                    2) apply_theme "Gruvbox" ;;
                    3) apply_theme "Nord" ;;
                    4) apply_theme "Dracula" ;;
                    5) apply_theme "Solarized" ;;
                    6) apply_theme "Monokai" ;;
                    7) apply_theme "One Dark" ;;
                    8) apply_theme "Cyberpunk" ;;
                    9) apply_theme "Matrix" ;;
                    10) apply_theme "Sunset" ;;
                    11) apply_theme "Oceanic" ;;
                    12) apply_theme "Forest" ;;
                    13) create_custom_theme ;;
                    14) download_theme ;;
                    *) echo -e "${RED}Pilihan tidak valid${NC}" ;;
                esac
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            2)
                list_fonts
                echo -ne "\n${WHITE}Pilih font (1-7): ${NC}"
                read font_choice
                case $font_choice in
                    1) echo -e "${YELLOW}Menggunakan font default${NC}"
                       rm -f "$TERMUX_FONT"
                       termux-reload-settings
                       ;;
                    2) apply_font "Hack" ;;
                    3) apply_font "Fira Code" ;;
                    4) apply_font "Source Code" ;;
                    5) apply_font "JetBrains" ;;
                    6) apply_font "Cascadia" ;;
                    7) apply_font "Ubuntu Mono" ;;
                    *) echo -e "${RED}Pilihan tidak valid${NC}" ;;
                esac
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            3)
                preview_theme
                ;;
            4)
                backup_theme
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            5)
                restore_backup
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            6)
                download_theme
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            7)
                reset_to_default
                echo -ne "\n${WHITE}Tekan Enter untuk melanjutkan...${NC}"
                read
                ;;
            8)
                show_info
                ;;
            0)
                echo -e "\n${GREEN}Terima kasih telah menggunakan Termux Theme Master!${NC}"
                echo -e "${CYAN}Sampai jumpa! 👋${NC}\n"
                exit 0
                ;;
            *)
                echo -e "${RED}Pilihan tidak valid!${NC}"
                sleep 1
                ;;
        esac
    done
}

# Jalankan program
main
