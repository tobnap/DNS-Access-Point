sudo apt-get -y install dnsmasq hostapd
sudo wget -q https://git.io/JeReo -O /etc/dhcpcd.conf
sudo service dhcpcd restart
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig  
sudo wget -q https://git.io/JeRe6 -O /etc/dnsmasq.conf
sudo wget -q https://git.io/JeReX -O /etc/hostapd/hostapd.conf
sudo sed -i 's/#DAEMON_CONF=""/DAEMON_CONF="/etc/hostapd/hostapd.conf"/g' /etc/default/hostapd
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo systemctl start hostapd
sudo systemctl start dnsmasq
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1"/g' /etc/sysctl.conf
sudo iptables -t nat -A POSTROUTING -o wlan1 -j MASQUERADE
sudo iptables -A FORWARD -i wlan1 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o wlan1 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
sudo wget -q https://git.io/JeReM -O /etc/rc.local
