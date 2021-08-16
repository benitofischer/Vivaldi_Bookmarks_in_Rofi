#!/usr/bin/env bash

# _____ ________________________________________________________ 
# |  _ \|  ____|                                                |
# | |_) | |__           Benito Fischer                          |
# |  _ <|  __|          https://github.com/benitofischer        |
# | |_) | |             email: linux@benito-fischer.com         |
# |____/|_|_____________________________________________________|
#
# vbm-open.sh - erstellt: Mon, 16 Aug 2021 21:23:25 +0200
#
# Vivaldi Bookmarks in "Rofi -dmenu" durchsuchen und URL öffnen

BROWSER=vivaldi

jq -r '.roots[] | recurse(.children[]?) | [.url,.name, (.meta_info|.Description|tostring)] | join("\n") |. + "\n."' <~/.config/vivaldi/Default/Bookmarks |\
  sed -e 's/;/,/g' -e ':a;N;$!ba;s/\n/;/g' -e 's/;.;/\n/g' -e 's/\;null\;//g' -e 's/null//g' |\
   awk --field-separator=";" '/^[^;]/ {print $1," | ",$2," | ",$3}' |\
    sort |\
     uniq |\
      rofi -dmenu |\
       $BROWSER $(awk '{print $1}')
   
         
