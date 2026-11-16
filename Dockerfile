# Evolution API, official image pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM evoapicloud/evolution-api:v2.3.7@sha256:1bd8afc4a6cf48822e6cf02469aeae7bd35a12a6b616eacd1291926307f4d339

COPY railway-start.sh /evolution/railway-start.sh

WORKDIR /evolution
ENTRYPOINT ["/bin/bash", "/evolution/railway-start.sh"]
CMD []
