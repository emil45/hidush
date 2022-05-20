# hidush

Something new happens

## Deploying Google Functions

Run the following command in the directory that contains the `main.py` file

```
gcloud beta functions deploy cms-upsert-hidush \
--gen2 \
--runtime python39 \
--trigger-http \
--entry-point main_upsert_hidush \
--memory 128Mi \
--set-env-vars CMS_API_KEY=XXXXXXX \
--source . \
--allow-unauthenticated
```

### Test the function

```
gcloud beta functions describe cms-upsert-hidush --gen2
```
