FROM bash AS build

# Install CURL
RUN apk add curl

# Download mhsendmail
# see https://github.com/mailhog/mhsendmail/releases/tag/v0.2.0
RUN curl --fail --silent --location --output /tmp/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64

# Make mhsendmail executable
RUN chmod +x /tmp/mhsendmail

FROM scratch

COPY --from=build /tmp/mhsendmail /usr/bin/mhsendmail

ENTRYPOINT ["mhsendmail"]