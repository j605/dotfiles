# https://lobste.rs/s/eng7cz/adding_colors_man#c_1y27rr
function man -d "Pretty manpages" -w man
  env \
  LESS_TERMCAP_mb=(printf "\e[1;31m") \
  LESS_TERMCAP_md=(printf "\e[1;31m") \
  LESS_TERMCAP_me=(printf "\e[0m") \
  LESS_TERMCAP_se=(printf "\e[0m") \
  LESS_TERMCAP_so=(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=(printf "\e[0m") \
  LESS_TERMCAP_us=(printf "\e[1;32m") \
  man $argv
end
