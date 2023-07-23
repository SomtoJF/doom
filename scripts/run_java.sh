#!/bin/bash

# Check if the correct number of arguments (1) is provided
if [ $# -ne 1 ]; then
  echo "Usage: $0 <java_file_path>"
  exit 1
fi

# Get the Java file path from the first argument
java_file_path=$1

# Extract the class name from the file path (remove the directory and file extension)
class_name=$(basename "$java_file_path" .java)

# Compile the Java file using javac
javac "$java_file_path"

# Check if compilation was successful
if [ $? -eq 0 ]; then
  # If successful, run the compiled Java class using java
  java "$class_name"
else
  echo "Compilation failed. Please check your Java file for errors."
fi

