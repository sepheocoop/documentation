# NAME

How To: Send and Receive Mail.

# SYNOPSYS

[Sepheo][] uses a [Cloudron][] managed server as an email
server.

The server uses [IMAP][] and [SMTP][], standard protocols supported by
pretty much every mail client. The details depend on the client, more
details below. The basic parameters are as follows. You configure your
client to use these, IMAP for incoming, and SMTP for the outgoing
server.

The server also supports [Sieve][], which your mail client may
support. If it does, you will be able to use this to set up your
mail-filtering rules on the server (rather than in your client, ore
more to the point, each of your *clients*).

Quoting the [Cloudron email docs][]:
> Cloudron has a built-in mail server that can send and receive email
> on behalf of users and applications. By default, most of it's
> functionality is disabled and it only sends out mails on behalf of
> apps (for example, password reset and notification emails).
>
> When Cloudron Email is enabled, it becomes a full-fleged mail server
> solution. Each user gets a mailbox username@domain and can send
> mails using SMTP and receive mails using IMAP. Users can also setup
> server side mail filtering rules using ManageSieve.

## Port & protocols

This is summarising the [Cloudron email client configuration docs][].

Prerequisites:
- You must have an account on the Cloudron server. *i.e. Can you log
  into <http://my.sepheo.co>? If not ask an admin to create
  one for you, or send you an invite by email. You should supply an
  email address to send password resets to, and you will need to
  record your username and password.*
- You must have a mailbox enabled. *i.e. Ask an admin to do this for
  you*
- You must know your Sepheo email address. *Typically our
  personal emails addresses are in the form
  `firstname.secondname@sepheo.co` but this is just a
  convention.*

For all of the below, use the following:

- *Log-in* - Use your Sepheo *email address* as your log=in
  (e.g. `joe.bloggs@sepheo.co` - note this is different to
  your Cloudron account username)
- *Password* - Whatever you chose as your account password on
  `my.sepheo.co` *Only you know this, obviously. This *is*
  the same password.*

### IMAP

Use the following settings to receive email via [IMAP][].

- *Server Name* - Use the mail server location of your Cloudron
  server: `my.sepheo.co`
- *Port* - 993
- *Connection Security* - TLS (i.e. an encrypted protocol, sometimes
  mislabelled as SSL)

### SMTP

Use the following settings to send email via [SMTP][].

- *Server Name* - Use the mail server location of your Cloudron
  server: `my.sepheo.co`
- *Port* - 587
- *Connection Security* - STARTTLS (i.e. an encrypted protocol, but
  different from plain TLS or SSL)

### Sieve

Use the following settings to setup [Sieve][] email filtering rules
via [ManageSieve][].

- *Server Name* - Use the mail server location of your Cloudron
  server: `my.sepheo.co`
- *Port* - 4190
- *Connection Security* - STARTTLS (i.e. an encrypted protocol, but
  different from plain TLS or SSL)

# SPECIFIC CLIENTS

Details for specific clients can be added here as needed. Contact the
admins to request documentation for a specific client. The basic
server, port, security and log-in information will be the same as
above.

Failing that, there is a good resource here for various mail clients,
from which some of the information below has been adapted:

https://webdesigninhorsham.co.uk/page-sitemap.xml

## Outlook (desktop)

If you add your Sepheo email and password, it attempts to guess the correct settings but gets it wrong.

However, if you then correct it to the settings above (unlike Windows 10 Mail it seems to know about STARTTLS) this seems to work. 

## Windows 10 Mail

*Adapted from: https://webdesigninhorsham.co.uk/set-email-windows-10-imap/*

1. On the Start screen, tap the *Mail* tile (the precise location will
   depend on the layout of your Start screen).
2. In the Mail app, select the settings icon.
3. Underneath Settings, tap *Accounts*.
4. Underneath Accounts, tap *Add account*.
5. Choose *Advanced Setup*
6. Select *Internet Email*
7. Complete the form:
  - Account name: *just a label - you might use your sepheo email address*
  - Your name: *your full name, or whatever name you want to appear on outgoing mail*
  - Incoming email server: *`my.sepheo.co`*
  - Account Type: *IMAP4*
  - User name: *use your sepheo email address*
  - Password: *use the same password you use to log into `my.sepheo.co`*
  - Outgoing (SMTP) email server: *`my.sepheo.co:587`*
  - Outgoing server requires authentication: *check*
  - Use the same user name asn password for sending email: *check*
  - Require SSL for incoming email: *check*
  - Require SSL for outgoing email: *check*
