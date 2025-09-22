# 🛠️ recontol

**recontol** adalah sebuah *wrapper toolset* sederhana namun kuat yang mengotomatisasi proses *reconnaissance* untuk *bug bounty* dan *red teaming*. Dirancang untuk menghemat waktu dan memaksimalkan efisiensi dengan menggabungkan beberapa tool Go-based populer ke dalam satu alur kerja yang rapi.

---

## 🔎 Ringkasan

* **Tujuan:** Mengumpulkan aset, URL, dan hasil pemindaian dasar secara otomatis untuk mempercepat fase reconnaissance.
* **Pendekatan:** Bash script yang memanggil tool populer (mis. `assetfinder`, `waybackurls`, `httpx`, `naabu`, `nuclei`) lalu menyimpan output mentah dan ringkasan laporan.

---

## 🚀 Fitur Utama

* Otomatisasi alur recon (asset discovery → endpoint harvesting → HTTP probing → scanning dasar).
* Output terstruktur: folder per-domain dengan subfolder `recon/`, `scans/`, `visuals/` dan file ringkasan `summary_report.txt`.
* Ringan dan portabel — berbasis Bash sehingga mudah dijalankan pada mesin Linux/macOS.
* Mudah diperluas — tambahkan tool atau step baru cukup dengan mengedit skrip utama.

---

## ⚙️ Prasyarat

Sebelum menjalankan `recontol`, pastikan:

1. **Go** terinstal (untuk mengompilasi/menjalankan beberapa tool berbasis Go).

   * Unduh dari [https://go.dev/doc/install](https://go.dev/doc/install) atau pasang lewat paket manager (contoh: `sudo apt install golang`).

2. Tool-tool recon yang diperlukan (bisa diinstal otomatis lewat `install.sh` yang disediakan):

   * assetfinder
   * waybackurls
   * httpx
   * naabu
   * nuclei
   * hakrawler
   * gf (pola-pola `~/.gf`)

3. Dependensi sistem:

* `libpcap-dev` (untuk `naabu`):

```bash
sudo apt-get install libpcap-dev
```

* `jq` (memproses output JSON untuk ringkasan):

```bash
sudo apt-get install jq
```

> Jika di macOS: gunakan `brew install jq` dan `brew install libpcap` (jika perlu).

---

## 🛠️ Instalasi

1. Beri izin eksekusi pada skrip instalasi:

```bash
chmod +x install.sh
```

2. Jalankan skrip instalasi:

```bash
./install.sh
```

`install.sh` dirancang untuk mengunduh/menyiapkan tool yang diperlukan. Jika terjadi error, baca pesan error dan pastikan dependensi sistem telah dipasang.

---

## 📦 Cara Pakai

1. Beri izin eksekusi pada skrip utama:

```bash
chmod +x recontol.sh
```

2. Jalankan `recontol` dengan domain target:

```bash
./recontol.sh <domain.com>
# Contoh
./recontol.sh example.com
```

3. Output disimpan di direktori:

```
recontol-<domain>-<timestamp>/
├─ recon/        # hasil asset discovery & harvesting
├─ scans/        # hasil pemindaian (naabu, nuclei, dll.)
├─ visuals/      # file gambar/visualisasi (jika ada)
└─ summary_report.txt
```

---

## 📋 Format Laporan

`summary_report.txt` berisi ringkasan hasil penting (total host, service port yang ditemukan, temuan Nuclei yang signifikan, dsb.) disusun dari output mentah yang diolah dengan `jq` dan utilitas shell.

---

## ⚠️ Permasalahan Umum & Solusi

* **`flag provided but not defined: -depth` (hakrawler)**

  * Penyebab: versi `hakrawler` yang terpasang tidak mendukung flag `--depth`.
  * Solusi: gunakan flag `-d` yang didukung, atau perbarui skrip agar sesuai dengan versi `hakrawler` yang terinstal.

* **`jq: command not found`**

  * Pastikan `jq` sudah terpasang: `sudo apt-get install jq` (atau `brew install jq`).

* **`no such pattern` pada `gf`**

  * Pastikan folder `~/.gf` berisi pola-pola yang benar. Jika belum ada, unduh koleksi pola GF (misal dari repo pola `gf`) dan letakkan di `~/.gf`.

* **`invalid CIDR address` pada `mapcidr`**

  * Biasanya disebabkan oleh output IP yang kotor dari `httpx`. Skrip telah menyaring IP, tetapi jika error masih muncul, cek baris yang mem-parsing IP dan pastikan hanya IP yang valid diteruskan ke `mapcidr`.

---

## 📝 Tips & Best Practices

* Jalankan di lingkungan terisolasi (VM atau container) saat memindai target yang sensitif.
* Selalu pastikan kamu memiliki izin eksplisit untuk melakukan recon/scan pada target (bounty program rules, written authorization, dsb.).
* Simpan hasil mentah untuk audit dan reproduksi.

---

## 📣 Kontribusi

Kontribusi sangat diterima! Buat *issue* atau *pull request* untuk:

* Menambahkan/menyesuaikan tool
* Memperbaiki bug
* Menambah dokumentasi atau contoh konfigurasi

---

## ✉️ Kontak

Jika ada pertanyaan atau ingin berdiskusi fitur baru, buka issue di repository atau hubungi maintainer proyek.

> *Catatan: Selalu patuhi hukum dan kebijakan target sebelum menjalankan tool ini.*
