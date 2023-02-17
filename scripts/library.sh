#! /bin/bash

source helpers.sh
source commands.sh

function execute() {
  local command=$1
  local arg1=$2
  local arg2=$3

  local refined_arg1=$( refine_arg ${arg1} )
  echo "$line $command $arg1 $arg2 | CL : $(get_cl) | NL : $(get_nl)"
  if grep -q "^START$" <<< "${command}"; then
    reset
  elif (grep -q "^MOV$" <<< "${command}" && is_number $arg2); then
    mov_val_to_reg $refined_arg1 $arg2
  elif (grep -q "^MOV$" <<< "${command}" && is_reg $arg2); then
    mov_reg_to_reg $refined_arg1 $arg2
  elif (grep -q "^ADD$" <<< "${command}" && is_number $arg2); then
    add_val_to_reg $refined_arg1 $arg2
  elif (grep -q "^ADD$" <<< "${command}" && is_reg $arg2); then
    add_reg_to_reg $refined_arg1 $arg2
  elif ( grep -q "^JMP$" <<< "${command}" && is_number $refined_arg1); then
    jump $refined_arg1
  elif grep -q "^STOP$" <<< "${command}"; then
    set_nl ""
  else
    echo "Invalid command Exception on line $( get_cl )"
    exit 1
  fi
}


function interpret() {
  local code=("${@}")
  
  local code_length=${#code[@]}

  local loop_executions=0
  local max_loop_executions=50
  
  local current_line=$( get_cl )
  local current_index=$( get_index $current_line )
 
  while true
  do
    if [[ $loop_executions -ge $max_loop_executions ]]; then
      echo "Error : Potential Infinite loop"
      return 1
    fi
    
    execute ${code[$current_index]}
    echo $(display_registers)
    local next_line=$( get_nl )
    if [[ -z $next_line ]]; then
      break
    fi
    current_line=$next_line
    set_cl $current_line
    current_index=$( get_index $current_line )
    increment_nl $code_length

    loop_executions=$(( $loop_executions + 1 ))
  done
}

function main() {
  local code_file=$1

  OLDIFS=$IFS
  IFS=$'\n'
  local code=($( cat "${code_file}" ))
  IFS=$OLDIFS

  interpret "${code[@]}"
}
