FROM ubuntu:14.04.2

# Install couchdb and assorted depedencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    couchdb \
    rebar \
    git \
    make \
    ca-certificates

# Clone and build couch-per-user plugin
RUN mkdir -p /usr/lib/x86_64-linux-gnu/couchdb/plugins && \
    cd /usr/lib/x86_64-linux-gnu/couchdb/plugins && \
    git clone https://github.com/etrepum/couchperuser.git && \
    cd couchperuser && \
    git reset --hard 1.1.0 && \
    make

# Create missing directory
RUN mkdir /var/run/couchdb

# Install local config
COPY local.ini /etc/couchdb/

# Dokku checks file
COPY CHECKS /app/

EXPOSE 5984
ENTRYPOINT ["couchdb"]
