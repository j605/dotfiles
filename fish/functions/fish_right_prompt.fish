function fish_right_prompt
  set -l tasks_pending (task +PENDING count)
  if [ $tasks_pending -ne 0 ]
    printf "%s<tasks pending:%d>%s " (set_color green --bold) $tasks_pending (set_color normal)
  end
end
