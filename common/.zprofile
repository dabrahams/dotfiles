
# Setup homebrew if in the standard Mac locations.  Does the following as of 2023-03-02
#
# export HOMEBREW_PREFIX="/opt/homebrew";
# export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
# export HOMEBREW_REPOSITORY="/opt/homebrew";
# export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
# export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
# export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
if (which brew > /dev/null); then
    # Intel macs have brew in /usr/local/bin/, already in path.
    eval "$(brew shellenv)"
else
    BREW=/opt/homebrew/bin/brew
    [[ -e "$BREW" ]] && eval "$($BREW shellenv)"
fi

# Put my bin directory at the head of the PATH.
export PATH="${HOME}/bin:${PATH}";
