#!/bin/bash
PHAR_URLSRC='https://phar.phpunit.de'
wget $PHAR_URLSRC/phpunit-4.1.6.phar -O /usr/local/bin/phpunit
chmod +x /usr/local/bin/phpunit
wget $PHAR_URLSRC/phploc-2.0.5.phar -O /usr/local/bin/phploc
chmod +x /usr/local/bin/phploc
wget $PHAR_URLSRC/phpcpd-2.0.1.phar -O /usr/local/bin/phpcpd
chmod +x /usr/local/bin/phpcpd
wget $PHAR_URLSRC/phpdcd-1.0.2.phar -O /usr/local/bin/phpdcd
chmod +x /usr/local/bin/phpdcd
wget http://static.pdepend.org/php/2.0.3/pdepend.phar -O /usr/local/bin/pdepend chmod +x /usr/local/bin/pdepend
wget http://static.phpmd.org/php/2.1.3/phpmd.phar -O /usr/local/bin/phpmd
chmod +x /usr/local/bin/phpmd
wget http://phpdox.de/releases/phpdox.phar -O /usr/local/bin/phpdox
chmod +x /usr/local/bin/phpdox
wget http://get.sensiolabs.org/security-checker.phar -O /usr/local/bin/php-security-checker
chmod +x /usr/local/bin/php-security-checker
wget http://get.sensiolabs.org/php-cs-fixer.phar -O /usr/local/bin/php-cs-fixer
chmod +x /usr/local/bin/php-cs-fixer
wget https://github.com/Mayflower/PHP_CodeBrowser/releases/download/1.1.1/phpcb-1.1.1.phar -O /usr/local/bin/phpcb
chmod +x /usr/local/bin/phpcb
pear install PHP_CodeSniffer
pecl install xdebug
echo "zend_extension=`php-config --extension-dir`/xdebug.so" > /etc/php5/mods-available/xdebug.ini
php5enmod xdebug
