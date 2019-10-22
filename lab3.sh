#!/bin/sh
DATABASE=setdb
QUIT=quit

printf "Grock - "
read prompt

while test $prompt != $QUIT
do
  if test $prompt != $DATABASE
  then
    printf "%b" "Unrecognized command. \n" "Grock - "
    read prompt

  elif test ! -e $2
  then
    printf "%b" "File $2 does not exist. \n" "Grock - "
    read prompt

  elif test ! -r $2
  then
    printf "%b" "File $2 is not readable. \n" "Grock - "
    read prompt

  elif test $# -eq 0
  then
    printf "%b" "Missing Argument. \n" "Grock - "
    read prompt

  elif test $# -eq 2
  then
    printf "%b" "Database set to $2 \n" "Extra arguments ignored. \n" "Grock - "
    read prompt

  else
    printf "%b" "Database set to $2 \n" "Grock - "
    read prompt
  fi
done
