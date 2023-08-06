# 2023-08-06 14:03:03 by RouterOS 7.11rc2
# software id = 96FN-KC2Y
#
# model = RB5009UG+S+
/interface bridge
add admin-mac=48:A9:8A:F6:80:09 auto-mac=no name=bridge vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] comment=pfSense name=ether1_ALL
set [ find default-name=ether2 ] comment="TP-Link Omada SDN, contains 4 more s\
    witches and 2 ap's which are currently disabled. I'm replacing this becaus\
    e I can and TP-Link sucks regarding software/firmware updates. That said i\
    t is working perfectly." name=ether2_ALL
set [ find default-name=ether3 ] comment="MikroTik hAP ax\B3" name=ether3_ALL
set [ find default-name=ether4 ] comment="HTPC currently on hAP ax\B3, but if \
    the lack of hw offloading on IPQ-PPE bothers me to much I could use this p\
    ort" name=ether4_HOME
set [ find default-name=ether5 ] disabled=yes
set [ find default-name=ether6 ] disabled=yes
set [ find default-name=ether7 ] disabled=yes
set [ find default-name=ether8 ] comment=\
    "Standalone unconfigured for emergency WinBox MAC access" name=\
    ether8_ADMIN
/interface vlan
add interface=bridge name=MGMT vlan-id=1000
add comment="Only for lazy WinBox MAC access" interface=bridge name=OFFICE \
    vlan-id=1010
/interface list
add name=ADMIN
/interface wifiwave2 channel
add band=5ghz-ax disabled=no frequency=5180-5320,5500-5680,5745-5805 name=5G \
    skip-dfs-channels=10min-cac
add band=2ghz-ax disabled=no name=2G
/interface wifiwave2 datapath
add bridge=bridge disabled=no name=HOME vlan-id=1020
add bridge=bridge disabled=no name=OFFICE vlan-id=1010
add bridge=bridge disabled=no name=IOT vlan-id=1030
/interface wifiwave2 security
add authentication-types=wpa2-psk,wpa3-psk disabled=no name=HOME passphrase=\
    "" wps=disable
add authentication-types=wpa2-psk,wpa3-psk disabled=no name=OFFICE \
    passphrase="" \
    wps=disable
add authentication-types=wpa2-psk,wpa3-psk disabled=no name=IOT passphrase=\
    "" wps=disable
/interface wifiwave2 configuration
add channel=5G country=Netherlands datapath=HOME disabled=no mode=ap name=\
    HOME_5G security=HOME ssid="Home"
add channel=2G country=Netherlands datapath=HOME disabled=no mode=ap name=\
    HOME_2G security=HOME ssid="Home"
add channel=5G country=Netherlands datapath=OFFICE disabled=no mode=ap name=\
    OFFICE_5G security=OFFICE ssid="Office"
add channel=2G country=Netherlands datapath=OFFICE disabled=no mode=ap name=\
    OFFICE_2G security=OFFICE ssid="Office"
add channel=5G country=Netherlands datapath=IOT disabled=no mode=ap name=\
    IOT_5G security=IOT ssid="IoT"
add channel=2G country=Netherlands datapath=IOT disabled=no mode=ap name=\
    IOT_2G security=IOT ssid="IoT"
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1_ALL
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2_ALL
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3_ALL
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether4_HOME pvid=1020
add bridge=bridge interface=ether5
add bridge=bridge interface=ether6
add bridge=bridge interface=ether7
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/interface bridge vlan
add bridge=bridge tagged=ether1_ALL,ether2_ALL,ether3_ALL,bridge vlan-ids=\
    1000
add bridge=bridge tagged=ether1_ALL,ether2_ALL,ether3_ALL,bridge vlan-ids=\
    1010
add bridge=bridge tagged=ether1_ALL,ether2_ALL,ether3_ALL,bridge vlan-ids=\
    1020
add bridge=bridge tagged=ether1_ALL,ether2_ALL,ether3_ALL,bridge vlan-ids=\
    1030
add bridge=bridge tagged=ether1_ALL,ether2_ALL,ether3_ALL,bridge vlan-ids=\
    1040
/interface list member
add interface=MGMT list=ADMIN
add interface=OFFICE list=ADMIN
add interface=ether8_ADMIN list=ADMIN
/interface wifiwave2 capsman
set ca-certificate=auto certificate=auto enabled=yes interfaces=MGMT \
    package-path="" require-peer-certificate=no upgrade-policy=\
    suggest-same-version
/interface wifiwave2 provisioning
add action=create-dynamic-enabled disabled=no master-configuration=HOME_5G \
    slave-configurations=OFFICE_5G supported-bands=5ghz-ax
add action=create-dynamic-enabled disabled=no master-configuration=HOME_2G \
    slave-configurations=OFFICE_2G,IOT_2G supported-bands=2ghz-ax
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
set name=r01
/system note
set show-at-login=no
/system ntp client
set enabled=yes
/system ntp client servers
add address=10.185.0.1
/tool mac-server
set allowed-interface-list=ADMIN
/tool mac-server mac-winbox
set allowed-interface-list=ADMIN
