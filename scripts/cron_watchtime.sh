#!/bin/sh

echo "$(date): sending POA watchtime request"

curl -f -s -S --request POST \
    --url "$POA_BASE_URL/api/twitch/updateWatchtime" \
    --header "Authorization: Bearer $POA_TOKEN"

curl -f -s -S --request POST \
    --url $POA_HC_WATCHTIME_URL