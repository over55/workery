1. Attach the repositories.

```bash
git submodule add git@github.com:over55/workery-server.git workery-server
git submodule add git@github.com:over55/workery-front.git workery-front
```

2. Go inside `workery-server` folder, create a `.env` file.

```bash
touch .env
```
3. Then copy and paste in the following (but replace `xxx` with your own values):

```bash
export WORKERY_OLD_DB_HOST=localhost
export WORKERY_OLD_DB_PORT=5432
export WORKERY_OLD_DB_USER=golang
export WORKERY_OLD_DB_PASSWORD=123password
export WORKERY_OLD_DB_NAME=workery_db
export WORKERY_OLD_AWS_S3_ACCESS_KEY=xxx
export WORKERY_OLD_AWS_S3_SECRET_KEY=xxx
export WORKERY_OLD_AWS_S3_ENDPOINT=https://xxx.digitaloceanspaces.com
export WORKERY_OLD_AWS_S3_REGION=xxx
export WORKERY_OLD_AWS_S3_BUCKET_NAME=xxx
export WORKERY_DB_HOST=localhost
export WORKERY_DB_PORT=5432
export WORKERY_DB_USER=golang
export WORKERY_DB_PASSWORD=123password
export WORKERY_DB_NAME=workery_v2_db
export WORKERY_AWS_S3_ACCESS_KEY=xxx
export WORKERY_AWS_S3_SECRET_KEY=xxx
export WORKERY_AWS_S3_ENDPOINT=https://xxx.digitaloceanspaces.com
export WORKERY_AWS_S3_REGION=xxx
export WORKERY_AWS_S3_BUCKET_NAME=xxx
export WORKERY_APP_IP=0.0.0.1
export WORKERY_APP_PORT=8000
export WORKERY_APP_SIGNING_KEY=xxx
export WORKERY_APP_REDIS_ADDRESS=localhost:6379
export WORKERY_BLEVE_SERVER_ADDRESS=127.0.0.1:8001
```

4. Create the organization and the root administrator.

```shell
# Run the following to check which version of backend you are using. Output should be `Workery Server v2.0`.
docker compose run backend /app/workery-server version shell

# Create our organization tenant in the system.
docker compose run --rm backend /app/workery-server create_tenant \
    --name="Over 55 (London) Inc." \
    --schema_name="workery" \
    --email="info@o55.ca" \
    --telephone="123-456-7898" \
    --timezone="utc" \
    --address_country="Canada" \
    --address_region="Ontario" \
    --address_locality="London" \
    --area_served="Middlesex" \
    --available_language="en" \
    --post_office_box_number="" \
    --postal_code="N6H1B4" \
    --street_address="78 Riverside Dr" \
    --street_address_extra="" \
    --state=1

# Create our root administrator (a.k.a. Executive) in the system.
docker compose run --rm backend /app/workery-server create_user \
    --tid=1 \
    --fname="Root" \
    --lname="Administrator" \
    --email="admin@admin.com" \
    --password="secret" \
    --role_id=1 \
    --state=1
```

In your favourite browser, go to [http://localhost:10001](http://localhost:10001).
