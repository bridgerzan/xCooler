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

**Cooler temps. Smoother gaming.**

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
```

xCooler will open automatically.

---

## Menu

```text
[1] Turn ON
[2] Turn OFF
[3] Status
[4] Uninstall
[5] Exit
```

### Turn ON

Activates the `xCooler` power plan.

Your previous active power plan is saved automatically.

### Turn OFF

Restores the power plan that was active before xCooler.

### Status

Shows the current xCooler state and active Windows power plan.

### Uninstall

Removes the xCooler power plan and local state files.

---

## What xCooler Changes

xCooler focuses on Windows power-management settings such as:

* Processor core parking
* PCI Express Link State Power Management
* USB selective suspend
* Wireless adapter power saving
* Intel graphics power preference
* Sleep-related settings

Only settings available on the current system are changed.

xCooler does not modify:

* GPU drivers
* Windows services
* Game files
* BIOS settings
* Registry performance tweaks

---

## Safety

xCooler does not run as a background service.

When xCooler is turned off, the previous Windows power plan is restored whenever possible.

The project is fully open source so the PowerShell code can be inspected before running it.

---

## Performance

Results depend on the system.

xCooler does not promise a fixed FPS increase or latency reduction.

Its purpose is to provide a consistent gaming-oriented Windows power configuration while avoiding unnecessary system modifications.

---

## Requirements

* Windows 10 or Windows 11
* PowerShell
* Administrator privileges

No additional software is required.

---

## Uninstall

Open xCooler and select:

```text
[4] Uninstall
```

This removes the xCooler power plan and its local state.

---

## Project

Created by **bridgezan**.

[GitHub](https://github.com/bridgerzan/xCooler)

---

## License

MIT License

Copyright (c) 2026 bridgezan
