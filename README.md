# tracer-db

> Dockerfile that builds an instance of couchdb for the [tracer-webapp][1].

## Usage

Build args:

`ADMIN_PASS` - Password used to authorise the web backend to make administrative changes to the DB.
`CORS_ORIGINS` - Allowed CORS origins. Normally this should be the web server's scheme and domain.

[1]: https://github.com/danhawkes/tracer-webapp
