export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

# Save timestamps in the history
setopt EXTENDED_HISTORY

# Searches history for the pattern in the argument.  Pass '' to show the entire history
hgrep () { fc -Dlim "*$@*" 1 }
