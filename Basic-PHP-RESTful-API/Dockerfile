FROM composer:lts AS deps

WORKDIR /var/www/html
ADD composer.json .
RUN composer install --no-ansi --no-dev --no-interaction  --no-plugins --no-progress --no-scripts --optimize-autoloader
RUN ls -a

FROM php:7.4.33-zts-alpine3.16 AS final
# FROM php:7.2.1-fpm

WORKDIR /home/apiuser

COPY config ./config
COPY src ./src
COPY public ./public
RUN mkdir db

RUN chown -R www-data:www-data * 
RUN chmod -R o+w /home/apiuser

USER www-data
COPY --from=deps /var/www/html/vendor ./vendor

EXPOSE 8000 

ENTRYPOINT ["sh", "-c", "php -S 0.0.0.0:8000 -t public"]
# CMD ["php-fpm"]

## criar container for database pois se subir mais de um container cada um tera o proprio banco sqlite, não havendo correspondencia nos dados