#!/bin/bash

# Nama file README
readme_file="README.md"

# Konten README dalam format Markdown
readme_content="
# 🛠️ recontol

**recontol** adalah *wrapper toolset* sederhana namun kuat yang mengotomatisasi proses *reconnaissance* untuk *bug bounty* dan *red teaming*. Dirancang untuk menghemat waktumu dan memaksimalkan efisiensi dengan menggabungkan *tools* Go-based terpopuler ke dalam satu alur kerja yang rapi.

---

## 🚀 Fitur Unggulan

- **Otomatisasi Penuh**: Mengotomatisasi penemuan aset menggunakan *tools* terbaik seperti \`assetfinder\`, \`waybackurls\`, \`httpx\`, dan lainnya.
- **Ringan & Cepat**: Berbasis *bash script* sehingga ringan dan dapat berjalan di semua sistem berbasis *nix*.
- **Mudah Diperluas**: Kamu dapat dengan mudah menambahkan *tools recon* favoritmu ke dalam skrip utama.
- **Laporan Terstruktur**: Menghasilkan laporan ringkasan yang rapi dan mudah dibaca, sambil tetap menyimpan *output* mentah untuk analisis mendalam.

---

## ⚙️ Persiapan

Sebelum menggunakan **recontol**, pastikan kamu memiliki lingkungan yang tepat. **recontol** mengandalkan beberapa *tools* penting yang sebagian besar dibangun di atas Go.

### 1. Instalasi Go

Pastikan **Go** sudah terinstal di sistemmu. Kamu bisa mengunduhnya dari [situs resmi Go](https://go.dev/doc/install) atau menggunakan manajer paket (misalnya \`sudo apt install golang\`).

### 2. Instalasi Tools

**recontol** membutuhkan *tools* berikut untuk berfungsi dengan baik. Kami telah menyertakan skrip \`install.sh\` untuk mempermudah proses ini.

\`\`\`bash
# Beri izin eksekusi pada skrip instalasi
chmod +x install.sh

# Jalankan skrip instalasi
./install.sh
\`\`\`

**Penting:** Jika kamu mengalami masalah saat instalasi, ini biasanya disebabkan oleh dependensi sistem yang hilang. Kamu perlu menginstal beberapa paket tambahan:

- **\`libpcap-dev\`**: Dibutuhkan oleh \`naabu\` untuk pemindaian paket.
  \`\`\`bash
  sudo apt-get install libpcap-dev
  \`\`\`
- **\`jq\`**: Diperlukan untuk memproses *output* JSON dari \`httpx\` dan \`nuclei\` agar dapat membuat laporan ringkasan.
  \`\`\`bash
  sudo apt-get install jq
  \`\`\`
Setelah instalasi paket-paket ini, coba jalankan kembali \`install.sh\`.

---

## 📖 Penggunaan

Penggunaan **recontol** sangat sederhana. Cukup berikan nama domain sebagai argumen pertama.

\`\`\`bash
# Beri izin eksekusi pada skrip utama
chmod +x recontol.sh

# Jalankan recontol
./recontol.sh <domain.com>

# Contoh:
./recontol.sh example.com
\`\`\`

Setelah selesai, semua *output* akan disimpan di dalam sebuah direktori bernama \`recontol-<domain>-<timestamp>\`. Kamu bisa menemukan laporan ringkasan di \`recontol-<domain>-<timestamp>/summary_report.txt\` dan semua hasil mentah di sub-direktori \`recon/\`, \`scans/\`, dan \`visuals/\`.

---

## ⚠️ Penjelasan Masalah Umum

### \`hakrawler\` Error

Jika kamu melihat \`flag provided but not defined: -depth\`, ini berarti versi \`hakrawler\` kamu tidak mendukung *flag* \`--depth\`. Pastikan skrip \`recontol.sh\` menggunakan *flag* yang benar, yaitu \`-d\`.

### \`no such pattern\` pada \`gf\`

Ini terjadi karena *patterns* \`gf\` tidak ditemukan. Meskipun skrip \`install.sh\` sudah menyertakan langkah untuk mengunduhnya, pastikan \`~/.gf\` sudah berisi file-file pola yang diperlukan.

### \`invalid CIDR address\` pada \`mapcidr\`

*Error* ini muncul ketika \`httpx\` gagal mengambil alamat IP. Baris \`cut\` pada skrip telah diperbarui untuk menyaring *output* dengan lebih baik dan hanya melewatkan IP yang valid ke \`mapcidr\`.

### \`jq: command not found\`

Seperti yang sudah dijelaskan di bagian persiapan, \`jq\` adalah dependensi penting untuk memproses *output* JSON. Pastikan kamu sudah menginstalnya menggunakan \`sudo apt-get install jq\`.
"
