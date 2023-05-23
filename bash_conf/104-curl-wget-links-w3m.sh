
# https://www.tecmint.com/test-website-loading-speed-in-linux-terminal/
ct_curl_test_speed_site() {
   : ${1?: "<url>"}
   curl -s -w 'Testing Website Response Time for: %{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nAppCon Time:\t\t%{time_appconnect}\nRedirect Time:\t\t%{time_redirect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null $1
}

ct_curl_config_ignore_ssl() {
   echo "insecure" >> ~/.curlrc
}