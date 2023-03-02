# Everything bankruptcy!  Again!

This is a stow directory.  The target directory is always my home directory.

## Additional setup steps

### Mac configuration

#### Keyboard

- Max repeat rate
- penultimate short repeat delay
- Keyboard shortcuts
  -

### Homebrew

For now, until I can definitively switch to Nix:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/dave/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Git

```sh
brew install git-imerge
```

### Emacs

```sh
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-native-comp --with-spacemacs-icon
stow -d ~/stow -t ~ emacs
```

- Create an Emacs app using script editor in the /Applications folder containing

  ```Applescript
  tell application "Finder" to open POSIX file "/opt/homebrew/opt/emacs-mac/Emacs.app"
  ```
