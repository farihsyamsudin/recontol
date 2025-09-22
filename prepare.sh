#!/bin/bash

# Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Fungsi untuk memeriksa keberadaan perintah
function check_command() {
    if command -v "$1" &>/dev/null; then
        return 0
    else
        return 1
    fi
}

# Fungsi untuk menginstal Go jika belum terpasang
function install_go() {
    echo -e "${YELLOW}Go tidak ditemukan. Memulai instalasi Go...${NC}"
    if check_command "sudo"; then
        sudo apt update
        sudo apt install -y golang
    else
        echo -e "${RED}Tidak dapat menginstal Go secara otomatis. Silakan instal secara manual dari https://go.dev/doc/install${NC}"
        exit 1
    fi
}

# Periksa apakah Go sudah terinstal
if ! check_command "go"; then
    install_go
fi

echo -e "${GREEN}✅ Go ditemukan. Memulai instalasi tools...${NC}"

# Path tempat binary akan diletakkan
# Periksa apakah GOPATH sudah diset, jika tidak, atur default
if [ -z "$GOPATH" ]; then
    export GOPATH="$HOME/go"
    echo -e "${YELLOW}GOPATH tidak diset, menggunakan default: $GOPATH${NC}"
fi

# Tambahkan ke PATH jika belum ada
BIN_PATH="$GOPATH/bin"
if [[ ":$PATH:" != *":$BIN_PATH:"* ]]; then
    echo -e "${YELLOW}📌 Menambahkan $BIN_PATH ke PATH Anda...${NC}"
    echo 'export PATH=$PATH:'"$BIN_PATH" >> "$HOME/.bashrc"
    echo 'export PATH=$PATH:'"$BIN_PATH" >> "$HOME/.zshrc" # Mendukung zsh
    export PATH="$PATH:$BIN_PATH"
fi

# Daftar tools yang akan diinstal
GO_TOOLS=(
    github.com/projectdiscovery/dnsx/cmd/dnsx
    github.com/projectdiscovery/httpx/cmd/httpx
    github.com/projectdiscovery/nuclei/v3/cmd/nuclei
    github.com/projectdiscovery/mapcidr/cmd/mapcidr
    github.com/projectdiscovery/naabu/v2/cmd/naabu
    github.com/tomnomnom/assetfinder
    github.com/tomnomnom/waybackurls
    github.com/tomnomnom/unfurl
    github.com/tomnomnom/gf
    github.com/hakluke/hakrawler
    github.com/bp0lr/gauplus
    github.com/sensepost/gowitness
)

# Loop untuk install semuanya
for TOOL in "${GO_TOOLS[@]}"; do
    echo -e "${BLUE}📦 Menginstal $TOOL...${NC}"
    go install "$TOOL@latest"
done

# Instalasi GF patterns
echo -e "${BLUE}📦 Mengunduh dan menginstal GF patterns...${NC}"
GF_DIR="$HOME/.gf"
if [ ! -d "$GF_DIR" ]; then
    mkdir -p "$GF_DIR"
fi
git clone https://github.com/1310-9/gf-patterns.git "$GF_DIR" >/dev/null 2>&1
echo -e "${GREEN}✅ GF patterns berhasil diinstal.${NC}"

echo ""
echo -e "${GREEN}✅ Semua tools berhasil diinstal ke: $BIN_PATH${NC}"
echo -e "${YELLOW}ℹ️ Penting: Buka ulang terminal atau jalankan: ${NC}"
echo -e "${YELLOW}   source ~/.bashrc${NC}"
echo -e "${YELLOW}   source ~/.zshrc${NC}"
echo -e "${YELLOW}   (tergantung shell yang Anda gunakan)${NC}"

# Opsional: cek semua tool sudah ada
echo ""
echo -e "${BLUE}🧪 Mengecek versi masing-masing tools...${NC}"
for TOOL in dnsx httpx nuclei mapcidr naabu assetfinder waybackurls unfurl gf hakrawler gauplus gowitness; do
    if check_command "$TOOL"; then
        echo -e "${GREEN}✅ $TOOL ditemukan${NC}"
    else
        echo -e "${RED}❌ $TOOL TIDAK ditemukan${NC}"
    fi
done