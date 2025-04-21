#!/bin/bash

selected=$(i3-msg -t get_tree | jq -r '
	recurse(.nodes[]?, .floating_nodes[]?) 
	| select(.output =="__i3" and .name == "__i3_scratch") 
	| recurse(.nodes[]?, .floating_nodes[]?) 
	| select(.window != null)
	| (.id|tostring) + " " + (.window_properties.class) + "|" + (.name)
' | ilia -p textlist -l Scratchpad)


if [ -n "$selected" ]; then
  con_id=$(echo "$selected" | awk '{print $1}')
  i3-msg "[con_id=${con_id}] scratchpad show"
fi
