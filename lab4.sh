#!/bin/sh
printf 'Grock- '
read command
while test "$command" != "quit"
do
  case $command in
    setdb*)
      set $command
      if test $1 = "setdb"
      then
        if test $# -eq 1
        then
          echo Missing Argument.
        else
          database=$2
          if test ! -e $database
          then
            echo File $database does not exist.
          elif test ! -r $database
          then
            echo File $database is not readable.
          else
            cat $database | egrep '^[^ ]+[ ][^ ]+[ ][^ ]+$' | diff $database - > /dev/null
            if test $? = 0
            then
              echo Database set to $database
            else
              echo Incorrect format in $database.
              echo The following lines were incorrectly formatted.
              cat $database | egrep -v '^[^ ]+[ ][^ ]+[ ][^ ]+$'
              echo Database not set.
            fi
          fi
          if test $# -gt 2
          then
            echo Extra arguments ignored.
          fi
        fi
      elif test $1 = "relnames"
      then
        if test ! -e $database
        then
          echo Database not set.
        else
          case $relation in
            aggregation|inheritance|implement)
            cat $database | egrep '^[aggregation]+[implement]+[inheritance]+$'
          esac
        fi
      elif test $1 = "entities"
      then
        if test $database = ''
        then
          echo Database not set.
        else
          case $entities in
            class|interface)
            cat $database | egrep '^[class]+[interface]+$'
          esac
        fi
      else
        echo Unrecognized command.
      fi
      ;;
    *) echo Unrecognized command.;;
  esac
printf 'Grock- '
read command
done
