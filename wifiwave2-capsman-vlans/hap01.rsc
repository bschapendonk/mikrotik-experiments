# 2023-08-06 14:04:17 by RouterOS 7.11rc2
# software id = MJCV-4CR1
#
# model = C53UiG+5HPaxD2HPaxD
/interface bridge
add admin-mac=48:A9:8A:B8:D1:8E auto-mac=no name=bridge vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment="MikroTik RB5009UG+S+IN" name=\
    ether1_ALL
set [ find default-name=ether2 ] comment="HTPC currently testing the impact of\
    \_the lack of hw offloading on IPQ-PPE that the hAP ax\B3 uses" name=\
    ether2_HOME
set [ find default-name=ether3 ] disabled=yes name=ether3_IOT
set [ find default-name=ether4 ] disabled=yes name=ether4_IOT
set [ find default-name=ether5 ] comment=\
    "Standalone unconfigured for emergency WinBox MAC access" name=\
    ether5_ADMIN
/interface vlan
add interface=bridge name=MGMT vlan-id=1000
add interface=bridge name=OFFICE vlan-id=1010
/interface list
add name=ADMIN
/interface wifiwave2 datapath
add bridge=bridge disabled=no name=capdp
/interface wifiwave2
# managed by CAPsMAN
# mode: AP, SSID: Home, channel: 5745/ax/Ceee
set [ find default-name=wifi1 ] configuration.manager=capsman .mode=ap \
    datapath=capdp disabled=no
# managed by CAPsMAN
# mode: AP, SSID: Home, channel: 2422/ax/Ce
set [ find default-name=wifi2 ] configuration.manager=capsman .mode=ap \
    datapath=capdp disabled=no
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1_ALL
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether2_HOME pvid=1020
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether3_IOT pvid=1030
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
add interface=MGMT list=ADMIN
add interface=OFFICE list=ADMIN
add interface=ether5_ADMIN list=ADMIN
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
/system ntp client servers
add address=10.185.0.1
/system package update
set channel=testing
/tool mac-server
set allowed-interface-list=ADMIN
/tool mac-server mac-winbox
set allowed-interface-list=ADMIN