8. Click *Sign-In*
9. You should be presented with a success message - if so click *Done*


## MacOS

*Adapted from: https://support.apple.com/en-gb/HT204093*

1. Open Mail App 
2. Mail -> add account
3. Complete the form: 
- Enter email address (this can be found in the server at my.sepheo.co) 
- Enter password
- Incoming email server: *`my.sepheo.co`*
- Outgoing (SMTP) email server: *`my.sepheo.co:587`*


# TROUBLESHOOTING

First, of course, double check your credentials. Then if these really
are correct, read the following sections to troubleshoot problems with
reading or sending mail.

## Reading email (IMAP)

Cloudron uses Dovecot for its IMAP service. Admins with access to the
server via ssh can look in the Dovecot logs. Once logged in, you can
read the IMAP log but you need to connect to the Docker `mail`
container. For example:

```
me@home:~$ ssh root@my.sepheo.co
root@my.sepheo.co:~# docker exec -ti mail /bin/less /run/dovecot/dovecot.log
```

This should show the dovecot log by running the command `less` in the
container to read the log file. The logfile may be long, the latest
entries are at the bottom. Look for lines containing the email address
in question. Hit the `h` key to get help for using `less`. The most
useful ones are `>` (go to end of file), `/joe.bloggs` (search for the
string `joe.bloggs`). Arrow keys and page up/down will navigate.

There should be lines like this for a successful connection (a login
followed by some IMAP activity):

```
Dec 01 21:31:53 imap-login: Info: Login: user=<joe.bloggs@sepheo.co>, method=PLAIN, rip=1.2.3.4, lip=172.18.0.7, mpid=15034, TLS, session=<A9/32m21m7BYYWPt>
Dec 01 21:31:53 imap(joe.bloggs@sepheo.co): Info: Connection closed (LIST finished 0.109 secs ago) in=23 out=674
Dec 01 21:31:54 imap(joe.bloggs@sepheo.co): Info: Connection closed (UID FETCH finished 0.097 secs ago) in=933 out=1947
```

Or like this (just a login and a logout):

```
Dec 01 21:33:18 imap-login: Info: Login: user=<contact@sepheo.co>, method=PLAIN, rip=4.3.2.1, lip=172.18.0.7, mpid=15038, TLS, session=<a90P4G21VPhPSO0I>
Dec 01 21:33:19 imap(contact@sepheo.co): Info: Logged out in=32 out=468
```

Any errors may give clues as to what's failing.  No sign of anything
suggests the client isn't connecting at all.


## Sending mail (SMTP)

Cloudron uses Haraka for its SMTP service. As above, admins with
access to the server via ssh can check the logs for this. Haraka also
runs in a docker container, but the log file is accessible in the
host filesystem. As above, use `less` to read it:

```
less /home/yellowtent/platformdata/logs/mail/app.log
```

