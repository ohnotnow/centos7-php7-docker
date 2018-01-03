FROM centos:7

RUN yum -y install wget \
    && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm \
    && yum-config-manager --enable remi-php72 \
    && yum -y install git sqlite php72 php72-php-xml php72-php-json php72-php-bcmath php72-php-mbstring php72-php-pdo php72-php-ldap php72-php-mysqlnd php72-php-mcrypt php72-php-pecl-zip php72-php-process \
    && ln -s /usr/bin/php72 /usr/bin/php \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php --install-dir=/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && composer -q global require "hirak/prestissimo:^0.3" \
    && curl -L -o /bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x /bin/phpcs
