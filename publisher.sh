#!/bin/bash

curl -OL https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar

git clone https://github.com/HealthDataWorks/fhir-ig-template-base.git custom-template

export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8
java -jar publisher.jar -ig ig.ini