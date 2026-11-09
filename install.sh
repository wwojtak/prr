#!/bin/zsh
# Installs prr: links the script into ~/.local/bin, and on macOS adds the "Review PR in iTerm"
# right-click Service and the iTerm profile it opens windows with.
set -e
cd ${0:A:h}

missing=()
for cmd in gh fzf delta glow jq perl; do (( $+commands[$cmd] )) || missing+=$cmd; done
(( $#missing )) && print -P "%F{yellow}Missing: $missing (brew install $missing)%f"

mkdir -p ~/.local/bin
ln -sf $PWD/prr ~/.local/bin/prr
print "Linked ~/.local/bin/prr -> $PWD/prr"
[[ :$PATH: == *:$HOME/.local/bin:* ]] || print -P "%F{yellow}Add ~/.local/bin to your PATH%f"

if [[ $OSTYPE == darwin* && ${1:-} != --no-service ]]; then
  mkdir -p ~/Library/Services ~/Library/Application\ Support/iTerm2/DynamicProfiles
  rm -rf ~/Library/Services/"Review PR in iTerm.workflow"
  cp -R macos/"Review PR in iTerm.workflow" ~/Library/Services/
  cp macos/iterm-pr-review-profile.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/pr-review.json
  /System/Library/CoreServices/pbs -update
  print 'Installed the "Review PR in iTerm" Service and the "PR Review" iTerm profile'
fi
