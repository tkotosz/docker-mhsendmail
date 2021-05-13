# docker-mhsendmail

Docker image for mhsendmail

## Run it directly

Create a network with an smtp server
```bash
docker network create mhsendmailtest
docker run --rm -d --network mhsendmailtest --name testmailhog -h testmailhog -p "18025:8025" mailhog/mailhog:v1.0.1
```

Open `localhost:18025` to see mailhog.

Send test email:
```bash
docker run --rm --network mhsendmailtest -i tkotosz/mhsendmail:0.2.0 --smtp-addr="testmailhog:1025" <<EOF
From: App <app@mailhog.local>
To: Test <test@mailhog.local>
Subject: Test message

Some content!
EOF
``` 

Cleanup when you are done:
```bash
docker stop testmailhog
docker network rm mhsendmailtest
```

## Add mhsendmail to your image

```
FROM alpine

COPY --from=tkotosz/mhsendmail:0.2.0 /usr/bin/mhsendmail /usr/local/bin/

...
```
