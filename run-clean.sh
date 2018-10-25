#! /bin/bash
function prepare {
  rm -rf ./project
  rm -rf ./target
  rm -rf ./sbt
  rm -rf ./ivy2

  mkdir project
  echo "sbt.version=1.1.1" > project/build.properties
}

default=0
big=0

function runDefault {
  tmp=`(time -p sbt -sbt-jar sbt-launch-1.0.4-SNAPSHOT-default.jar -ivy ./ivy2 -sbt-dir ./sbt exit) 2>&1 | grep real | sed "s|real ||" | sed "s|[.].*$||"`
  default=`expr $default + $tmp`
}

function runBig {
  tmp=`(time -p sbt -sbt-jar sbt-launch-1.0.4-SNAPSHOT-big.jar -ivy ./ivy2 -sbt-dir ./sbt exit) 2>&1 | grep real | sed "s|real ||" | sed "s|[.].*$||"`
  big=`expr $big + $tmp`
}

for i in {1..3}
do
  prepare
  runDefault

  prepare
  runBig
done

default=`expr $default / 3 | sed "s|[.].*$||"`
big=`expr $big / 3 | sed "s|[.].*$||"`

imp=`expr $default / $big`

echo "|default|big|diff|"
echo "|---|---|---|"
echo "|$default s|$big s|$imp X|"
