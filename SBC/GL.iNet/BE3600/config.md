# Config BE3600

## Overview
Configuration for GL.iNet GL-BE3600 Travel Router.

## System Configuration

### Verify Upgrade

**Path:**  
`SYSTEM > Upgrade`

Start:
- Firmware Online Upgrade

### Set Admin Password

**Path:**  
`SYSTEM > Admin Password`

Set:
- Admin Password

## DHCP Configuration

### LAN Address

**Path:**  
`NETWORK > LAN`

Set:
- Router IP Address: `10.0.0.1`

### Guest Address

**Path:**  
`NETWORK > Guest Network`

Set:
- Gateway: `10.0.1.1`

Enable:
- AP Isolation
  > Isolate users from main network 

## Wireless

### 5 and 2.4 GHz Regular/Guest Wi-Fi

**Path:**  
`WIRELESS`

Disable:
- MLO Wi-Fi

Enable:
- 5/2.4 Ghz Regular/Guest Wi-Fi

Set:
- Same SSID for 5/2.4 Ghz Regular (Visibility Hidden)
- Same SSID for 5/2.4 Ghz Guest

## Display Settings

### Display Management

**Path:**  
`SYSTEM > Display Management`

Set:
- Lock Screen: `Wallpaper Only`
- Auto Lock: `1 Minute`
- Function Management:
  - Overview
  - 2.4 Hz Guest Wi-Fi
  - 5 Hz Guest Wi-Fi
  - VPN Dashboard
  - 2.4 GHz Wi-Fi
  - 5 GHz Wi-Fi

Enable:
- Screen Passcode
  > Set Passcode

## Tailscale

### Set Tailscale

**Path:**  
`APPLICATIONS > Tailscale`

Enable:
- Enable

Set:
- Bind Account

---

## Remove Repeater configuration

### UI Known Networks

**Path:**  
`INTERNET`
> Repeater tile > Connect

Delete:
- Known Networks

### Remove Service configuration

```bash
# - Root password is same as admin
ssh root@10.0.0.1
cat /etc/config/wireless
# - Verify that there is a config wifi-iface 'sta'
uci delete wireless.sta
uci commit wireless
wifi reload
```
