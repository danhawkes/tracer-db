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
ARG ADMIN_PASS=admin
ARG CORS_ORIGINS="http://localhost, https://localhost, http://tracer.arcs.co, https://tracer.arcs.co"
COPY local.ini /etc/couchdb/
RUN sed -i -e "s|\$ADMIN_PASS|${ADMIN_PASS}|g" -e "s|\$CORS_ORIGINS|${CORS_ORIGINS}|g" /etc/couchdb/local.ini

# Dokku checks file
COPY CHECKS /app/

EXPOSE 5984
ENTRYPOINT ["couchdb"]
