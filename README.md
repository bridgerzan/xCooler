# xCooler

<p align="center">
  <b>Cooler temps. Smoother gaming.</b>
</p>

<p align="center">
  Lightweight Windows power management for gaming.
</p>

<p align="center">

![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-00D9FF?style=flat-square)
![PowerShell](https://img.shields.io/badge/PowerShell-5%2B-00D9FF?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-00D9FF?style=flat-square)
![Version](https://img.shields.io/badge/version-1.0.0-00D9FF?style=flat-square)

</p>

---

## What is xCooler?

xCooler is a lightweight Windows power-management tool designed for gaming.

It creates a dedicated `xCooler` power plan and applies a small set of gaming-focused power settings without installing background services or permanently modifying Windows.

The goal is simple:

**lower unnecessary power-management overhead while keeping gaming smooth.**

---

## Features

- Lightweight
- Open source
- Windows 10 / 11
- Dedicated `xCooler` power plan
- Automatic previous-plan restore
- AC gaming optimization
- No background service
- No startup process
- No third-party dependencies
- Reversible changes
- Cyan terminal interface

---

## Quick Start

Open PowerShell as Administrator and run:

```powershell
irm https://raw.githubusercontent.com/bridgerzan/xCooler/main/xCooler.ps1 | iex
