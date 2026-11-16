# Evolution API on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/evolution-api-8?utm_medium=integration&utm_source=button&utm_campaign=evolution-api)

One-click Railway template for [Evolution API](https://github.com/evolution-foundation/evolution-api) **2.3.7**, the open-source REST API for WhatsApp (Baileys QR-code connection or the official WhatsApp Cloud API), with its web manager.

## What the template deploys

| Service | Source | Notes |
|---|---|---|
| Evolution API | this repo (`Dockerfile`) | `evoapicloud/evolution-api:v2.3.7` pinned by digest, public domain, health check `/`, volume at `/evolution/instances` |
| Postgres | Railway Postgres 18 | instances, sessions, contacts, chats and messages |
| Redis | Railway Redis 8.2 | cache |

`railway-start.sh` sets the defaults (Postgres provider, Redis cache on, telemetry off, data saving on, `DEL_INSTANCE=false`, `LANGUAGE=en`), then runs the database migrations and starts the API. Any variable you add on the service wins over these defaults.

## Variables

| Variable | Default | Purpose |
|---|---|---|
| `AUTHENTICATION_API_KEY` | generated, 48 characters | Global API key: the `apikey` header for every call, and the manager login |
| `SERVER_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Base URL used in webhooks, QR and media links. Change it after adding a custom domain |
| `DATABASE_CONNECTION_URI` | `${{Postgres.DATABASE_URL}}` | Postgres connection |
| `CACHE_REDIS_URI` | `${{Redis.REDIS_URL}}` | Redis connection |
| `PORT` | `8080` | Port the API listens on (Railway routes the domain and health check here) |

Nothing is asked at deploy time. Optional features (webhooks, RabbitMQ, S3, Chatwoot, Typebot, OpenAI and the rest) are switched on by adding variables from the [environment reference](https://docs.evolutionfoundation.com.br/en/evolution-api/configuration/env).

## First steps

1. Open `https://YOUR-DOMAIN/manager`.
2. Server URL: your Railway domain. API key: the `AUTHENTICATION_API_KEY` variable of the Evolution API service.
3. Create an instance and scan its QR code in WhatsApp under *Linked devices*.

## Updates

The Evolution API service builds from this repo's `main` branch. When the pinned image moves to a new version, the change lands on `main` with a `CHANGELOG.md` entry, and Railway shows deployers an "update available" notice. Nothing changes on your project until you apply it.

2.4.0 is still a release candidate and requires activating each server against Evolution Foundation's licensing service, so this template stays on 2.3.7 until a stable release without that requirement (or 2.3.8) ships.
