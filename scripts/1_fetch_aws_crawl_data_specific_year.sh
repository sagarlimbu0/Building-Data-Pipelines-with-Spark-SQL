#!/bin/bash

# Fetch AWS Crawl Data

: '
    # Arguments for source of data
    - using awk to manipulate each file line by line
    - xargs to copy the list of files and store in {}, this placeholder will hold the filenames available and
        download from the source
    - NOTE: Check for spacing errors, permission to store files to local dir.
        - chmod u+w data
        - $(pwd)/data
'

s3_bucket="commoncrawl"
# dir. to files for year 2023
source_dir="cc-index/collections.test/CC-MAIN-2023-50/indexes"
num_files="299"

# Enter the year input
read -p "Enter the year: " year_input

# files to download are saved on the text file
aws s3 ls s3://${s3_bucket}/${source_dir}/ 2>/dev/null | head -n ${num_files} > download_filenames.txt

# download files
aws s3 ls s3://${s3_bucket}/${source_dir}/ | head -n ${num_files} | awk '{print $4}' #| xargs -I {} aws s3 cp s3://${s3_bucket}/${source_dir}/{} $(pwd)/data/

