# Everything bankruptcy!  Again!

This is a stow directory.  The target directory is always my home directory.

## Status

## Additional setup steps

### Mac configuration


#### Keyboard

- Max repeat rate
- penultimate short repeat delay
- Keyboard shortcuts
  - clear:
    - Launchpad & Dock
    - Display
    - Mission Control
    - Keyboard
    - Screenshots
    - Services
    - Accessibility
  - Screenshots: assign ctrl-opt-cmd-5 to "Screenshot and Recording Options"
  - Function Keys: use F1, F2, etc. as standard function keys
  - Modifier Keys: Caps-lock is control

- Character viewer
  - Press globe key to open emoji & symbols
  - Click the icon in upper right to expand
  - Click "..." at upper left and choose "customize list"
  - Open "Code Tables" at bottom and select Unicode

#### 1Password

- Clear keyboard shortcuts

- Consider: [Universal Autofill](https://support.1password.com/mac-universal-autofill/)

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

### Dotfiles

```sh
brew install stow
mkdir -p ~/src
cd ~/src
git clone git@github.com:dabrahams/dotfiles
stow ~/src/dotfiles -t ~ -S common
dotfile mac-with-homebrew # on MacOS
```

### Emacs

```sh
brew tap railwaycat/emacsmacport
brew install emacs-mac --with-native-comp --with-spacemacs-icon
osacompile -o /Applications/Emacs.app -e \
  "tell application \"Finder\" to open POSIX file \"$(brew --prefix)/opt/emacs-mac/Emacs.app\"" \
  && cp $(brew --prefix)/opt/emacs-mac/Emacs.app/Contents/Resources/Emacs.icns \
  /Applications/Emacs.app/Contents/Resources/applet.icns
brew install watchexec # for fast straight.el startup times
dotfile emacs
```

Then create an Emacs app using script editor in the /Applications folder containing

```Applescript
tell application "Finder" to open POSIX file "/opt/homebrew/opt/emacs-mac/Emacs.app"
```

## Misc

- Use SSH keys with passphrases stored in Mac Keychain
