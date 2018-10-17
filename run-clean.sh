#! /bin/bash
function prepare {
  rm -rf ./project
  rm -rf ./target
  rm -rf ./sbt
  rm -rf ./ivy2

  mkdir project
  echo "sbt.version=1.2.4" > project/build.properties
}

function run {
  time sbt -sbt-jar $1 -ivy ./ivy2 -sbt-dir ./sbt exit > /dev/null 2> /dev/null
}

for i in {1..10}
do
  prepare
  echo "parallel"
  run sbt-launch-1.0.4-SNAPSHOT-parallel.jar

  prepare
  echo "default"
  run sbt-launch-1.0.4-SNAPSHOT.jar
done
