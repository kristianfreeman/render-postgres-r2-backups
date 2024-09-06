# Deploy a Cron Job to Backup PostgreSQL to Cloudflare R2

> This repo is a fork of [render-examples/backup-postgresql-to-s3](https://github.com/render-examples/backup-postgresql-to-s3) by [Render](https://render.com), modified to use Cloudflare R2 instead of Amazon S3.

This repo can be used to deploy a [Cron Job](https://render.com/docs/cronjobs) on [Render](https://render.com) to backup a PostgreSQL instance to Cloudflare R2.

Fork this repo and click the button below to deploy.

You'll need to set corresponding OS and Postgres versions:

| `POSTGRES_VERSION` | `ALPINE_VERSION` |
| :----------------: | :--------------: |
| 16                 | 3.20             |
| 15                 | 3.20             |
| 14                 | 3.20             |
| 13                 | 3.19             |
| 12                 | 3.18             |

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy)

