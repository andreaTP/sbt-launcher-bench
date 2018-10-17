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

for i in {1..1}
do
  # prepare
  # echo "parallel"
  # run sbt-launch-1.0.4-SNAPSHOT-parallel.jar

  # echo
  # echo

  # prepare
  # echo "parallel-parallel"
  # run sbt-launch-1.0.4-SNAPSHOT-parallel-parallel.jar

  # echo
  # echo

  prepare
  echo "fixed"
  run sbt-launch-1.0.4-SNAPSHOT-fixed.jar

  echo
  echo

  # prepare
  # echo "default"
  # run sbt-launch-1.0.4-SNAPSHOT.jar

  # echo
  # echo
done
