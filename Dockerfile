# Evolution API, official image pinned by version and digest.
# Bump both the tag and the digest together, and add a CHANGELOG.md entry.
FROM evoapicloud/evolution-api:v2.3.8@sha256:b2712c06caf333c7a7ade3bbbdd25f70c32abb74537ec75f786c24c99675deb3

COPY railway-start.sh /evolution/railway-start.sh

WORKDIR /evolution
ENTRYPOINT ["/bin/bash", "/evolution/railway-start.sh"]
CMD []
