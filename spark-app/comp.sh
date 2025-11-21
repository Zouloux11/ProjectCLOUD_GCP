javac -cp "$SPARK_HOME/jars/*" WordCount.java
jar cf wc.jar WordCount*.class
rm *.class

