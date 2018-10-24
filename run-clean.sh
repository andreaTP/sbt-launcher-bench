#! /bin/bash
function prepare {
  rm -rf ./project
  rm -rf ./target
  rm -rf ./sbt
  rm -rf ./ivy2

  mkdir project
  echo "sbt.version=1.1.1" > project/build.properties
}

function run {
  time sbt -sbt-jar $1 -ivy ./ivy2 -sbt-dir ./sbt exit > /dev/null 2> /dev/null
}

for i in {1..3}
do
  prepare
  echo "default"
  run sbt-launch-1.0.4-SNAPSHOT-default.jar

  echo
  echo

  prepare
  echo "big"
  run sbt-launch-1.0.4-SNAPSHOT-big.jar

  echo
  echo

done
