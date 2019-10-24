cd ~/.config/nixpkgs/dotfiles/polybar/polybar-forecast
cargo build --release
cd ~/src
git clone https://github.com/oh-my-fish/oh-my-fish
cd oh-my-fish
fish install --offline=omf.tar.gz
omf install https://github.com/otms61/fish-pet
