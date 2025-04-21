#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 pattern"
  echo "Example: $0 chrome"
  exit 1
fi
# Get the pattern from command line argument (convert to lowercase)
pattern=$(echo "$1" | tr '[:upper:]' '[:lower:]')

# First, check if any window has a mark that matches the pattern
mark_match=$(i3-msg -t get_tree | jq -r '
  def find_mark_match:
    if .window? and .marks and (.marks | length > 0) then
      # Check if any mark contains the pattern
      select(.marks[] | ascii_downcase | contains("'"$pattern"'")) |
      {id: .window, class: (.window_properties.class // "Unknown"), title: .name, mark: (.marks[] | select(ascii_downcase | contains("'"$pattern"'")))}
    else
      empty
    end;
    
  [.. | find_mark_match][0] // null
')

# Check if we found a mark match
if [ "$mark_match" != "null" ] && [ -n "$mark_match" ]; then
  # Focus the window with the matching mark
  window_id=$(echo "$mark_match" | jq -r '.id')
  i3-msg "[id=$window_id] focus" >/dev/null
  mark_info=$(echo "$mark_match" | jq -r '.mark')
  echo "Focused on window with mark: $mark_info - $(echo "$mark_match" | jq -r '.class'): $(echo "$mark_match" | jq -r '.title')"
else

  # Use i3-msg to get the tree and process with jq
  matching_windows=$(i3-msg -t get_tree | jq -r '
	  def find_windows:
	    if .window? and .window_properties? then
	      if (.window_properties.class | ascii_downcase | contains("'"$pattern"'")) or
		 (.window_properties.instance | ascii_downcase | contains("'"$pattern"'")) or
		 (.name | ascii_downcase | contains("'"$pattern"'")) then
		{id: .window, class: .window_properties.class, title: .name}
	      else
		empty
	      end
	    else
	      empty
	    end;
	  
	  [.. | find_windows] | sort_by(.class)
	')

  # Count the number of matching windows
  count=$(echo "$matching_windows" | jq 'length')

  # If no matching windows found
  if [ "$count" -eq 0 ]; then
    echo "No windows matching "$pattern" found."
    exit 1
  # If only one matching window is found, focus on it directly
  elif [ "$count" -eq 1 ]; then
    window_id=$(echo "$matching_windows" | jq -r '.[0].id')
    i3-msg "[id=$window_id] focus" >/dev/null
    echo "Focused on window: $(echo "$matching_windows" | jq -r '.[0].class') - $(echo "$matching_windows" | jq -r '.[0].title')"
  # If multiple matching windows are found, use ilia to choose
  else
    # Format the windows list for ilia
    window_list=$(echo "$matching_windows" | jq -r '.[] | "(.id)|(.class): (.title)"')

    # Use ilia to select a window
    selected=$(echo "$window_list" | ilia -p textlist)

    # If a window was selected, focus on it
    if [ -n "$selected" ]; then
      window_id=$(echo "$selected" | cut -d'|' -f1)
      i3-msg "[id=$window_id] focus" >/dev/null
      echo "Focused on window: $(echo "$selected" | cut -d'|' -f2)"
    fi
  fi
fi

