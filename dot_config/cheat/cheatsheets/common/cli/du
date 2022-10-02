# -c for toal, -a for all files, -h for human readable

# Exclude other file system (i.e. not /mnt)
du -shcx /

# Summary of files size filtered by `find`
find . -type f -iname '*.mp3' -exec du -shc {} \+ | sort -h

# To sort directories/files by size
du -sk *| sort -rn

# To show cumulative humanreadable size
du -sh
