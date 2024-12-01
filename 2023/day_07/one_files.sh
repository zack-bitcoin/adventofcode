awk -f one_files.awk input | sort | awk '{ sum = sum + (NR * $3) } END{print(sum)}'
