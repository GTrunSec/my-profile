#source $HOME/.nix-direnv/direnvrc
use_flake() {
  watch_file flake.nix
  watch_file flake.lock
  eval "$(nix print-dev-env)"
}
use_python() {
  if [ -n "$(which pyenv)" ]; then
local pyversion=$1
pyenv local ${pyversion}
  fi
}

layout_virtualenv() {
  local pyversion=$1
  local pvenv=$2
  if [ -n "$(which pyenv virtualenv)" ]; then
pyenv virtualenv --force --quiet ${pyversion} ${pvenv}-${pyversion}
  fi
  pyenv local --unset
}

layout_activate() {
  if [ -n "$(which pyenv)" ]; then
source $(pyenv root)/versions/$1/bin/activate
  fi
}
