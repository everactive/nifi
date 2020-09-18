#!/bin/bash
#
# syntax:
# ea-build {rebuild|assembly|amqp}
# 
# rebuild: will build the entire Nifi project
# assembly: will re-package the binary artifacts
# amqp: will build our AMQP patch in a NAR file
#

export MAVEN_OPTS="-Xms1024m -Xmx3076m -XX:MaxPermSize=256m"
if [[ "$1" == "rebuild" ]]; then
mvn -T C2.0 clean install -Pinclude-grpc -DskipTests
fi

if [[ "$1" == "assembly" ]]; then
  cd nifi-assembly
  mvn -T C2.0 clean install -Ddir-only
  cd -
fi

if [[ "$1" == "amqp" ]]; then
  cd nifi-nar-bundles/nifi-amqp-bundle
  mvn -T C2.0 clean install -Pinclude-grpc
  cd -
  cp nifi-nar-bundles/nifi-amqp-bundle/nifi-amqp-nar/target/nifi-amqp-nar-1.13.0-SNAPSHOT.nar ./nifi-amqp-nar-1.12.0-everactive.nar
fi

