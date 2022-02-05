# Velero

## Backup

## Restore

* Delete deployments for affected pods
(velero recreates the deployment with a initpod to do a restic restore for the pv's)

View backups
```
❯ velero get backups
NAME                                 STATUS            ERRORS   WARNINGS   CREATED                          EXPIRES   STORAGE LOCATION   SELECTOR
migration                            PartiallyFailed   29       0          2022-02-02 20:42:00 +1100 AEDT   28d       default            <none>
velero-daily-backup-20220203060031   Completed         0        1          2022-02-03 17:00:31 +1100 AEDT   6d        default            <none>
velero-daily-backup-20220203060005   PartiallyFailed   6        0          2022-02-03 06:00:05 +1100 AEDT   6d        default            <none>
velero-daily-backup-20220202230105   PartiallyFailed   6        0          2022-02-02 23:01:12 +1100 AEDT   5d        default            <none>
velero-daily-backup-20220202222651   PartiallyFailed   29       0          2022-02-02 22:26:51 +1100 AEDT   5d        default            <none>
velero-daily-backup-20220202090827   Completed         0        1          2022-02-02 20:08:27 +1100 AEDT   5d        default            <none>
velero-daily-backup-20220202060037   PartiallyFailed   29       0          2022-02-02 06:00:37 +1100 AEDT   5d        default            <none>
velero-daily-backup-20220201060036   PartiallyFailed   29       0          2022-02-01 06:00:36 +1100 AEDT   4d        default            <none>
velero-daily-backup-20220131060035   PartiallyFailed   29       0          2022-01-31 06:00:35 +1100 AEDT   3d        default            <none>
velero-daily-backup-20220130060034   PartiallyFailed   32       0          2022-01-30 06:00:34 +1100 AEDT   2d        default            <none>
velero-daily-backup-20220129102534   PartiallyFailed   32       0          2022-01-29 10:25:34 +1100 AEDT   1d        default            <none>
```


Create restore - all namespaces
```
❯ velero create restore restore-1 --from-backup velero-daily-backup-20220203060005
Restore request "restore-1" submitted successfully.
Run `velero restore describe restore-1` or `velero restore logs restore-1`` for more details.
```


Create restore - single namespace
```
❯ velero create restore games --from-backup velero-daily-backup-20220203060005 --include-namespaces games
Restore request "games" submitted successfully.
Run `velero restore describe games` or `velero restore logs games` for more details.
```

## Cross-cluster restore

Essentially, both clusters need to go to the same bucket, and both clusters can see each others backups.
This is a little dicky with backup naming if they arent unique.

## Manual restore from restic

When i did my cross cluster restore I had issues where it wouldnt restore, possibly due to renaming by storageblockclass in the new cluster (so velero PVC's wouldnt run, and the initi container in the new deployment hung)

To restore manually from s3:

Ensure the new deployments and pvc's are running OK.  No need to delete anything this time, and no need to spin them down.

```
❯ mkdir /tmp/velero

# Mount namespace to a local directory - in this case it was my games dir
❯ restic -r s3:http://hyperion.lab:9000/velero/restic/games/ mount /tmp/velero/
repository afddcb20 opened successfully, password is correct
Now serving the repository at /tmp/velero/
When finished, quit with Ctrl-c or umount the mountpoint.
```

In another terminal:
```


```