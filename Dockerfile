#    +--------------------- Dockerfile                     ----------------+    
#    +                                                                     +    
#    +            name         Role          Describtion                   +    
#    +          ----------------------------------------------             +    
#    +          Steph  ' Bug Hunter       '        -         '             +    
#    +          Makan  ' Cyber weapon     '        -         '             +    
#    +                 '                  '                  '             +    
#    +                 '                  '                  '             +    
#    +                                                                     +    
#    +---------------------------------------------------------------------+    
#                                                
#    >*____dockerfile_____>_____dockerfile______>_______dockerfile_________>*





FROM php:8.3-apache


ARG USERNAME
ARG EMAIL
ARG APP
# ENV APP_NAME=${APP}


RUN apt update -y \
        && apt install -y git \
        && apt install -y curl \ 
        && apt install -y wget \
        && apt install -y nano \
        && apt install -y vim

RUN docker-php-ext-install pdo pdo_mysql mysqli


WORKDIR /var/www/

# install composer
RUN curl -Ss https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN chmod 777 /usr/local/bin/composer

# config git
RUN git config --global user.name ${USERNAME}
RUN git config --global user.email ${EMAIL}

# Install symfo
RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony


RUN apt update && apt install npm -y