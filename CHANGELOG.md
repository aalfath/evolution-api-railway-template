# Changelog

Deployers get an "update available" notice on Railway when this repo's `main` changes. Read the entry for the version you're moving to before you apply it.

## 2026-11-24: Evolution API 2.3.8

- **Breaking changes:** none. No database migrations, no new or removed variables, nothing to change on your project.
- Image: `evoapicloud/evolution-api:v2.3.7` → `v2.3.8@sha256:b2712c06caf333c7a7ade3bbbdd25f70c32abb74537ec75f786c24c99675deb3` ([release notes](https://github.com/evolution-foundation/evolution-api/releases/tag/2.3.8)).
- Fix: Baileys now acknowledges the `<status>` stanzas WhatsApp sends to linked devices. Instances that showed `open` but stopped receiving messages (or got them hours late), or dropped with `stream errored out` about every 50 minutes, recover; held-back messages arrive after the update without scanning the QR code again.
- Not fixed in 2.3.8: instance tokens can still act on other instances on the same server ([#2435](https://github.com/evolution-foundation/evolution-api/issues/2435)). The global API key isn't affected.
- How to apply: accept Railway's "update available" notice for the Evolution API service. Your API key, instances, sessions and messages stay as they are; WhatsApp sessions reconnect on their own after the redeploy.
- How to go back: in the Evolution API service's Deployments tab, redeploy your previous (2.3.7) deployment. 2.3.8 made no database changes, so going back is safe.

## 2026-11-16: Deploy on Railway button

- README: added the Deploy on Railway button for the published template (`evolution-api-8`). No change to the deployed service.

## 2026-11-16: Evolution API 2.3.7, built from this repo

- The Railway template `evolution-api-8` now builds the Evolution API service from this repo instead of running the Docker image directly, so future version bumps reach deployers as update notices.
- Image: `evoapicloud/evolution-api:v2.3.7@sha256:1bd8afc4a6cf48822e6cf02469aeae7bd35a12a6b616eacd1291926307f4d339` (unchanged from the image-based template).
- The defaults that used to live in the template's start command are now in `railway-start.sh`. Same values as before.
- New: the start script refuses to start without `AUTHENTICATION_API_KEY` (16+ characters) or `DATABASE_CONNECTION_URI`, so the image's built-in demo key is never the only protection.
- The template now sets `PORT=8080` explicitly.
