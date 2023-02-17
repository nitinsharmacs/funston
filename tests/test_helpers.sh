#! /bin/bash

source generate_report.sh
source general_test_functions.sh
source ../scripts/helpers.sh

function test_get_reg_value() {
    local test_description=$1
    local expected=$2
    local reg=$3

    local actual=$( get_reg_value $reg  )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Register : $reg"
    append_test_case $test_result "get_reg_value|$test_description|$inputs|$expected|$actual"
}

function test_cases_get_reg_value() {
    local test_description="should give the value of the provided register"
    local expected=5
    local reg="A"
    A=5
    test_get_reg_value "$test_description" "$expected" "$reg"
}

function test_is_reg() {
    local test_description=$1
    local expected=$2
    local reg=$3

    local actual
    is_reg $reg
    actual=$?
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Register : $reg"
    append_test_case $test_result "is_reg|$test_description|$inputs|$expected|$actual"
}

function test_cases_is_reg() {
    local test_description="should validate provided register"
    local expected=0
    local reg="A"

    test_is_reg "$test_description" "$expected" "$reg"
    
    test_description="should return error status if the register is invalid"
    expected=1
    reg="E"

    test_is_reg "$test_description" "$expected" "$reg"
}

function test_is_number() {
    local test_description=$1
    local expected=$2
    local value=$3

    local actual
    is_number $value
    actual=$?
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Register : $value"
    append_test_case $test_result "is_number|$test_description|$inputs|$expected|$actual"
}

function test_cases_is_number() {
    local test_description="should check if the value is a number"
    local expected=0
    local value="123"

    test_is_number "$test_description" "$expected" "$value"
    
    test_description="should return error status value is not a number"
    expected=1
    value="E"

    test_is_number "$test_description" "$expected" "$value"
}

function test_refine_arg() {
    local test_description=$1
    local expected=$2
    local arg=$3

    local actual=$( refine_arg $arg )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Argument : $arg"
    append_test_case $test_result "refine_arg|$test_description|$inputs|$expected|$actual"
}

function test_cases_refine_arg() {
    local test_description="should remove comma from the argument"
    local expected=A
    local arg="A,"

    test_refine_arg "$test_description" "$expected" "$arg"
}


function test_get_index() {
    local test_description=$1
    local expected=$2
    local line_number=$3

    local actual=$( get_index $line_number )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Line Number : $line_number"
    append_test_case $test_result "get_index|$test_description|$inputs|$expected|$actual"
}

function test_cases_get_index() {
    local test_description="should give array index equivalent to give line number"
    local expected=1
    local line_number="20"

    test_get_index "$test_description" "$expected" "$line_number"
}

function test_get_cl() {
    local test_description=$1
    local expected=$2

    local actual=$( get_cl )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs=""
    append_test_case $test_result "get_cl|$test_description|$inputs|$expected|$actual"
}

function test_cases_get_cl() {
    local test_description="should give CURRENT LINE"
    set_cl 20
    local expected=20

    test_get_cl "$test_description" "$expected"
}

function test_set_cl() {
    local test_description=$1
    local expected=$2
    local current_line=$3

    set_cl $current_line
    local actual=$( get_cl $current_line )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Current Line : $current_line"
    append_test_case $test_result "set_cl|$test_description|$inputs|$expected|$actual"
}

function test_cases_set_cl() {
    local test_description="should set CURRENT LINE"
    local expected=20
    local current_line=20

    test_set_cl "$test_description" "$expected" "$current_line"
}

function test_get_nl() {
    local test_description=$1
    local expected=$2

    local actual=$( get_nl )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs=""
    append_test_case $test_result "get_nl|$test_description|$inputs|$expected|$actual"
}

function test_cases_get_nl() {
    local test_description="should give NEXT LINE"
    set_nl 20
    local expected=20

    test_get_cl "$test_description" "$expected"
}

function test_set_nl() {
    local test_description=$1
    local expected=$2
    local next_line=$3

    set_nl $next_line
    local actual=$( get_nl $next_line )
    local test_result=$( verify_expectations "$actual" "$expected" )
    local inputs="Next Line : $next_line"
    append_test_case $test_result "set_nl|$test_description|$inputs|$expected|$actual"
}

function test_cases_set_nl() {
    local test_description="should set NEXT LINE"
    local expected=20
    local next_line=20

    test_set_nl "$test_description" "$expected" "$next_line"
}

function helpers_test_cases() {
  test_cases_get_reg_value
  test_cases_is_reg
  test_cases_is_number
  test_cases_refine_arg
  test_cases_get_index
  test_cases_get_cl
  test_cases_set_cl
  test_cases_get_nl
  test_cases_set_nl
}