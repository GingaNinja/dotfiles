#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
eval "$(/opt/homebrew/bin/brew shellenv)"

awsprofileInt() {
   export AWS_PROFILE=${1:-${AWS_PROFILE}}
   eval "$(aws configure export-credentials --profile ${1:-${AWS_PROFILE}} --format env)"
   export AWS_DEFAULT_REGION=eu-west-1
}
                       
awsprofile() {
   profile=$(sed -nr 's/\[profile ([a-z\-]+)\]/\1/p' ~/.aws/config | fzf) && awsprofileInt $profile
}

awslogin() {
   profile=$(sed -nr 's/\[profile ([a-z\-]+)\]/\1/p' ~/.aws/config | fzf) && aws sso login --profile $profile &&
  awsprofileInt $profile
}


# Execute code only if STDERR is bound to a TTY.
if [[ -o INTERACTIVE && -t 2 ]]; then
  figlet -f roman -w 500 "Dave's Mac"
  
  # Print a random, hopefully interesting, adage.
  if (( $+commands[fortune] )); then
    #fortune -s
    ~/random_doc.clj
    print
  fi
fi >&2



#
# Browser
#

if [[ -z "$BROWSER" && "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

if [[ -z "$EDITOR" ]]; then
  export EDITOR='vim'
fi
if [[ -z "$VISUAL" ]]; then
  export VISUAL='vim'
fi
if [[ -z "$PAGER" ]]; then
  export PAGER='less'
fi

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=(
  $HOME/{.cargo,go}/bin(N)
  /opt/{homebrew,local}/{,s}bin(N)
  /usr/local/{,s}bin(N)
  $path
  $HOME/.local/bin
  /opt/homebrew/Cellar/perl/5.38.2_1/bin
)

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X to enable it.
if [[ -z "$LESS" ]]; then
  export LESS='-g -i -M -R -S -w -X -z-4'
fi

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
