# Post-Installation Setup

## Overview
Environment configuration checklist after system installation.

---

## System Configuration

### Set Device name

**Path:**  
`COSMIC Settings > System & accounts > About`

Set:
- Device name: `<device-name>`

### Remove Dock

**Path:**  
`COSMIC Settings > Desktop > Dock`

Disable:
- Dock

---

## Brave Configuration

### Proton Setup

- [Open Proton Mail](https://mail.proton.me/)
- [Open Proton Pass](https://pass.proton.me/)
- [Install Proton Pass browser extension](https://proton.me/pass)

### Disable Built-in Password Manager

**Path:**  
`Settings > Auto-fill and passwords > Password Manager > Settings`

Disable:
- Offer to save passwords and passkeys
- Sign in automatically

---

## Handy STT Configuration

> Note: Wayland currently has issues with global hotkeys.

### Configure Keyboard Shortcut

**Path:**  
`COSMIC Settings > Input Devices > Keyboard > Keyboard Shortcuts > Custom`

Add Shortcut:
```bash
Command: handy --toggle-transcription
Shortcut: Ctrl + Space
```

### Handy Settings

**Path:**  
`Settings > General`

Disable:
- Push to Talk

**Path:**  
`Settings > Advanced`

Set:
- Paste Method : `None`
- Clipboard Handling : `Copy to Clipboard`
