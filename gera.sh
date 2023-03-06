#!/bin/bash
# ./gera.sh "string_da_chave" "Nome do Estabelecimento ou Pessoa" "Cidade" "valor (opcional, formato 0.00)"
#
#
FORMAT="01"
(( ${#FORMAT} < 10 )) && S_FORMAT=0${#FORMAT} || S_FORMAT=${#FORMAT}
GUI="br.gov.bcb.pix"
(( ${#GUI} < 10 )) && S_GUI=0${#GUI} || S_GUI=${#GUI}
CHAVE="$1"
(( ${#CHAVE} < 10 )) && S_CHAVE=0${#CHAVE} || S_CHAVE=${#CHAVE}
MERCHANT_CATEGORY="0000"
(( ${#MERCHANT_CATEGORY} < 10 )) && S_MERCHANT_CATEGORY=0${#MERCHANT_CATEGORY} || S_MERCHANT_CATEGORY=${#MERCHANT_CATEGORY}
CURRENCY="986"
(( ${#CURRENCY} < 10 )) && S_CURRENCY=0${#CURRENCY} || S_CURRENCY=${#CURRENCY}
COUNTRY="BR"
(( ${#COUNTRY} < 10 )) && S_COUNTRY=0${#COUNTRY} || S_COUNTRY=${#COUNTRY}
MERCHANT_NAME="$2"
(( ${#MERCHANT_NAME} < 10 )) && S_MERCHANT_NAME=0${#MERCHANT_NAME} || S_MERCHANT_NAME=${#MERCHANT_NAME}
MERCHANT_CITY="${3// /.}"
(( ${#MERCHANT_CITY} < 10 )) && S_MERCHANT_CITY=0${#MERCHANT_CITY} || S_MERCHANT_CITY=${#MERCHANT_CITY}
TXID="***"
(( ${#TXID} < 10 )) && S_TXID=0${#TXID} || S_TXID=${#TXID}
[ ! -z "$4" ] && {
  (( ${#4} < 10 )) && VALOR=540${#4}${4} || VALOR=54${#4}${4}
}

string="00${S_FORMAT}${FORMAT}\
26$((${S_GUI}+${S_CHAVE}+8))\
00${S_GUI}${GUI}\
01${S_CHAVE}${CHAVE}\
52${S_MERCHANT_CATEGORY}${MERCHANT_CATEGORY}\
53${S_CURRENCY}${CURRENCY}${VALOR}\
58${S_COUNTRY}${COUNTRY}\
59${S_MERCHANT_NAME}${MERCHANT_NAME^^}\
60${S_MERCHANT_CITY}${MERCHANT_CITY^^}\
620705${S_TXID}${TXID}\
6304"

# nao consegui uma implementacao crc-ccitt no linux, entao uso esse site

crc=$(curl -s "https://www.lammertbies.nl/include/crc-calculation.php?crc=${string// /%20}&method=ascii" | grep -Eo 'CRC-CCITT \(0xFFFF\)</td><td align="left"><b>0x[0-9A-F]+' | cut -f3 -dx)

echo $string$crc
