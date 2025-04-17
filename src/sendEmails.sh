#!/usr/bin/env bash

PROJECT_FOLDER="$(cd "$(dirname "$(realpath "$0")")/../" &>/dev/null && pwd)"

email_value="$(cat "${PROJECT_FOLDER}/data/user.json" | jq -r '.email')"

curl -v --url 'smtps://smtp.gmail.com:465' \
  --ssl-reqd \
  --mail-from "${EMAIL_USERNAME}" \
  --mail-rcpt "${email_value}" \
  --mail-rcpt "${EMAIL_USERNAME}" \
  --user "${EMAIL_USERNAME}:${EMAIL_PASSWORD}" \
  -F '=(;type=multipart/mixed' \
  -F "=Hola!

Estàs rebent aquest correu perquè una nova signatura per a l'email d'ASBTEC ${email_value} ha estat generada. Descarrega el fitxer adjunt d'aquest correu i actualitza la teva signatura al teu client de correu electrònic.

Si has rebut més d'un correu d'aquest tipus fes servir el contingut de l'últim mail per a actualitzar la firma, doncs serà la versió més actualitzada. Pots borrar la resta.

En aquest vídeo podràs trobar instruccions sobre com instalar la firma al teu compte de correu d'ASBTEC: https://youtu.be/v4Mi0DMAwQU . Recorda que només podràs veure el vídeo si estàs loguejat a YouTube amb el teu compte d'ASBTEC.

Aquest missatge ha estat auto-generat. Per qualsevol problema contacta amb informatica@asbtec.cat.

Fins aviat!

A
;type=text/plain" \
  -F "file=@${PROJECT_FOLDER}/out/${email_value}.html;type=text/html;encoder=base64" \
  -F '=)' \
  -H "Subject: Actualització de signatures d'email" \
  -H "From: Informàtica ASBTEC <informatica@asbtec.cat>" \
  -H "To: ${EMAIL_USERNAME} <${EMAIL_USERNAME}>"
