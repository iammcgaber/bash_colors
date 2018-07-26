#!/bin/bash

source colors.sh
declare color_file=colors.sh

# Default color.  In bash if you don't end with this the color stays. In zsh not so.
declare def=$'\e[0m'

# List all the color variables to see how they look
function list_colors() {
  cat ${color_file} | \
    while read color; do
      my_color_var=$(echo $color | sed 's/=.*//')
      my_color_name=$(echo $color | sed 's/.* #//')
      eval echo "\$${my_color_var}\This color is ${my_color_name}${def}"
    done
}

# Pass a color and text to change the color of that text.
function colorize() {
  local _color=$1
  local _text=$2
  eval echo "\$${_color}\${_text}${def}"
}

# Pass a color name and a style for more dynamic coloring
function color_style() {
  local _color=$1
  local _style=$(get_style $2)
  local _text=$3
  local _color_style=$_style$_color
  eval echo "\$${_color_style}\${_text}${def}" 
}

function get_style() {
  local _style=$1
  if [[ "${_style}" == "bold" ]]; then
    echo b
  elif [[ "${_style}" == "underline" ]]; then
    echo u
  elif [[ "${_style}" == "background" ]]; then
    echo bg
  else
    echo
  fi
}

"$@"
