FROM alpine:3.2

ADD https://releases.hashicorp.com/vault/0.4.0/vault_0.4.0_linux_amd64.zip vault.zip
RUN apk add --update unzip openssl && \
    unzip vault.zip && \
    rm vault.zip && \
    cp vault /usr/bin && \
    apk del unzip && \
    rm -rf /var/cache/apk/*

COPY run-vault /usr/bin/run-vault
COPY config.hcl config.hcl

ENTRYPOINT ["run-vault"]
CMD ["server", "-config=config.hcl"]
