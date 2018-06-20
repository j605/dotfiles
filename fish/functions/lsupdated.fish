function lsupdated
  lsof | awk '$4 == "DEL" && $8 ~ /^\/usr\/lib/ {print $2, $1}' | sort -nu
end
