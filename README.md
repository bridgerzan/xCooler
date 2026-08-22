<div align="center">

# ⚡ xCooler

### Windows Power Management, tuned for smoother gaming.

<p>
  <a href="https://github.com/bridgerzan/xCooler/releases">
    <img src="https://img.shields.io/github/v/release/bridgerzan/xCooler?style=for-the-badge&color=00D9FF&label=release" alt="Release">
  </a>
  <a href="https://github.com/bridgerzan/xCooler/stargazers">
    <img src="https://img.shields.io/github/stars/bridgerzan/xCooler?style=for-the-badge&color=00D9FF" alt="Stars">
  </a>
  <a href="https://github.com/bridgerzan/xCooler/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/bridgerzan/xCooler?style=for-the-badge&color=00D9FF" alt="License">
  </a>
</p>

<p>
  <img src="https://img.shields.io/badge/Windows-10%20%7C%2011-00D9FF?style=flat-square" alt="Windows">
  <img src="https://img.shields.io/badge/PowerShell-5%2B-00D9FF?style=flat-square" alt="PowerShell">
  <img src="https://img.shields.io/badge/Lightweight-00D9FF?style=flat-square" alt="Lightweight">
</p>

<br>

<a href="https://github.com/bridgerzan/xCooler">
  <img src="https://raw.githubusercontent.com/bridgerzan/xCooler/main/assets/banner.png" alt="xCooler Banner" width="850">
</a>

<br>

<p>
  <strong>Lightweight</strong>
  &nbsp;•&nbsp;
  <strong>Transparent</strong>
  &nbsp;•&nbsp;
  <strong>Reversible</strong>
</p>

</div>

---

## ⚡ Quick Start

Run PowerShell and paste:

```powershell
irm https://raw.githubusercontent.com/bridgerzan/xCooler/main/xCooler.ps1 | iex
```

xCooler automatically requests administrator privileges when required.

---

## 🎮 What is xCooler?

**xCooler** is a lightweight PowerShell utility that creates a dedicated Windows power plan focused on a smoother gaming experience.

It configures Windows power management to balance:

* ⚡ Performance
* 🎮 Frame consistency
* 🖱️ Input responsiveness
* 🧊 Thermal efficiency
* 🔋 Power behavior

xCooler uses Windows' native `powercfg` utility and does not require additional software.

---

## ✦ Features

<table>
<tr>
<td width="50%">

### ⚡ Performance

* Dedicated xCooler power plan
* CPU core parking configuration
* PCI Express configuration
* Intel graphics configuration
* Wireless adapter configuration

</td>
<td width="50%">

### 🎮 Gaming

* USB power management
* Reduced unnecessary power-saving behavior
* Consistent CPU behavior
* Gaming-focused power configuration
* Lightweight execution

</td>
</tr>
</table>

---

## 🧊 Power Management

xCooler creates its own power plan instead of modifying your existing plans.

```text
Windows Balanced
       │
       ▼
   ┌─────────┐
   │ xCooler │
   └─────────┘
       │
       ├── CPU
       ├── USB
       ├── PCIe
       ├── Wireless
       ├── Graphics
       └── Display
```

Your original power plans remain available.

---

## ↩️ Safe Restore

Before activating xCooler, the currently active power plan is saved.

When xCooler is turned off:

```text
xCooler ON
    │
    ▼
Previous plan saved
    │
    ▼
xCooler activated
    │
    ▼
xCooler OFF
    │
    ▼
Previous plan restored
```

If the previous plan is no longer available, Windows Balanced is used as a fallback.

---

## 🖥️ Menu

```text
[1] Turn ON
[2] Turn OFF
[3] Status
[4] Uninstall
[5] Exit
```

### Turn ON

Activates the xCooler power plan.

### Turn OFF

Restores the previously active power plan.

### Status

Displays the current xCooler state and power plan information.

### Uninstall

Removes the xCooler power plan and stored state.

---

## 🔐 Safety

xCooler uses Windows' built-in power management system.

It does **not**:

* Install drivers
* Install background services
* Create scheduled tasks
* Modify BIOS settings
* Modify CPU voltage
* Modify GPU voltage
* Modify firmware

All configuration changes are applied to the Windows power plan.

---

## 🪶 Requirements

* Windows 10
* Windows 11
* PowerShell
* Administrator privileges

---

## 📦 Installation

There is no installer.

Run:

```powershell
irm https://raw.githubusercontent.com/bridgerzan/xCooler/main/xCooler.ps1 | iex
```

That's it.

---

## 🗑️ Uninstall

Launch xCooler and select:

```text
[4] Uninstall
```

The xCooler power plan and its stored state are removed.

---

## 🚀 Roadmap

* [x] Dedicated power plan
* [x] Automatic administrator elevation
* [x] Previous-plan restoration
* [x] Interactive terminal interface
* [x] Status system
* [x] Uninstall support
* [ ] More hardware-aware profiles
* [ ] Additional optimization profiles
* [ ] Expanded compatibility testing

---

## 📋 Release

**Current version:** `v1.0.0`

<a href="https://github.com/bridgerzan/xCooler/releases">
  View Releases →
</a>

---

<div align="center">

### Made by bridgezan

<a href="https://github.com/bridgerzan">
  <img src="https://img.shields.io/badge/GitHub-bridgerzan-00D9FF?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
</a>

<br><br>

⭐ If xCooler is useful to you, consider starring the repository.

</div>
