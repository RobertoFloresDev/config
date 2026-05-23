# Config BE3600

# Verify Upgrade
- Set (SYSTEM > Upgrade)

# Set Admin Password
- Set (SYSTEM > Admin Password)

# Set Network
- Set (NETWORK > LAN)
- Router IP Address as 10.0.0.1
- Set (NETWORK > Guest Network)
- Gateway as 10.0.1.1

# Wireless
- Set (WIRELESS)
- NO MLO Wi-Fi
- Enable 5/2.5 Ghz Regular/Guest Wi-Fi
- Same SSID for 5/2.5 Ghz Regular (Visibility Hidden)
- Same SSID for 5/2.5 Ghz Guest

# Set Display
- Set (SYSTEM > Display Management)
- Lock Screen as Wallpaper Only
- Auto Lock 1 Minute
- Enalbe Screen Passcode
- Function Management
  - Overview
  - 2.4 Hz Guest Wi-Fi
  - 5 Hz Guest Wi-Fi
  - VPN Dashboard
  - 2.4 GHz Wi-Fi
  - 5 GHz Wi-Fi

# Set Tailscale
- Set (APPLICATIONS > Tailscale)
- Enable and Bind an Account

# Remove Repeater configuration
- Router UI Main Page > Repeater tile > Connect
- Delete Saved connection
# root password is same as admin
ssh root@10.0.0.1
cat /etc/config/wireless
# verify that there is a > config wifi-iface 'sta'
uci delete wireless.sta
uci commit wireless
wifi reload