# LenovoWarrantyScanner

## About

Welcome to **LenovoWarrantyScanner**, a PowerShell-based tool for bulk Lenovo warranty lookups built by Mohammed AlAttar, Senior Systems Engineer with 19+ years of IT experience. This tool was developed to support enterprise IT asset management and audit readiness — specifically designed to cross-check thousands of Lenovo device serials against Lenovo's warranty API and populate an asset inventory with accurate purchase year and device age data.

Built and battle-tested across 750+ devices during a live IT General Control Review audit.

---

## What It Does

- Loads a list of serial numbers from a text file (`serials.txt`)
- Queries the **Lenovo Warranty API** for each serial
- Returns:
  - ✅ Purchase year
  - ✅ Device age in years
  - ✅ Warranty status (Active / Expired / Unknown)
  - ✅ Model name
- Exports results to a structured CSV (`warranty_results.csv`)
- Progress shown in real-time with color-coded output

---

## Requirements

- Windows PowerShell 5.1+ or PowerShell 7+
- Internet access (queries `pcsupport.lenovo.com`)
- A `serials.txt` file with one serial number per line

---

## Usage

### Step 1 — Prepare your serial list

Create a file called `serials.txt` in the same folder as the script:

```
PFXXXXXX
LRXXXXXX
```

One serial per line. Supports all Lenovo serial formats (ThinkPad, ThinkBook, Legion, IdeaPad, LOQ, etc.)

---

### Step 2 — Run the script

```powershell
.\Run-WarrantyCheck.ps1
```

---

### Step 3 — Sample Output

```
Loaded 500 serials from serials.txt

  [  1/500]  2ZXXXXX                 Age: 0 yrs  Purchased: 2026
  [ 11/500]  PFXXXXX     Expired     Age: 7.1 yrs  Purchased: 2019  E590
  [ 23/500]  PFXXXXX     Expired     Age: 2.6 yrs  Purchased: 2023  E16 Gen 1
  [ 95/500]  PFXXXXX     Active      Age: 2 yrs   Purchased: 2024  E16 Gen 1
  [120/500]  PFXXXXX     Active      Age: 1.2 yrs Purchased: 2025  E16 Gen 2
```

---

### Step 4 — CSV Output

Results saved to `warranty_results.csv`:

| Serial | Status | Year Purchased | Laptop Age (Yrs) | Model |
|--------|--------|----------------|------------------|-------|
| PFXXXXX | Expired | 2019 | 7.1 | ThinkPad E590 |
| PFXXXXX | Active  | 2024 | 2.0 | ThinkPad E16 Gen 1 |
| PFXXXXX | Active  | 2025 | 1.2 | ThinkPad E16 Gen 2 |

---

## Updating Your Asset Inventory

After running the script, use the companion Python script to merge warranty results into your Excel inventory:

```powershell
python update_inventory.py
```

This will:
- Match serials between `warranty_results.csv` and your `Asset_Inventory.xlsx`
- Update **Year of Purchase** and **Laptop Age (Yrs)** columns
- Leave all other columns untouched
- Export the updated file as `Asset_Inventory_updated.xlsx`

**Cross-check verification is built in** — the script validates every row after update and reports:
- ✅ Correct rows
- ❌ Any mismatches
- ⏭️ Serials not found in warranty data

---

## File Structure

```
LenovoWarrantyScanner/
├── Run-WarrantyCheck.ps1       # Main warranty lookup script
├── update_inventory.py         # Merges results into Excel inventory
├── serials.txt                 # Your input serial numbers (one per line)
├── warranty_results.csv        # Output from warranty check
└── README.md
```

---

## Use Case — IT Asset Audit

This tool was purpose-built to support IT General Control Reviews and asset audits covering:

| Scope | Coverage |
|-------|----------|
| Asset Inventory | Serial, model, purchase year |
| Asset Classification | Device age, warranty status |
| Asset Acquisition | Year purchased from Lenovo API |
| Asset Deployment | Laptop age calculation |
| Asset Maintenance | Warranty active / expired status |

750+ Lenovo devices processed in a single run. Results cross-validated against terminal output with **zero errors**.

---

## Supported Lenovo Series

| Series | Examples |
|--------|---------|
| ThinkPad E Series | E590, E15 Gen 2/4, E16 Gen 1/2/3 |
| ThinkPad T Series | T14 Gen 4/6, T15 Gen 2, T16 Gen 2 |
| ThinkPad X Series | X1 Carbon, X270, X13 Gen 5 |
| ThinkPad P Series | P14s Gen 5, P16s Gen 3/4, P16v Gen 2 |
| ThinkBook | ThinkBook 15, ThinkBook 16 G8 |
| Legion | Legion 5, Legion 9, Legion Pro 5/7 |
| LOQ | LOQ 15IRX9, LOQ 15IRX10 |
| IdeaPad | IdeaPad 5 2-in-1 |
| Yoga | Yoga Slim 7, Yoga Pro 7 |
| V Series | Lenovo V15 G4 |
| L Series | L14 Gen 4/6 |
| E Series (Commercial) | E14, E15, E16 |

---

## Notes

- Serials with spaces (e.g. `PF5WRY AQ`) are handled automatically — the script strips whitespace before querying
- Duplicate serials in the input list are processed but flagged
- Devices with no Lenovo warranty record return `Age: 0 yrs  Purchased: 2026` — these require manual verification
- Non-Lenovo serials (HP, Dell, Mac, etc.) return no data and are safely skipped

---

## Professional Summary

Built by **Mohammed AlAttar** — Senior Systems Engineer with 19+ years of IT experience.

Master's degree in Computer Security Engineering & Artificial Intelligence | BSc in Information Technology

### Certifications

- **CISM** — Certified Information Security Manager
- **PMP** — Project Management Professional
- **ITIL 4 Foundation**
- **AWS Certified Solutions Architect – Associate**
- **CompTIA Security+**
- **Microsoft 365 Certified: Endpoint Administrator Associate**
- **Microsoft Certified Azure Administrator Associate**

---

## Contact

For inquiries or collaboration:

- **Email**: [mozalattar@gmail.com](mailto:mozalattar@gmail.com)
- **LinkedIn**: [Mohammed AlAttar](https://www.linkedin.com/in/mohammed-z-alattar/)
- **GitHub**: [mozalattar](https://github.com/mozalattar)

---

> *Built to solve real problems. Tested on real audits.*
