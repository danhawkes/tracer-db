FROM ubuntu:14.04.2

# Install couchdb and assorted depedencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    couchdb \
    rebar \
    git \
    make \
    ca-certificates

# Clone and build couch-per-user plugin
RUN mkdir -p /usr/lib/couchdb/plugins && \
    cd /usr/lib/couchdb/plugins && \
    git clone https://github.com/etrepum/couchperuser.git && \
    cd couchperuser && \
    git reset --hard 1.1.0 && \
    make

# Create missing directory
RUN mkdir /var/run/couchdb

# Install local config
COPY local.ini /etc/couchdb/

EXPOSE 5984
ENTRYPOINT ["couchdb"]



