# installer stage with user setup
FROM node:20-buster as installer
#RUN useradd -m -s /bin/bash -u 65532 myuser \
#    && mkdir -p /home/myuser/.npm-global \
#    && chown -R myuser:myuser /home/myuser/.npm-global
#ENV PATH=/home/myuser/.npm-global/bin:$PATH


COPY . /juice-shop
#RUN chown -R myuser:myuser /juice-shop
WORKDIR /juice-shop

#USER myuser

#RUN npm config set prefix '/home/myuser/.npm-global' \
RUN npm i -g typescript ts-node \
    && npm install --omit=dev --unsafe-perm \
    && npm dedupe

# Permissions and cleaning up
RUN mkdir logs \
#    && chown -R myuser:myuser logs \
#    && chgrp -R 0 ftp/ frontend/dist/ logs/ data/ i18n/ \
#    && chmod -R g=u ftp/ frontend/dist/ logs/ data/ i18n/ \
    && rm data/chatbot/botDefaultTrainingData.json || true \
    && rm ftp/legal.md || true \
    && rm i18n/*.json || true

# libxmljs-builder stage doesn't need npm global installs
FROM node:20-buster as libxmljs-builder
WORKDIR /juice-shop
RUN apt-get update && apt-get install -y build-essential python3
COPY --from=installer /juice-shop .

# Final stage
FROM node:20-buster
ARG BUILD_DATE
ARG VCS_REF
LABEL maintainer="Bjoern Kimminich <bjoern.kimminich@owasp.org>" \
    org.opencontainers.image.title="OWASP Juice Shop" \
    org.opencontainers.image.description="Probably the most modern and sophisticated insecure web application" \
    org.opencontainers.image.authors="Bjoern Kimminich <bjoern.kimminich@owasp.org>" \
    org.opencontainers.image.vendor="Open Web Application Security Project" \
    org.opencontainers.image.documentation="https://help.owasp-juice.shop" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.version="16.0.0" \
    org.opencontainers.image.url="https://owasp-juice.shop" \
    org.opencontainers.image.source="https://github.com/juice-shop/juice-shop" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE
COPY --from=installer  /juice-shop /juice-shop
COPY --from=libxmljs-builder /juice-shop/node_modules/libxmljs2 /juice-shop/node_modules/libxmljs2
#COPY --from=installer --chown=65532:0 /juice-shop /juice-shop
#COPY --from=libxmljs-builder --chown=65532:0 /juice-shop/node_modules/libxmljs2 /juice-shop/node_modules/libxmljs2
#USER 65532
WORKDIR /juice-shop
EXPOSE 3000
#CMD ["node", "/juice-shop/build/app.js"]
CMD ["npm", "start"]

