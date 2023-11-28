#!/bin/bash

# Define the directory
packageDir="packages"

# Read the README file
readme=$(cat README.md)

# Split the README content at the "### List" section
readmePart1=${readme%%"### List"*}
readmePart2=${readme#*"### List"}

# Split the second part again at the first occurrence of a blank line
readmePart2=${readmePart2#*$'\n\n'}

# Start the table with headers
table="| File | Package Name |\n| --- | --- |\n"

# Loop through each file
for file in $packageDir/*.txt; do
    # Get the base name of the file (without extension)
    baseName=$(basename "$file" .txt)
    # Loop through each line in the file
    while IFS= read -r line; do
        # Add a row to the table for each package
        table+="| \`$baseName\` | [$line](https://community.chocolatey.org/packages/$line) |\n"
    done < <(cat "$file"; echo)
done

# Combine the README parts and the new table
newReadme="$readmePart1### List\n$table$readmePart2"

# Write the new content to the README file
echo -e "$newReadme" > README.md
