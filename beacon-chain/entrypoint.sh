#!/bin/bash

# Concatenate EXTRA_OPTS string
[[ -n "$CHECKPOINT_SYNC_URL" ]] && EXTRA_OPTS="${EXTRA_OPTS} --checkpoint-sync-url=${CHECKPOINT_SYNC_URL}"

case $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY in
"holesky-geth.dnp.dappnode.eth")
    HTTP_ENGINE="http://holesky-geth.dappnode:8551"
    ;;
"holesky-nethermind.dnp.dappnode.eth")
    HTTP_ENGINE="http://holesky-nethermind.dappnode:8551"
    ;;
"holesky-besu.dnp.dappnode.eth")
    HTTP_ENGINE="http://holesky-besu.dappnode:8551"
    ;;
"holesky-erigon.dnp.dappnode.eth")
    HTTP_ENGINE="http://holesky-erigon.dappnode:8551"
    ;;
*)
    echo "Unknown value for _DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY: $_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY"
    HTTP_ENGINE=$_DAPPNODE_GLOBAL_EXECUTION_CLIENT_HOLESKY
    ;;
esac

exec lighthouse \
    --debug-level $DEBUG_LEVEL \
    --network holesky \
    beacon_node \
    --datadir /root/.lighthouse \
    --http \
    --http-allow-origin "*" \
    --http-address 0.0.0.0 \
    --http-port $BEACON_API_PORT \
    --port $P2P_PORT \
    --metrics \
    --metrics-address 0.0.0.0 \
    --metrics-port 8008 \
    --metrics-allow-origin "*" \
    --execution-endpoint $HTTP_ENGINE \
    --execution-jwt "/jwtsecret" \
    $EXTRA_OPTS
