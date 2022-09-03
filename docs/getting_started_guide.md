Workery can be installed on all operating systems supporting [Docker](https://www.docker.com).

1. Clone the project to your machine.

  ```shell
  git clone git@github.com:over55/workery.git
  ```

2. Go into the project.

  ```shell
  cd workery
  ```

3. Create the environment variable file named `.env` inside `workery` folder and populate it with the following content:

  ```text
  WORKERY_DB_NAME=workery_v2_db
  WORKERY_DB_USER=golang
  WORKERY_DB_PASSWORD=123password
  WORKERY_AWS_S3_ACCESS_KEY=XXXXXXXXXXXXXXX
  WORKERY_AWS_S3_SECRET_KEY=YYYYYYYYYYYYYYY
  WORKERY_AWS_S3_ENDPOINT=https://nyc3.digitaloceanspaces.com
  WORKERY_AWS_S3_REGION=us-east-1
  WORKERY_AWS_S3_BUCKET_NAME=workery
  WORKERY_APP_SIGNING_KEY=ZZZZZZZZZZZZZZZZZZ
  ```

4. Please note environment variable values to your own build. **You will need access to a simple storage server to fill out the `s3` environment variables.**

5. Start the self-host server by running the following docker compose file:

  ```shell
  docker-compose up -d
  ```

6. If everything correctly you should see a message saying: `workery_backend | 2022/09/03 04:17:35 Worker and server started at 0.0.0.0:8000
  `

7. The next step is we will need to log into the running container for the *backend* so we can finish setting up our accounts.

  ```shell
  docker compose run backend /app/workery-server version shell
  ```

8. Create your *organization* in the system:

  ```shell
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
  ```

9. Create our *root administrator* (a.k.a. Executive) in the system. Please change the password `secret` to something else please!

  ```shell
  docker compose run --rm backend /app/workery-server create_user \
      --tid=1 \
      --fname="Root" \
      --lname="Administrator" \
      --email="admin@admin.com" \
      --password="secret" \
      --role_id=1 \
      --state=1
  ```

10. In your favourite browser, go to [http://localhost:10001](http://localhost:10001). If you see a login page, congratulations you've setup `workery`. Please login with the *root administrator* user you created earlier.
