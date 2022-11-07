#!/bin/bash

if [[ $# -ne 3 ]]; then
  echo 'Usage: date year upto e.g. "JAN 1" 2020 5 (Makes 6 robo-commits when run first time on this date, otherwise 5)'
  exit
fi

date="$1"
year="$2"
upto="$3"

touch "contribution-$date-$year"
git add "contribution-$date-$year"
GIT_AUTHOR_DATE="$date 00:00:00 $year -0500" git commit -m "make contribution $date $year"

if [[ $upto -eq 0 ]]; then
  exit
fi

for x in $(eval echo "{1..$upto}"); do
  echo "+$x" >> "contribution-$date-$year"
  git add .
  GIT_AUTHOR_DATE="$date 00:00:00 $year -0500" git commit -m "contribution $date $year +$x"
done
