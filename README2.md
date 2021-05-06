# Start a container


## To try out manually: 
 
> docker run --rm -it wenance/java-nr-vault:latest ash

## To run a local java application 

Step into a the path where app.jar is and execute this:

> docker run --rm -d -v $PWD:/app -w /app -e NEW_RELIC_LICENSE_KEY="yourlicensekey" -e NEW_RELIC_APP_NAME=yourAppName -e VAULT_URL=yourSecretURL -e VAULT_TOKEN=yourVaultToken wenance/java-nr-vault:latest

## To make a custom image 

Using this image as base and don't forget to define license_key and app_name env variables for NewRelic Agent and VAULT_URL and VAULT_TOKEN for vault environment variables configuration.

```docker

FROM wenance/java-nr-vault:jre8-nr4.2.0-alpine-v2.2

WORKDIR /app
ADD app.jar app.jar

ENV NEW_RELIC_LICENSE_KEY yourkey
ENV NEW_RELIC_APP_NAME myCustomApplication
ENV VAULT_URL yourSecretURL
ENV VAULT_TOKEN yourVaultToken
```
