# Notes

## Import existing buckets etc

```bash
doppler run -p terraform -c prd --name-transformer tf-var -- terraform import module.minio_bucket[3].minio_s3_bucket.bucket zalando-postgres
```
