# Utilise une étiquette de version spécifique pour l'image de base
FROM alpine:latest

# Déclare les arguments
ARG NGINX_VERSION=1.25.2
ARG RTMP_VERSION=1.2.2
ARG USER_UID=1001
ARG USER_GID=1001

# Met à jour, installe les dépendances, crée l'utilisateur, et fait le nettoyage en une seule couche
RUN apk update && \
    apk add --no-cache build-base pcre-dev openssl-dev zlib-dev wget unzip ffmpeg ffmpeg-libs&& \
    addgroup -g ${USER_GID} myuser && \
    adduser -D -u ${USER_UID} -G myuser myuser && \
    wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    wget https://github.com/arut/nginx-rtmp-module/archive/refs/tags/v${RTMP_VERSION}.tar.gz && \
    tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxvf v${RTMP_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-${RTMP_VERSION} && \
    make && make install && \
    rm -rf nginx-${NGINX_VERSION}.tar.gz v${RTMP_VERSION}.tar.gz nginx-${NGINX_VERSION} && \
    mkdir -p /var/rec /var/run /usr/local/nginx/{client_body_temp,proxy_temp,fastcgi_temp,uwsgi_temp,scgi_temp,logs} && \
    chown -R myuser:myuser /var/rec /var/run /usr/local/nginx/ && \
    ln -sf /dev/stdout /usr/local/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/nginx/logs/error.log && \
    mkdir -p /var/hls && chown myuser:myuser /var/hls

# Copie la configuration Nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Utilise le nouvel utilisateur pour exécuter les commandes suivantes
USER myuser

# Expose les ports
EXPOSE 1935 8080

# Commande pour démarrer Nginx
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
