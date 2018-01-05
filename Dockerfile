FROM centos:7

RUN yum -y install wget \
    && wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && rpm -Uvh remi-release-7.rpm epel-release-latest-7.noarch.rpm \
    && yum-config-manager --enable remi-php72 \
    && yum -y install git sqlite php72 php72-php-xml php72-php-json php72-php-bcmath php72-php-mbstring php72-php-pdo php72-php-ldap php72-php-mysqlnd php72-php-mcrypt php72-php-pecl-zip php72-php-process \
    && ln -s /usr/bin/php72 /usr/bin/php \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/bin --filename=composer \
    && composer -q global require "hirak/prestissimo:^0.3" \
    && curl -L -o /bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar \
    && chmod +x /bin/phpcs
