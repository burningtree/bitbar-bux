#!/bin/bash

# <bitbar.title>BUX</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>Jan Stránský</bitbar.author>
# <bitbar.author.github>burningtree</bitbar.author.github>
# <bitbar.desc>Show BUX trading overview.</bitbar.desc>
# <bitbar.image></bitbar.image>

JQ="/usr/local/bin/jq -r"

export LC_NUMERIC=en_US.UTF

# get access token
ACCESS_TOKEN=`cat ~/.bux-config.json | ${JQ} .account.access_token`
PERF_URL="https://api.getbux.com/core/13/users/me/portfolio/performance"

# fetch data from users/me/portfolio/performance
DATA=`curl -s -H "X-App-Version: 1.36-2697" -H "Accept-Language: en" -H "Authorization: Bearer ${ACCESS_TOKEN}" -H "Host: api.getbux.com" -H "User-Agent: okhttp/3.2.0" ${PERF_URL}`

# match values
PERF=`echo "${DATA}" | ${JQ} .performance`
PERF_PERC=`echo ${PERF}*100 | bc | xargs printf "%.2f"`%
VALUE=`echo "${DATA}" | ${JQ} .accountValue.amount`
CURRENCY=`echo "${DATA}" | ${JQ} .accountValue.currency`

# print
echo $PERF_PERC
echo "---"
echo "Balance: ${VALUE} ${CURRENCY}"
