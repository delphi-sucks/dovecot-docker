FROM alpine:latest

# Install dependencies
RUN apk add --no-cache --update \
    dovecot \
    dovecot-submissiond dovecot-pop3d dovecot-lmtpd dovecot-pigeonhole-plugin \
    dovecot-mysql dovecot-pgsql dovecot-sqlite \
    cyrus-sasl ca-certificates bash

# Delete keys
RUN rm -r /etc/ssl/dovecot

VOLUME [ "/etc/dovecot" ]

# IMAP
EXPOSE 143/tcp
EXPOSE 993/tcp

# POP3
EXPOSE 110/tcp
EXPOSE 995/tcp

COPY entrypoint.sh /usr/local/bin/
RUN chmod 0755 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["dovecot", "-F"]