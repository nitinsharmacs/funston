#! /bin/bash

CURRENT_LINE=10
NEXT_LINE=20

function reset_reg() {  
  A=0
  B=0
  C=0
  D=0
}

function reset_flags() {
  EQ=0
  LT=0
  GT=0
  NE=0
}

function reset_stack() {
  STACK=()
}

function reset() {
  CURRENT_LINE=10
  NEXT_LINE=20

  reset_reg
  reset_flags
  reset_stack
}

function display_registers() {
  echo "A : $A"
  echo "B : $B"
  echo "C : $C"
  echo "D : $D"
}

function is_reg() {
  local reg=$1

  local registers="A B C D"
  grep -q "$reg" <<< $registers
}

function is_number() {
  local value=$1
  grep -q "^[0-9]*$" <<< $value
}

function get_reg_value() {
  local reg=$1
  echo "${!reg}"
}

function refine_arg() {
  local arg=$1

  cut -f1 -d"," <<< ${arg}
}

function get_index() {
  local line=$1

  local index=$(( ($line - 10)/10 ))
  echo $index
}

function set_cl() {
  local current_line=$1

  CURRENT_LINE=$current_line
}

function set_nl() {
  local next_line=$1
  
  NEXT_LINE=$next_line
}

function get_cl() {
  echo ${CURRENT_LINE}
}

function get_nl() {
  echo ${NEXT_LINE}
}

function increment_nl() {
  local code_length=$1

  NEXT_LINE=$(( $NEXT_LINE + 10 ))
  local next_index=$( get_index $NEXT_LINE )
  if [[ $next_index -ge $code_length ]]; then
    NEXT_LINE=""
  fi
}