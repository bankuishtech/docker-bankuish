#!/bin/bash

fERROR(){
 echo "[ERROR]: $*"
 exit 1
}
set -e

if [  -n "${VAULT_URL}" ] && [  -n "${VAULT_TOKEN}" ]
then
  if [[ $(echo ${VAULT_URL} | cut -d: -f1) == "http" ]]
   then
    echo "[WARNING]: Old Vault server"
  export $(curl -k -s -H "X-Vault-Token:${VAULT_TOKEN}" "${VAULT_URL}" | jq -r '.data|to_entries|map("\(.key)=\(.value)")[]') #|| fERROR "Curl to $VAULT_URL failed"
   else
    echo "[INFO]: New Vault server"
  export $(curl -s -H "X-Vault-Token:${VAULT_TOKEN}" "${VAULT_URL}" | jq -r '.data.data|to_entries|map("\(.key)=\(.value)")[]') #|| fERROR "Curl to $VAULT_URL failed"
   fi
else
    fERROR  "Environment variables VAULT_URL and VAULT_TOKEN are needed"
fi

exec "$@"
