
# xCooler

A lightweight Windows power plan manager built for smoother gaming, lower latency, and better thermal efficiency.

Made by [bridgezan](https://github.com/bridgerzan)

## Quick Start

Open PowerShell and run:

```powershell
irm https://raw.githubusercontent.com/bridgerzan/xCooler/main/xCooler.ps1 | iex
````

xCooler will request administrator access when required and open its interactive menu.

## Features

* Creates a dedicated `xCooler` power plan
* CPU core parking configuration
* PCI Express power management configuration
* USB selective suspend configuration
* Wireless adapter power configuration
* Intel graphics power configuration
* Display and sleep configuration
* Automatically restores the previous power plan
* Interactive ON / OFF menu
* Administrator elevation
* Lightweight PowerShell implementation
* No installation wizard
* No background service

## How It Works

xCooler creates a separate Windows power plan based on the Balanced plan and applies gaming-focused power management settings to it.

Your existing power plans are not modified.

When xCooler is turned off, the previously active power plan is restored when possible.

## Usage

Run xCooler and choose:

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

Restores the power plan that was active before xCooler was enabled.

### Status

Displays the current xCooler state and power plan information.

### Uninstall

Removes the xCooler power plan from Windows.

## Requirements

* Windows 10 or Windows 11
* PowerShell
* Administrator privileges

## Compatibility

xCooler is designed for Windows systems that support the Windows `powercfg` utility and the power-management settings used by the script.

Some power settings may not exist on every system. xCooler skips unsupported settings instead of requiring them.

## Safety

xCooler uses the built-in Windows `powercfg` utility.

It does not install drivers, services, scheduled tasks, or third-party software.

The script does not modify CPU voltage, BIOS settings, GPU voltage, or hardware firmware.

## Restore

Before activating xCooler, the script records the currently active power plan.

When xCooler is turned off, it attempts to restore that plan automatically.

If the previous plan is no longer available, Windows Balanced is used as a fallback.

## Uninstall

Select `Uninstall` from the xCooler menu.

This removes the xCooler power plan and its stored state files.

## Version

Current release:

**v1.0.0**

## License

See [LICENSE](LICENSE).

## Credits

Made by **bridgezan**.

If xCooler helps you, consider giving the project a ⭐ on GitHub.

````
