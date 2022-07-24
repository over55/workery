Start the project.

```
docker-compose up -d
```

Create the organization and the root administrator.

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
```

In your favourite browser, go to [http://localhost:10001](http://localhost:10001).
