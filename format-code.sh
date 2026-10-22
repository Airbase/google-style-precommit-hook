#!/usr/bin/env sh
GJF_VERSION=1.37.0
GJF_JAR=google-java-format-${GJF_VERSION}-all-deps.jar
mkdir -p .cache
cd .cache
if [ ! -f "$GJF_JAR" ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v${GJF_VERSION}/${GJF_JAR}"
    chmod 755 "$GJF_JAR"
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
[ -z "$changed_java_files" ] && exit 0
java -jar ".cache/$GJF_JAR" --replace $changed_java_files
