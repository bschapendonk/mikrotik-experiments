# 2023-08-27 17:40:55 by RouterOS 7.11
# software id = MJCV-4CR1
#
# model = C53UiG+5HPaxD2HPaxD
/interface bridge
add auto-mac=no name=bridge vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] name=ether1_ALL
set [ find default-name=ether2 ] name=ether2_HOME
set [ find default-name=ether3 ] name=ether3_HOME
set [ find default-name=ether4 ] name=ether4_IOT
set [ find default-name=ether5 ] disabled=yes
/interface vlan
add interface=bridge name=MGMT vlan-id=1000
/interface list
add name=Management
/interface wifiwave2 datapath
add bridge=bridge disabled=no name=capdp
/interface wifiwave2
# managed by CAPsMAN
# mode: AP, SSID: Home, channel: 5680/ax/eCee
set [ find default-name=wifi1 ] configuration.manager=capsman .mode=ap \
    datapath=capdp disabled=no
# managed by CAPsMAN
# mode: AP, SSID: Home, channel: 2442/ax/eC
set [ find default-name=wifi2 ] configuration.manager=capsman .mode=ap \
    datapath=capdp disabled=no
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1_ALL
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether2_HOME pvid=1020
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether3_HOME pvid=1020
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether4_IOT pvid=1030
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface bridge vlan
add bridge=bridge tagged=ether1_ALL,bridge vlan-ids=1000
add bridge=bridge tagged=ether1_ALL,bridge vlan-ids=1010
add bridge=bridge tagged=ether1_ALL,bridge vlan-ids=1020
add bridge=bridge tagged=ether1_ALL,bridge vlan-ids=1030
add bridge=bridge tagged=ether1_ALL,bridge vlan-ids=1040
/interface list member
add interface=MGMT list=Management
/interface wifiwave2 cap
set certificate=request discovery-interfaces=MGMT enabled=yes \
    slaves-datapath=capdp
/ip cloud
set update-time=no
/ip dhcp-client
add interface=MGMT
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=10.185.0.0/16
set api disabled=yes
set winbox address=10.185.0.0/16
set api-ssl disabled=yes
/ip ssh
set strong-crypto=yes
/system clock
set time-zone-name=Europe/Amsterdam
/system identity
set name=hap01
/system note
set show-at-login=no
/system ntp client
set enabled=yes
/system scheduler
add interval=1d name=leds-off on-event=leds-off policy=write start-date=\
    2023-08-12 start-time=22:00:00
add interval=1d name=leds-on on-event=leds-on policy=write start-date=\
    2023-08-12 start-time=07:00:00
/system script
add dont-require-permissions=no name=leds-off owner=barts policy=write \
    source="/system/leds/settings set all-leds-off=immediate"
add dont-require-permissions=no name=leds-on owner=barts policy=write source=\
    "/system/leds/settings set all-leds-off=never"
/tool mac-server
set allowed-interface-list=Management
/tool mac-server mac-winbox
set allowed-interface-list=Management
/tool romon
set enabled=yes
