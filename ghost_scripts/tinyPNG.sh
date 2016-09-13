#!/bin/bash

# this is an old script we used for finding large images and reducing them

API_URL="https://api.tinypng.com/shrink"
API_KEY="9o...3ahQBLV"
CREDENTIALS=`echo -n "api:$API_KEY" | base64`
COUNTER=0

IMAGES_DIR="$1"

for i in `find $IMAGES_DIR -name *.png -size +500k`; do
	URL_SMALL_IMAGE=$(curl -i -H "Content-Type: Content-type: image/png" -H "Authorization: Basic $CREDENTIALS" --user "api:$API_KEY" --data-binary @$i -X POST $API_URL | grep "Location" | sed 's/Location: //')
	curl $URL_SMALL_IMAGE > $i
	COUNTER=$((COUNTER + 1))
	echo $COUNTER
done
