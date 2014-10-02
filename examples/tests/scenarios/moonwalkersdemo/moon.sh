#!/bin/bash
export JAVA_HOME=$(/usr/libexec/java_home)

# This script assumes a working RMLProcessor installation including Maven, Java 1.7. ( build with:  mvn -e clean install)  
# See http://rml.io/RML_R2RML.html for details

# The template/mapping file is expressed in RML
# This is a generalization of W3C R2RML that extends the notion of 'column' to include JSON and XML inputs, as well as CSV.
# Where R2RML requires SQL table names, here we need full path to a CSV file. This is stored in a source.properties 
# file which we generate (and delete afterwards). RML is expressed in RDF written in W3C Turtle format.
# 
# NOTE: Update DIR below to give full path where you have this directory.



## CONFIGURATION ##

RMLPROC=$HOME/working/csv/RMLProcessor # From https://github.com/mmlab/RMLProcessor/tree/development

DIR=$HOME/working/csv/git/csvw/examples/tests/scenarios/moonwalkersdemo # Unix path to working folder containing:

 RMLFILE=museum-model.rml.ttl          # An RML mapping file, expressing CSV to RDF templates. 
 PATHINRML=/example5/moon-walkers.csv  # Path as written in the RMLFile
 CSVFILE=moon-walkers.csv              # CSV file, including 
 OUTFILE=_output.nt.txt                # File for output RDF graph (W3C N-Triples format)

## END CONFIGURATION


echo "$PATHINRML=$DIR/$CSVFILE" > source.properties
echo "!OVERWRITING $DIR/source.properties! contents:"
cat "$DIR/source.properties"

cd $RMLPROC; mvn exec:java -f $RMLPROC/pom.xml -e -Dexec.args="$DIR/$RMLFILE $DIR/$OUTFILE -sp $DIR/source.properties"
echo "!Cleaning $DIR/source.properties"
rm $DIR/source.properties
