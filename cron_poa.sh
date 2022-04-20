#!/bin/sh

echo "$(date): sending POA distribution request"

curl --request POST \
    --url "$POA_BASE_URL/api/twitch/distributeTwitchPOAs" \
    --header "Authorization: Bearer $POA_TOKEN"

curl --request POST \
    --url $POA_HC_DISTRIBUTE_URL