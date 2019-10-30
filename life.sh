#!/bin/bash

 menu=('interface' 'dhcpd' 'sair')
 select option in "${menu[@]}"; do
	 case "$option" in
		 "${menu[0]}")
    cd /etc/network
     mv interfaces interfaces.original
      touch interfaces
			echo "source /etc/network/interfaces.d/*
			      auto lo 
			      iface lo inet loopback
			
			allow-hotplug enp0s3
		    auto enp0s3
			iface enp0s3 inet dhcp
			
			allow-hotplug enp0s8
			auto enp0s8
			iface enp0s8 inet static
			
			address 192.168.0.1
			netmask 255.255.255.0
			network 192.168.0.0
			broadcast 192.168.0.255" >> interfaces

			apt-get install isc-dhcp-server -y &&

	cd ../default/
	mv isc-dhcp-server isc-dhcp-server.original
	touch isc-dhcp-server
	echo 'INTERFACESv4="enp0s8"
              INTERFACESv6=""' >> isc-dhcp-server

			;;
		"${menu[1]}")
  cd /etc/dhcp/
   mv dhcpd.conf dhcpd.conf.original
    touch dhcpd.conf
		echo "ddns-update-style none;
		  option domain-name-servers 192.168.0.1;
		default-lease-time 600;
		max-lease-time 7200;
		authoritative;
		log-facility local7;
		subnet 192.168.0.0 netmask 255.255.255.0{
			range 192.168.0.50 192.168.0.100;
			option routers 192.168.0.1;
		}" >> dhcpd.conf
		apt-get install apache2 -y 
		apt-get install ssh -y

		;;
	"${menu[2]}") exit ;;
	  *) echo 'Erro opção invalida!';;
     esac
done  
