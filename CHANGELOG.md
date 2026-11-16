# Changelog

Deployers get an "update available" notice on Railway when this repo's `main` changes. Read the entry for the version you're moving to before you apply it.

## 2026-11-16: Deploy on Railway button

- README: added the Deploy on Railway button for the published template (`evolution-api-8`). No change to the deployed service.

## 2026-11-16: Evolution API 2.3.7, built from this repo

- The Railway template `evolution-api-8` now builds the Evolution API service from this repo instead of running the Docker image directly, so future version bumps reach deployers as update notices.
- Image: `evoapicloud/evolution-api:v2.3.7@sha256:1bd8afc4a6cf48822e6cf02469aeae7bd35a12a6b616eacd1291926307f4d339` (unchanged from the image-based template).
- The defaults that used to live in the template's start command are now in `railway-start.sh`. Same values as before.
- New: the start script refuses to start without `AUTHENTICATION_API_KEY` (16+ characters) or `DATABASE_CONNECTION_URI`, so the image's built-in demo key is never the only protection.
- The template now sets `PORT=8080` explicitly.
