# 🛠️ Recontol

**Recontol** is a lightweight bash script that automates common recon (reconnaissance) tasks for bug bounty and pentesting workflows. With a single command, it chains together powerful tools like:

- [`assetfinder`](https://github.com/tomnomnom/assetfinder)
- [`waybackurls`](https://github.com/tomnomnom/waybackurls)
- [`dnsx`](https://github.com/projectdiscovery/dnsx)
- [`httpx`](https://github.com/projectdiscovery/httpx)
- [`nuclei`](https://github.com/projectdiscovery/nuclei)
- [`gauplus`](https://github.com/bp0lr/gauplus)
- [`hakrawler`](https://github.com/hakluke/hakrawler)
- [`unfurl`](https://github.com/tomnomnom/unfurl)
- [`mapcidr`](https://github.com/projectdiscovery/mapcidr)
- and more...

> Reconnaissance should be powerful, fast, and repeatable – and that’s exactly what `recontol` provides.

---

## ⚙️ Installation

### 1. Clone or copy the script

If you already have the script locally:

```bash
sudo cp recontol /usr/local/bin/
sudo chmod +x /usr/local/bin/recontol
