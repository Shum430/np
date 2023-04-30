#!/bin/bash

# Змінні, що містять адресу веб-сервера та ключ API Mailgun
SERVER_URL="http://localhost"
MAILGUN_API_KEY="api:91ed235a12c5c482e15e43b75cc83c9a-70c38fed-f1693a8f"
MAILGUN_URL="https://api.mailgun.net/v3/sandboxea7c2c96a48046f79529bc4342622853.mailgun.org/messages"

# Функція, що перевіряє код відповіді веб-сервера та надсилає повідомлення про помилку електронною поштою через API Mailgun
function check_status {
  status=$(curl -s -o /dev/null -w '%{http_code}' $SERVER_URL)
  if [[ $status != 2* && $status != 3* ]]; then
    message="Server returned status $status at $(date '+%Y-%m-%d %H:%M:%S')"
    curl -s --user "$MAILGUN_API_KEY" "$MAILGUN_URL" \
      -F from='Mailgun Sandbox <postmaster@sandboxea7c2c96a48046f79529bc4342622853.mailgun.org>' \
      -F to='Andriy Shumskyy <avstralopitek71@gmail.com>' \
      -F subject='Server Error' \
      -F text="Server returned status $status at $(date '+%Y-%m-%d %H:%M:%S')"
  fi
}

# Запускаємо функцію перевірки статусу через кожні 30 секунд
while true; do
  check_status
  sleep 30
done