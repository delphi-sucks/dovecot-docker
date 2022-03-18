# dovecot-docker

[![Build Status](https://drone.delphi-sucks.de/api/badges/Sebastian/dovecot-docker/status.svg)](https://drone.delphi-sucks.de/Sebastian/dovecot-docker)

Full dovecot installation without automatic configuration for complete control.

## Features

* IMAP/IMAPS
* POP3/POP3S
* LMTP
* Sieve
* Auth

## Configuration

### Logging

```
log_path = /dev/stdout
```

### LMTP

Used for transporting received messages from postfix to dovecot.

#### Dovecot

```
service lmtp {
  inet_listener lmtp {
    port = 24
  }
}

protocols = $protocols lmtp
```

#### Postfix

```
virtual_transport = lmtp:0.0.0.0:24
local_transport = virtual

virtual_mailbox_domains = ...
virtual_alias_maps = ...
virtual_mailbox_maps = ...
```

### Authentication

Used for authentication of clients when sending mails via postfix.

#### Dovecot

```
service auth {
  inet_listener {
    port = 26
  }
}
```

#### Postfix

```
smtpd_sasl_type = dovecot
smtpd_sasl_path = inet:0.0.0.0:26
smtpd_sasl_auth_enable = yes
```

## License

This project is licensed under the [MIT License](LICENSE).