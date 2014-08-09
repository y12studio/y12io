er-g0v-mean-24h-pending-ward.json 

select mean(pending_ward) from /ER.+/ where time > now() - 24h order asc

http://api-beta.ly.g0v.tw:8086/db/twer/series?p=guest&q=select+mean(pending_ward)+from+%2FER.%2B%2F+where+time+%3E+now()+-+24h+order+asc&time_precision=s&u=guest

select mean(pending_ward) , stddev(pending_ward) from /ER.+/ where time > now() - 24h order asc

http://api-beta.ly.g0v.tw:8086/db/twer/series?p=guest&q=select+mean(pending_ward)+,+stddev(pending_ward)+from+%2FER.%2B%2F+where+time+%3E+now()+-+24h+order+asc&time_precision=s&u=guest