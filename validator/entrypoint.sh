#!/bin/bash

NETWORK="holesky"
VALIDATOR_PORT=3500

#Handle Graffiti Character Limit
oLang=$LANG oLcAll=$LC_ALL
LANG=C LC_ALL=C
graffitiString=${GRAFFITI:0:32}
LANG=$oLang LC_ALL=$oLcAll

exec -c lighthouse \
    --debug-level=${DEBUG_LEVEL} \
    --network=${NETWORK} \
    validator \
    --enable-doppelganger-protection \
    --init-slashing-protection \
    --datadir /root/.lighthouse \
    --beacon-nodes $BEACON_NODE_ADDR \
    --graffiti="${graffitiString}" \
    --http \
    --http-address 0.0.0.0 \
    --http-port ${VALIDATOR_PORT} \
    --http-allow-origin "*" \
    --unencrypted-http-transport \
    --metrics \
    --metrics-address 0.0.0.0 \
    --metrics-port 8008 \
    --metrics-allow-origin "*" \
    --suggested-fee-recipient="${FEE_RECIPIENT_ADDRESS}" \
    $EXTRA_OPTS
