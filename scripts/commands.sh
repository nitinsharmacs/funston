#! /bin/bash

INVALID_INST_EXCP=1

function mov_val_to_reg() {
  local reg=$1
  local value=$2
  
  if ! is_number $value ; then
    return $INVALID_INST_EXCP
  fi

  case $reg in
    A)
      A=$value
    ;;
    B)
      B=$value
    ;;
    C)
      C=$value
    ;;
    D)
      D=$value
    ;;
    *)
      return $INVALID_INST_EXCP
    ;;
  esac

}

function mov_reg_to_reg() {
  local reg_1=$1
  local reg_2=$2
  
  if ! is_reg $reg_2 ; then
      return $INVALID_INST_EXCP
  fi

  local reg_2_value=$( get_reg_value $reg_2 )
  mov_val_to_reg $reg_1 $reg_2_value
}


function add_val_to_reg() {
  local reg=$1
  local value=$2

  if ! is_reg $reg; then
    return $INVALID_INST_EXCP
  fi

  local reg_value=$( get_reg_value $reg )

  local sum=$(( $reg_value + $value ))

  mov_val_to_reg $reg $sum
}

function add_reg_to_reg() {
  local reg_1=$1
  local reg_2=$2

  if ( ! is_reg $reg_1 || ! is_reg $reg_2 ); then
    return $INVALID_INST_EXCP
  fi

  local reg_1_value=$( get_reg_value $reg_1 )
  local reg_2_value=$( get_reg_value $reg_2 )

  local sum=$(( $reg_1_value + $reg_2_value ))

  mov_val_to_reg $reg_1 $sum
}

function jump() {
  local next_line=$1

  set_nl $next_line
}