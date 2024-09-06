#!/bin/bash

set -o errexit -o nounset -o pipefail

export R2_ENDPOINT="https://<accountid>.r2.cloudflarestorage.com"

r2() {
    aws s3 --endpoint-url "$R2_ENDPOINT" "$@"
}

r2api() {
    aws s3api "$1" --endpoint-url "$R2_ENDPOINT" --bucket "$R2_BUCKET_NAME" "${@:2}"
}

bucket_exists() {
    r2 ls "$R2_BUCKET_NAME" &> /dev/null
}

create_bucket() {
    echo "Bucket $R2_BUCKET_NAME doesn't exist. Creating it now..."

    # create bucket
    r2api create-bucket

    # Note: R2 doesn't support public access block, versioning, or encryption configuration
    # These AWS S3 specific commands have been removed
}

ensure_bucket_exists() {
    if bucket_exists; then
        return
    fi    
    create_bucket
}

pg_dump_database() {
    pg_dump  --no-owner --no-privileges --clean --if-exists --quote-all-identifiers "$DATABASE_URL"
}

upload_to_bucket() {
    r2 cp - "s3://$R2_BUCKET_NAME/$(date +%Y/%m/%d/backup-%H-%M-%S.sql.gz)"
}

main() {
    ensure_bucket_exists
    echo "Taking backup and uploading it to Cloudflare R2..."
    pg_dump_database | gzip | upload_to_bucket
    echo "Done."
}

main
