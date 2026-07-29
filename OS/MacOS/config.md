# macOS Environment Configuration

## Overview
Base configuration steps required to prepare a macOS environment for remote administration and development usage.

---
## Install applications
- [Rustdesk](https://github.com/rustdesk/rustdesk/releases/)
- [Chrome](https://www.google.com/intl/en_us/chrome/dr/download/)
- [Brave](https://brave.com/download/)
- [VsCode](https://code.visualstudio.com/download)
- [Codex](https://developers.openai.com/codex/app)
- [Claude](https://claude.com/download)
- [Orbstack](https://orbstack.dev/downloadr)

## Optional applications
- Ollama

## System Configuration

### Start up when power is connected

**Path:**  
`System Settings > Energy`

Enable:
- Prevent automatic sleeping when the display is off

Set:
- Start up when power is connected: `Always`

### Terminal close after exit

**Path:**  
`Terminal > Settings > Profile > Shell`

Set:
 - When the shell exits: Close the window

## Local Access

**Path:**  
`System Settings > Privacy & Security > Local Network`

Enable:
- Brave
- Chrome
- Codex

## Open at Login

**Path:**  
`System Settings > General > Login Items & Extensions`

Set:
- Set Items are required

## Remote access

**Path:**  
`System Settings > General > Sharing`

Enable:
- Remote Login
  > Access info icon for configs
- Screen Sharing
  > Access info icon for configs

## Rustdesk Configuration

### System Configuration

**Path:**  
`System Settings > Privacy & Security > Accessibility`

Enable:
- RustDesk

### Remote access

**Path:**  
`System Settings > Privacy & Security > Screen & System audio Recording`

Enable:
- RustDesk

### RustDesk Settings

**Path:**  
`Settings > Security`

Enable:
- Enable direct IP access
- Use permanent password
  > Set permannent password
