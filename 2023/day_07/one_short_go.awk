
{
    split($0, a, " ");
    sum += (NR-1) * a[2];
}

END {print(sum)}
