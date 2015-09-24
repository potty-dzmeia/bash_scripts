#!/bin/bash


if [ "$#" -lt 2 -o "$#" -gt 3 ] ;
then
  echo "Script expects at least 2 parameters: [http://website_address] and [email_address1] [email_address2 (optional)] "
  exit 1
fi

target=$1
email1=$2
email2=$3


# If we can get the site and there is an  "</html>" we assume it is up and running
if (/usr/bin/wget $target --timeout 10 -O - 2>/dev/null  | grep "</html>") then
      echo "Website $target is UP!"
else
      echo "Website $target is DOWN!" | mail -s "The site: $target is down" $email1
      if [ -n "$email2" ]; then
        echo "Website $target is DOWN!" | mail -s "The site: $target is down" $email2 
      fi
fi


