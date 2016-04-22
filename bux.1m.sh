#!/bin/bash

# <bitbar.title>BUX</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>Jan Stránský</bitbar.author>
# <bitbar.author.github>burningtree</bitbar.author.github>
# <bitbar.desc>Show BUX trading overview.</bitbar.desc>
# <bitbar.image></bitbar.image>

JQ="/usr/local/bin/jq"

# get access token
ACCESS_TOKEN=`cat ~/.bux-config.json | ${JQ} .account.access_token | sed 's/"//g'`
PERF_URL="https://api.getbux.com/core/13/users/me/portfolio/performance"

# fetch data from users/me/portfolio/performance
DATA=`curl -s -H "X-App-Version: 1.36-2697" -H "Accept-Language: en" -H "Authorization: Bearer ${ACCESS_TOKEN}" -H "Host: api.getbux.com" -H "User-Agent: okhttp/3.2.0" ${PERF_URL}`

# match values
PERF=`echo "${DATA}" | ${JQ} .performance | sed 's/"//g'`%
VALUE=`echo "${DATA}" | ${JQ} .accountValue.amount | sed 's/"//g'`
CURRENCY=`echo "${DATA}" | ${JQ} .accountValue.currency | sed 's/"//g'`

# print
echo $PERF
echo "---"
echo "Balance: ${VALUE} ${CURRENCY}"