Successful connections look like this transcript, a send from
joe.bloggs@sepheo.co to joe@fastmail.fm, where 1.2.3.4 is
the sending IP address (the computer's local subnet IP is used as the
HELO greeting, 192.168.0.54) and 61.111.4.74 is the delivery address
(FastMail's MTA):

```
2020-12-01T22:15:11.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [core] connect ip=1.2.3.4 port=59300 local_ip=:: local_port=2525
2020-12-01T22:15:13.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [helo.checks] helo_host: [192.168.0.54], pass:bare_ip, host_mismatch, fail:rdns_match(literal), skip:dynamic(literal), valid_hostname(literal)
2020-12-01T22:15:13.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [tls] secured: cipher=TLS_AES_256_GCM_SHA384 version=TLSv1.3 verified=false
2020-12-01T22:15:13.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [core]  hook=unrecognized_command plugin=tls function=upgrade_connection params=STARTTLS retval=OK msg=""
2020-12-01T22:15:13.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [helo.checks] helo_host: [192.168.0.54], multi: true, pass:bare_ip, host_mismatch, host_mismatch, fail:rdns_match(literal), skip:dynamic(literal), valid_hostname(literal)
2020-12-01T22:15:13.000Z [INFO] [-] [cloudron] authenticated as : joe.bloggs@sepheo.co
2020-12-01T22:15:13.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010] [core]  hook=unrecognized_command plugin=cloudron function=hook_unrecognized_command params=AUTH retval=OK msg=""
2020-12-01T22:15:13.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] sender <joe.bloggs@sepheo.co> code=CONT msg=""
2020-12-01T22:15:14.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core]  hook=rcpt plugin=rcpt_to.in_host_list function=hook_rcpt params=<joe@fastmail.fm> retval=OK msg=""
2020-12-01T22:15:14.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [delay_deny] bypassing all pre-DATA deny: AUTH/RELAY
2020-12-01T22:15:14.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] recipient <joe@fastmail.fm> code=OK msg="" sender=joe.bloggs@sepheo.co
2020-12-01T22:15:14.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] message mid=<605cb14d-2c69-d102-6669-9861ba8a40e5@sepheo.co> size=451 rcpts=1/0/0 delay=0.009 code=CONT msg=""
2020-12-01T22:15:14.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [dkim_sign] signed for sepheo.co
2020-12-01T22:15:14.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] queue code=CONT msg="Message Queued (D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1)"
2020-12-01T22:15:14.000Z [INFO] [-] [core] [outbound] Sending email as a transaction
2020-12-01T22:15:14.000Z [INFO] [-] [core] [outbound] Processing delivery for domain: fastmail.fm
2020-12-01T22:15:14.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] queue code=OK msg="Message Queued (D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1)"
2020-12-01T22:15:14.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1] [core] disconnect ip=1.2.3.4 rdns=1.2.3.4.example.com helo=[192.168.0.54] relay=Y early=N esmtp=Y tls=Y pipe=N errors=0 txns=1 rcpts=1/0/0 msgs=1/0/0 bytes=451 lr="" time=2.304
2020-12-01T22:15:14.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1.1] [outbound] Looking up A records for: in1-smtp.messagingengine.com
2020-12-01T22:15:14.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1.1] [outbound] Attempting to deliver to: 66.111.4.74:25 (0) (0)
2020-12-01T22:15:14.000Z [INFO] [-] [core] [outbound] [outbound::25:66.111.4.74:undefined:50] dispense() clients=1 available=0
2020-12-01T22:15:14.000Z [INFO] [-] [core] [outbound] acquired socket 67565978-B4E3-445D-9061-80B23B8F4682 for outbound::25:66.111.4.74:undefined:50
2020-12-01T22:15:16.000Z [INFO] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1.1] [outbound] secured verified=true cipher=ECDHE-RSA-AES128-GCM-SHA256 version=TLSv1.2 cn=*.messagingengine.com organization="FastMail Pty Ltd" issuer="DigiCert Inc" expires="Feb 24 12:00:00 2021 GMT" fingerprint=DD:AC:83:E6:19:36:7E:9E:5F:6F:01:42:DE:CB:A6:87:2D:73:19:F2
2020-12-01T22:15:18.000Z [NOTICE] [D33D6290-C923-4DAC-A4B4-D0E7B8FAF010.1.1] [outbound]  delivered file=1606860914133_1606860914133_0_90_adwUhC_83_b97d55d865ba domain=letterboxes.org host=in1-smtp.messagingengine.com ip=66.111.4.74 port=25 mode=SMTP tls=Y auth=N response="Queued as BA5AF7A207E" delay=4.565 fails=0 rcpts=1/0/0
2020-12-01T22:15:18.000Z [INFO] [-] [core] [outbound] [outbound::25:66.111.4.74:undefined:50] dispense() clients=0 available=1
2020-12-01T22:16:08.000Z [INFO] [-] [core] [outbound] Remote end half closed during destroy()
```

This next transcript is an unsuccessful send from
joe.bloggs@sepheo.co to joe@example.com, where 1.2.3.4 is
the sending IP address, and 4.3.2.1 is the delivery address. The
problem however is with the *remote* server - our server received the
email fine, but the connection to the remote server failed. This is a
temporary failure - Haraka will retry after some interval, and only
give up if it continues to fail. (It succeeded eventually. But if it
failed, the email would be bounced back to the sender with an error
message.)

```
2020-12-01T21:57:06.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [core] connect ip=1.2.3.4 port=57986 local_ip=:: local_port=2525
2020-12-01T21:57:07.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [helo.checks] helo_host: [192.168.0.54], pass:bare_ip, host_mismatch, fail:rdns_match(literal), skip:dynamic(literal), valid_hostname(literal)
2020-12-01T21:57:07.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [tls] secured: cipher=TLS_AES_256_GCM_SHA384 version=TLSv1.3 verified=false
2020-12-01T21:57:07.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [core]  hook=unrecognized_command plugin=tls function=upgrade_connection params=STARTTLS retval=OK msg=""
2020-12-01T21:57:07.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [helo.checks] helo_host: [192.168.0.54], multi: true, pass:bare_ip, host_mismatch, host_mismatch, fail:rdns_match(literal), skip:dynamic(literal), valid_hostname(literal)
2020-12-01T21:57:08.000Z [INFO] [-] [cloudron] authenticated as : joe.bloggs@sepheo.co
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1] [core]  hook=unrecognized_command plugin=cloudron function=hook_unrecognized_command params=AUTH retval=OK msg=""
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] sender <joe.bloggs@sepheo.co> code=CONT msg=""
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core]  hook=rcpt plugin=rcpt_to.in_host_list function=hook_rcpt params=<joe@example.com> retval=OK msg=""
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [delay_deny] bypassing all pre-DATA deny: AUTH/RELAY
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] recipient <joe@example.com> code=OK msg="" sender=joe.bloggs@sepheo.co
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] message mid=<557d1588-b388-c89b-028a-c123ecb42c05@sepheo.co> size=455 rcpts=1/0/0 delay=0.003 code=CONT msg=""
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [dkim_sign] signed for sepheo.co
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] queue code=CONT msg="Message Queued (30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1)"
2020-12-01T21:57:08.000Z [INFO] [-] [core] [outbound] Sending email as a transaction
2020-12-01T21:57:08.000Z [INFO] [-] [core] [outbound] Processing delivery for domain: example.com
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] queue code=OK msg="Message Queued (30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1)"
2020-12-01T21:57:08.000Z [NOTICE] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1] [core] disconnect ip=1.2.3.4 rdns=1.2.3.4.example.com helo=[192.168.0.54] relay=Y early=N esmtp=Y tls=Y pipe=N errors=0 txns=1 rcpts=1/0/0 msgs=1/0/0 bytes=455 lr="" time=1.429
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Looking up A records for: a.mx.example.com
2020-12-01T21:57:08.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Attempting to deliver to: 4.3.2.1:25 (0) (0)
2020-12-01T21:57:08.000Z [INFO] [-] [core] [outbound] [outbound::25:4.3.2.1:undefined:50] dispense() clients=1 available=0
2020-12-01T21:57:08.000Z [INFO] [-] [core] [outbound] acquired socket 92501AB8-1541-452D-9E7F-8D1BE3DBC414 for outbound::25:4.3.2.1:undefined:50
2020-12-01T21:57:14.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] secured verified=false cipher=DHE-RSA-AES128-SHA256 version=TLSv1.2 error=ERR_TLS_CERT_ALTNAME_INVALID cn=box.example.com organization="" issuer="Let's Encrypt" expires="Dec 30 09:53:37 2020 GMT" fingerprint=7C:10:98:FF:EF:58:8F:4A:12:88:23:2B:11:FF:FB:43:1E:87:50:35
2020-12-01T21:57:44.000Z [ERROR] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Ongoing connection failed to 4.3.2.1:25 : socket timeout waiting on rcpt
2020-12-01T21:57:44.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Temp failing 1606859828273_1606859828273_0_90_OQNQDT_80_b97d55d865ba for 64 seconds: Tried all MXs
2020-12-01T21:57:45.000Z [INFO] [-] [core] [outbound] Remote end half closed during destroy()
2020-12-01T21:58:48.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Looking up A records for: a.mx.example.com
2020-12-01T21:58:48.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Attempting to deliver to: 4.3.2.1:25 (0) (0)
2020-12-01T21:58:48.000Z [INFO] [-] [core] [outbound] [outbound::25:4.3.2.1:undefined:50] dispense() clients=1 available=0
2020-12-01T21:58:48.000Z [INFO] [-] [core] [outbound] acquired socket 7BBBD0B5-CFAA-4246-90D7-F063BE9D9233 for outbound::25:4.3.2.1:undefined:50
2020-12-01T21:58:54.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] secured verified=false cipher=DHE-RSA-AES128-SHA256 version=TLSv1.2 error=ERR_TLS_CERT_ALTNAME_INVALID cn=box.example.com organization="" issuer="Let's Encrypt" expires="Dec 30 09:53:37 2020 GMT" fingerprint=7C:10:98:FF:EF:58:8F:4A:12:88:23:2B:11:FF:FB:43:1E:87:50:35
2020-12-01T21:59:24.000Z [ERROR] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Ongoing connection failed to 4.3.2.1:25 : socket timeout waiting on rcpt
2020-12-01T21:59:24.000Z [INFO] [30A11DAA-D11E-4C8A-AF6E-42BB9C4D05B1.1.1] [outbound] Temp failing 1606859828273_1606859928137_1_90_OQNQDT_81_b97d55d865ba for 128 seconds: Tried all MXs
2020-12-01T21:59:28.000Z [INFO] [-] [core] [outbound] Remote end half closed during destroy()

```

This is an unsuccessful send. Note that the line containing `host
[1.2.3.4] is blacklisted by zen.spamhaus.org` may *not* be a problem
if the user authenticates ok (as seen later in the line `[cloudron]
authenticated as...`), but it does mean that the user's IP address is
listed on a spam blacklist! However, there are no lines showing any
mail delivery.

```
2020-12-01T20:57:50.000Z [NOTICE] [084066B5-E28C-4B91-8403-34686796FD91] [core] connect ip=1.2.3.4 port=54937 local_ip=:: local_port=2525
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [core]  hook=connect plugin=dnsbl function=connect_first params="" retval=DENY msg="host [1.2.3.4] is blacklisted by zen.spamhaus.org"
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [core]  hook=deny plugin=delay_deny function=hook_deny params=902 retval=OK msg=""
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [core] deny(soft?) overriden by deny hook
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [helo.checks] helo_host: bloggs.lan, pass:bare_ip, dynamic, host_mismatch, fail:rdns_match
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [spf] identity=helo ip=1.2.3.4 domain="bloggs.lan" mfrom=<postmaster@bloggs.lan> result=None
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [spf] scope: helo, result: None, domain: bloggs.lan
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [tls] secured: cipher=ECDHE-ECDSA-AES128-GCM-SHA256 version=TLSv1.2 verified=false
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [core]  hook=unrecognized_command plugin=tls function=upgrade_connection params=STARTTLS retval=OK msg=""
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [helo.checks] helo_host: bloggs.lan, multi: true, pass:bare_ip, dynamic, host_mismatch, host_mismatch, fail:rdns_match
2020-12-01T20:57:50.000Z [INFO] [-] [cloudron] authenticated as : joe.bloggs@sepheo.co
2020-12-01T20:57:50.000Z [INFO] [084066B5-E28C-4B91-8403-34686796FD91] [core]  hook=unrecognized_command plugin=cloudron function=hook_unrecognized_command params=AUTH retval=OK msg=""
2020-12-01T20:57:50.000Z [NOTICE] [084066B5-E28C-4B91-8403-34686796FD91] [core] disconnect ip=1.2.3.4 rdns=1.2.3.4.example.com helo=bloggs.lan relay=Y early=N esmtp=Y tls=Y pipe=N errors=0 txns=0 rcpts=0/0/0 msgs=0/0/0 bytes=0 lr="" time=0.652
```

## Troubleshooting at the client end

If the server side does not show anything conclusive, you should also
check the logs in your mail client, if you can find and access them.

Some links which might be helpful:

- Windows Outlook/Live Mail: https://www.lifewire.com/log-pop-imap-traffic-outlook-1173620
- Apple Mail on OS X: https://www.lifewire.com/use-apple-mail-troubleshooting-tools-2260913

[Sepheo]: https://sepheo.co
[Cloudron]: https://forum.cloudron.io/
[Cloudron forum]: https://forum.cloudron.io/
[Cloudron email docs]: https://docs.cloudron.io/email/
[Cloudron email client configuration docs]: https://docs.cloudron.io/email/#email-client-configuration
[IMAP]: https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol
[SMTP]: https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol
[Sieve]: https://en.wikipedia.org/wiki/Sieve_(mail_filtering_language)
[ManageSieve]: https://tools.ietf.org/html/rfc5804
