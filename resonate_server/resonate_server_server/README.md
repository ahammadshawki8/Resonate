# resonate_server_server

This is the starting point for your Serverpod server.


## Local development and migration workflow

1. Start Postgres and Redis (easiest with Docker):
   
    docker compose up --build --detach

2. Generate code and migrations:
    dart run serverpod_cli generate

3. If you have made changes to your models, create a new migration:
    dart run serverpod_cli create-migration

4. Start the Serverpod server and apply migrations automatically:
    dart bin/main.dart --apply-migrations

5. When finished, shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis:
    docker compose stop
