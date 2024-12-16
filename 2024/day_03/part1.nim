# import os
# import re

let fileName = "input.txt"

try:
    let content = readFile(fileName)
    echo content
except OSError:
    echo "Error: Unable to open or read the file."