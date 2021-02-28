#IMAGE BASE SUR DEBIAN STRETCH
FROM debian:stretch

#INFORMATION A PROPOS DES DEVELOPPEURS
LABEL Maintainer = JDK <jeand98.jd@gmail.com> \ 
      Description = "This is THE SLAMyP image made with love by IT4"

#DEFINITION DES VARIABLES D'ENVIRONNEMENTS
ARG PHP_VERSION
ARG MYSQL_VERSION

ENV PHP_VERSION ${PHP_VERSION}
ENV MYSQL_VERSION ${MYSQL_VERSION}

#INSTALLATION ET CONFIGURATION DE APACHE  
RUN apt-get update \
    && apt-get -y install apache2 \
    && a2enmod rewrite \
    && chown -R www-data:www-data /var/www/html
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf

#INSTALLATION DE QUELQUES PREREQUIS
RUN apt-get -y install ca-certificates \
    && apt-get -y install lsb-release \
    && apt-get -y install apt-transport-https \
    && apt-get -y install gnupg wget nano vim openssh-server net-tools \
    && apt-get -y install mysql-client

#CONFIGURATIONS DES DEPOTS POUR L'INSTALLATION DES VERSIONS DE PHP
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update

#INSTALLATION DE PHP 7.0 ET QUELQUES LIBRAIRIES
RUN apt-get install -y php7.0 libapache2-mod-php7.0 php7.0-mysql php7.0-curl php7.0-json php7.0-gd php7.0-mcrypt php7.0-intl \
    && apt-get install -y php7.0-sqlite3 php7.0-gmp php7.0-mbstring  php7.0-xml php7.0-zip \
    && service apache2 restart

#INSTALLATION DE PHP 7.1 ET QUELQUES LIBRAIRIES 
RUN apt-get install -y php7.1 libapache2-mod-php7.1 php7.1-mysql php7.1-curl php7.1-json php7.1-gd php7.1-mcrypt php7.1-intl \
    && apt-get install -y php7.1-sqlite3 php7.1-gmp php7.1-mbstring  php7.1-xml php7.1-zip \
    && service apache2 restart

#INSTALLATION DE PHP 7.2 ET QUELQUES LIBRAIRIES
RUN apt-get install -y php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-curl php7.2-json php7.2-gd php7.2-intl \
    && apt-get install -y php7.2-sqlite3 php7.2-gmp php7.2-mbstring php7.2-xml php7.2-zip \
    && service apache2 restart

#INSTALLATION DE PHP 7.3 ET QUELQUES LIBRAIRIES
RUN apt-get install -y php7.3 libapache2-mod-php7.3 php7.3-mysql php7.3-curl php7.3-json php7.3-gd php7.3-intl \ 
    && apt-get install -y php7.3-sqlite3 php7.3-gmp php7.3-mbstring  php7.3-xml php7.3-zip \
    && service apache2 restart

#COPIE DES SCRIPTS DANS LE CONTENEUR ET ATTRIBUTION DES DROITS
COPY php.sh /usr/local/bin
COPY mysql.sh /usr/local/bin
RUN chmod +x /usr/local/bin/php.sh
RUN chmod +x /usr/local/bin/mysql.sh

#CREATION D'UN USER AUTRE QUE ROOT 
RUN useradd -ms /bin/bash jdk
RUN usermod -aG sudo jdk

#DEFINITION DU REPERTOIRE DE TRAVAIL PAR DEFAUT 
WORKDIR /var/www/html

#EXPOS DU REPERTOIRE WEB DU CONTENEUR
VOLUME ["/var/www/html"]

#PREMIER SCRIPT EXECUTE AU DEMARRAGE DU CONTENEUR
ENTRYPOINT [ "php.sh" ]