FROM alpine:3.3

ENV VAULT_VERSION 0.5.1

ADD https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip vault.zip
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
