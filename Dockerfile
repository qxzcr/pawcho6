# Etap pośredni: Budowanie aplikacji w Node.js
FROM node:alpine AS builder

WORKDIR /usr/app
COPY ./package.json ./
RUN npm install
COPY ./index.js ./

# Etap 1: Przeniesienie aplikacji do scratch
FROM scratch

# Kopiowanie binarki Node.js
COPY --from=builder /usr/local/bin/node /usr/local/bin/node

# Kopiowanie bibliotek systemowych wymaganych przez Node.js
COPY --from=builder /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=builder /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=builder /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1

# Kopiowanie aplikacji
COPY --from=builder /usr/app /usr/app

# Ustawienie katalogu roboczego
WORKDIR /usr/app

# Definicja zmiennej VERSION
ARG VERSION=1.0.0
ENV VERSION=$VERSION

# Uruchomienie aplikacji
CMD ["/usr/local/bin/node", "index.js"]

# Etap 2: Użycie Nginx jako serwera HTTP
FROM nginx:alpine

# Kopiowanie aplikacji i Node.js z obrazu z Etapu 1
COPY --from=webapp-scratch:1.0 /usr/app /usr/app
COPY --from=webapp-scratch:1.0 /usr/local/bin/node /usr/local/bin/node
COPY --from=webapp-scratch:1.0 /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
COPY --from=webapp-scratch:1.0 /usr/lib/libstdc++.so.6 /usr/lib/libstdc++.so.6
COPY --from=webapp-scratch:1.0 /usr/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1

# Kopiowanie konfiguracji Nginx
COPY ./nginx.conf /etc/nginx/nginx.conf

# Eksponowanie portu
EXPOSE 80

# HEALTHCHECK do sprawdzania działania
HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1

# Uruchomienie Node.js i Nginx
CMD ["/bin/sh", "-c", "node /usr/app/index.js & nginx -g 'daemon off;'"]