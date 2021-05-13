#!/bin/sh

echo "Start docker environment with mailhog and mhsendmail..."
docker-compose up -d --remove-orphans --build

echo "Check sending email using the binary in a container built from the mhsendmail image..."

docker-compose run mhsendmail-bin --smtp-addr="mailhog:1025" <<EOF
From: App <app@mailhog.local>
To: Test <test@mailhog.local>
Subject: Test message 1

Some content!
EOF

echo "Email sent! Check http://localhost:18025 to see it!"

echo "Check sending email using the binary in a container which copied the mhsendmail binary from the mhsendmail image..."
docker-compose exec -T mhsendmail-in-image mhsendmail --smtp-addr="mailhog:1025" <<EOF
From: App <app@mailhog.local>
To: Test <test@mailhog.local>
Subject: Test message 2

Some content!
EOF
echo "Email sent! Check http://localhost:18025 to see it!"


echo "Check sending email with php..."
docker-compose exec mhsendmail-with-php php -r "mail('test@mailhog.local', 'Test message 3', 'Some content!', 'From: App <app@mailhog.local>');"
echo "Email sent! Check http://localhost:18025 to see it!"
