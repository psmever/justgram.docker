#!/bin/bash

# /usr/bin/ex -sc '1i|nameserver 168.126.63.2' -cx /etc/resolv.conf
# /usr/bin/ex -sc '1i|nameserver 168.126.63.1' -cx /etc/resolv.conf

line=$(head -n 1 /etc/hosts)
line2=$(echo $line | awk '{print $2}')
echo "$line $line2.localdomain" >> /etc/hosts

sed -i 's/\;date\.timezone \=/date\.timezone \= Asia\/Seoul/g' /etc/php/7.4/apache2/php.ini
sed -i 's/\;date\.timezone \=/date\.timezone \= Asia\/Seoul/g' /etc/php/7.4/cli/php.ini
# sed -i 's/\;extension\=gd2/extension\=gd/g' /etc/php/7.2/apache2/php.ini
#sed -i 's/\;extension\=mbstring/extension\=mbstring/g' /etc/php/7.2/apache2/php.ini
#sed -i 's/\;extension\=mysqli/extension\=mysqli/g' /etc/php/7.2/apache2/php.ini

echo 'xdebug.enable=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.idekey="VSCODE"' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_enable=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.default_enable=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_mode=req' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_autostart=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_connect_back=0' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.profiler_enable=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.cli_color=1' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_host=192.168.0.10' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_port="9000"' >> /etc/php/7.4/mods-available/xdebug.ini
echo 'xdebug.remote_log="/var/log/xdebug.log"' >> /etc/php/7.4/mods-available/xdebug.ini

touch /var/log/xdebug.log
chown www-data:www-data /var/log/xdebug.log