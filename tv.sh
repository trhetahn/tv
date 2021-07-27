#!/bin/bash

string=""
while [ "$string" = "" ]
do
    string=$(curl -k 'https://chch.cdn.clearcable.net/'   -H 'Connection: keep-alive'   -H 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36'   -H 'Accept: */*'   -H 'Sec-Fetch-Site: cross-site'   -H 'Sec-Fetch-Mode: no-cors'   -H 'Sec-Fetch-Dest: script'   -H 'Referer: https://www.chch.com/live/'   -H 'Accept-Language: en-US,en;q=0.9'   --compressed | grep playlist | cut -d "'" -f 2)
done

string2=$(dirname "$string")
string=$(curl -k "$string" --compressed | sed '$!d')
string=$string2"/"$string
string=$(echo "${string}" | sed -e 's/\&/\\&/g' )

sed -i -e "4s@.*@$string@" ch.m3u8

git add .
git commit -m "scheduled update"
git push -f
