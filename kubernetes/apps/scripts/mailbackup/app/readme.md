# Redacted getmail6 config

A redacted ini for getmail could be like the below.  This is put in the `secrets.sops.yaml` file
```ini
[retriever]
type = SimpleIMAPSSLRetriever
server = email.provider.com
port: 993
username = username
password = password
mailboxes = ALL

[destination]
type=Maildir
path=/data/foldername/

[options]
readall = false
verbosity = 2
```
