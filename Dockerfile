FROM php:7.4-apache

# Instalar las extensiones de PHP necesarias y unzip
RUN apt-get update && apt-get install -y \
    unzip \
    default-mysql-client \
    && docker-php-ext-install mysqli pdo pdo_mysql

# Configurar los permisos y la configuración de Apache
RUN a2enmod rewrite

# Descargar y extraer OpenSupports
RUN curl -fsSL -o opensupports.zip https://github.com/opensupports/opensupports/releases/download/v4.11.0/opensupports_v4.11.0.zip \
    && unzip opensupports.zip -d /var/www/html \
    && rm -r opensupports.zip

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Establecer los permisos adecuados
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80
EXPOSE 80

CMD ["apache2-foreground"]

