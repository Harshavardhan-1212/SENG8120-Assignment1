#!/bin/bash

# Load the function
source ./rectangular_prism.sh

pass=0
fail=0

print_result() {
  local description=$1
  local expected=$2
  local actual=$3
  if [ "$expected" = "$actual" ]; then
    echo "PASS: $description"
    ((pass++))
  else
    echo "FAIL: $description"
    echo "Expected: $expected"
    echo "Got: $actual"
    ((fail++))
  fi
}

expect_error() {
  local description=$1
  local output
  output=$(calculate "$2" "$3" "$4" 2>&1)
  if [[ $? -ne 0 ]]; then
    echo "PASS: $description (Caught expected error)"
    ((pass++))
  else
    echo "FAIL: $description (Expected error, got $output)"
    ((fail++))
  fi
}

# Test cases
result=$(calculate 2 3 4)
print_result "Valid input 2x3x4" "24" "$result"

result=$(calculate 0 3 5)
print_result "Zero height returns 0" "0" "$result"

result=$(calculate 0 0 0)
print_result "All zeros return 0" "0" "$result"

expect_error "Negative height triggers error" -1 2 3
expect_error "Non integer input triggers error" 3 abc 2

# Large value test
result=$(calculate 1000 2000 3000)
print_result "Large value test" "6000000000" "$result"

# Summary
echo
echo "Test Summary"
echo "Passed: $pass"
echo "Failed: $fail"
