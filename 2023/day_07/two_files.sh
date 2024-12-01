awk -f two_files.awk input | sort | awk '{ sum = sum + (NR * $3) } END{print(sum)}'
#awk -f two_files.awk example | sort

#incorrect 248812215
#incorrect 249815038
