BEGIN{
    system("cat input | ./get_ranges.c.exec | sort -n | ./combine_ranges.c.exec | ./sum_range_sizes.c.exec")
}
