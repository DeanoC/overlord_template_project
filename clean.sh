#!/bin/bash
# This script cleans up files created by run.sh in the overlord_template_project directory

echo "Cleaning up files created by run.sh..."

# Remove the report file
if [ -f "report.txt" ]; then
  echo "Removing report.txt"
  rm report.txt
fi

# Remove the generated files in the soft directory
if [ -d "soft/" ]; then
  echo "Removing generated files in soft directory"
  rm -rf soft
fi

# Remove the generated files in the gate directory
if [ -d "gate/" ]; then
  echo "Removing generated files in gate directory"
  rm -rf gate
fi

echo "Cleanup complete!"