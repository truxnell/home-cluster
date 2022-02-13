# Postgresql

## Backups

Backups are created by the pg_dumpall cornjob

## Restoring backup

Grab the latest (or desired) zip, extract and pipe the zip into psql.
(needs postgresql package in your OS)

`psql -h postgress.<cluster_domain>.<tld> -p 5432 -U postgres < kubegres-database-backup-<date>`
