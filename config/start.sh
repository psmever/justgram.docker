#!/bin/sh

cd /var/www/justgram && php artisan config:clear && git pull
exec /usr/sbin/apache2 -D FOREGROUND