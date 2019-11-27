{ pkgs ? import <nixpkgs> {} }: epkgs:
(with epkgs.melpaPackages; [
  alchemist
  all-the-icons
  all-the-icons-dired
  all-the-icons-ivy
  autodisass-llvm-bitcode
  avy
  cargo
  cider
  company
  company-emacs-eclim
  company-ghc
  company-lsp
  counsel
  counsel-projectile
  dap-mode
  deft
  diminish
  dockerfile-mode
  easy-kill
  easy-kill-extras
  eclim
  elm-mode
  ember-mode
  epl
  erc-image
  esxml
  expand-region
  f
  flycheck
  flycheck-haskell
  flycheck-rust
  flymake-lua
  format-sql
  fsharp-mode
  gitconfig
  gitignore-mode
  glsl-mode
  go-mode
  handlebars-mode
  haskell-mode
  ht
  htmlize
  hydra
  idris-mode
  interleave
  irony
  ivy
  ivy-hydra
  ivy-rich
  jedi
  jinja2-mode
  js2-mode
  json-mode
  key-chord
  kv
  ledger-mode
  lsp-mode
  lsp-ui
  magit
  markdown-mode
  markdown-mode-plus
  mc-extras
  /* merlin */ /* TODO: broken? */
  moe-theme
  multiple-cursors
  nix-mode
  nix-update
  nodejs-repl
  notmuch
  org-bullets
  org-journal
  package-build
  pallet
  pandoc-mode
  paradox
  pkg-info
  popup
  powerline
  pretty-mode
  prodigy
  projectile
  puppet-mode
  racer
  reason-mode
  restclient
  ripgrep
  rjsx-mode
  rust-mode
  rustic
  s
  scala-mode
  scss-mode
  session
  smart-compile
  smartparens
  smex
  solarized-theme
  stripe-buffer
  swiper
  tagedit
  terraform-mode
  tide
  toml-mode
  tuareg
  typescript-mode
  typo
  use-package
  virtualenvwrapper
  wc-mode
  web-mode
  wgrep
  whitespace-cleanup-mode
  writegood-mode
  ws-butler
  yaml-mode
] ++ [
  /* overrides */
  # (epkgs.lua-mode.override (args: {
  #   melpaBuild = drv: args.melpaBuild (drv // {
  #     src = pkgs.fetchFromGitHub {
  #       owner = "immerrr";
  #       repo = "lua-mode";
  #       rev = "95c64bb5634035630e8c59d10d4a1d1003265743";
  #       sha256 = "0cawb544qylifkvqads307n0nfqg7lvyphqbpbzr2xvr5iyi4901";
  #       # date = 2019-01-13T13:50:39+03:00;
  #     };
  #   });
  # }))
  # upstream bug: these are not packaged with libclang for some reason
  (epkgs.company-irony.override (args: {
    melpaBuild = drv: args.melpaBuild (drv // {
      packageRequires = with pkgs; [ company emacs irony llvmPackages.libclang ];
    });
  }))
  (epkgs.flycheck-irony.override (args: {
    melpaBuild = drv: args.melpaBuild (drv // {
      packageRequires = with pkgs; [ emacs flycheck irony llvmPackages.libclang ];
    });
  }))
] ++ [
  epkgs.orgPackages.org-plus-contrib
  epkgs.pdf-tools
])
