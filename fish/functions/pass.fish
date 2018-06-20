# wrap pass to use nano as editor
function pass --wraps=gopass
  gopass $argv
end
