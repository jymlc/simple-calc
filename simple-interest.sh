#!/usr/bin/env bash
# Calculate simple interest from user-provided principal, rate, and time.

set -euo pipefail

if ! command -v awk >/dev/null 2>&1; then
    echo "Error: awk is required to run this calculator." >&2
    exit 1
fi

read -r -p "Enter the principal amount: " principal
read -r -p "Enter the annual interest rate (%): " rate
read -r -p "Enter the time period in years: " time

# Accept non-negative whole numbers and decimal numbers.
number_pattern='^([0-9]+([.][0-9]+)?|[.][0-9]+)$'
for value in "$principal" "$rate" "$time"; do
    if [[ ! "$value" =~ $number_pattern ]]; then
        echo "Error: enter non-negative numbers for principal, rate, and time." >&2
        exit 1
    fi
done

awk -v p="$principal" -v r="$rate" -v t="$time" 'BEGIN {
    interest = (p * r * t) / 100
    printf "Simple interest: %.2f\n", interest
    printf "Total amount: %.2f\n", p + interest
}'
