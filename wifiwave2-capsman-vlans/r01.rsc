# 2023-08-27 17:40:50 by RouterOS 7.11
# software id = 96FN-KC2Y
#
# model = RB5009UG+S+
/interface bridge
add auto-mac=no name=bridge priority=0x4000 \
    vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] name=ether1_ALL
set [ find default-name=ether2 ] name=ether2_ALL
set [ find default-name=ether3 ] name=ether3_ALL
set [ find default-name=ether4 ] name=ether4_OFFICE
set [ find default-name=ether5 ] name=ether5_OFFICE
set [ find default-name=ether6 ] name=ether6_IOT
set [ find default-name=ether7 ] name=ether7_IOT
set [ find default-name=ether8 ] name=ether8_IOT
set [ find default-name=sfp-sfpplus1 ] disabled=yes
/interface vlan
add interface=bridge name=MGMT vlan-id=1000
/interface list
add name=Management
/interface wifiwave2 channel
add band=5ghz-ax disabled=no frequency=5180-5680 name=5G skip-dfs-channels=\
    10min-cac
add band=2ghz-ax disabled=no name=2G
/interface wifiwave2 datapath
add bridge=bridge disabled=no name=HOME vlan-id=1020
add bridge=bridge disabled=no name=OFFICE vlan-id=1010
add bridge=bridge disabled=no name=IOT vlan-id=1030
/interface wifiwave2 security
add authentication-types=wpa2-psk,wpa3-psk disabled=no ft=yes ft-over-ds=yes \
    name=HOME wps=disable
add authentication-types=wpa2-psk,wpa3-psk disabled=no ft=yes ft-over-ds=yes \
    name=OFFICE wps=disable
add authentication-types=wpa2-psk,wpa3-psk disabled=no ft=yes ft-over-ds=yes \
    name=IOT wps=disable
/interface wifiwave2 configuration
add channel=5G country=Netherlands datapath=HOME disabled=no mode=ap name=\
    HOME_5G security=HOME ssid="Home"
add channel=2G country=Netherlands datapath=HOME disabled=no mode=ap name=\
    HOME_2G security=HOME ssid="Home"
add channel=5G country=Netherlands datapath=OFFICE disabled=no mode=ap name=\
    OFFICE_5G security=OFFICE ssid="Office"
add channel=2G country=Netherlands datapath=OFFICE disabled=no mode=ap name=\
    OFFICE_2G security=OFFICE ssid="Office"
add channel=5G country=Netherlands datapath=IOT disabled=yes mode=ap name=\
    IOT_5G security=IOT ssid="IoT"
add channel=2G country=Netherlands datapath=IOT disabled=no mode=ap name=\
    IOT_2G security=IOT ssid="IoT"
/interface bridge port
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether1_ALL
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether2_ALL
add bridge=bridge frame-types=admit-only-vlan-tagged interface=ether3_ALL
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether4_OFFICE pvid=1010
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether5_OFFICE pvid=1010
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether6_IOT pvid=1030
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether7_IOT pvid=1030
add bridge=bridge frame-types=admit-only-untagged-and-priority-tagged \
    interface=ether8_IOT pvid=1030
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
add interface=MGMT list=Management
/interface wifiwave2 capsman
set ca-certificate=auto certificate=auto enabled=yes interfaces=MGMT \
    package-path="" require-peer-certificate=no upgrade-policy=\
    suggest-same-version
/interface wifiwave2 provisioning
add action=create-dynamic-enabled disabled=no master-configuration=HOME_5G \
    name-format=%I-5g- slave-configurations=OFFICE_5G supported-bands=5ghz-ax
add action=create-dynamic-enabled disabled=no master-configuration=HOME_2G \
    name-format=%I-2g- slave-configurations=OFFICE_2G,IOT_2G supported-bands=\
    2ghz-ax
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
/tool mac-server
set allowed-interface-list=Management
/tool mac-server mac-winbox
set allowed-interface-list=Management
/tool romon
set enabled=yes
