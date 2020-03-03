{ pkgs ? import <nixpkgs> {}
}:
{
  emacs_26_2 = pkgs.callPackage ./emacs.nix { version = "26.2"; sha256 = "1sxl0bqwl9b62nswxaiqh1xa61f3hng4fmyc69lmadx770mfb6ag"; withAutoReconf = true; };
  emacs_26_3 = pkgs.callPackage ./emacs.nix { version = "26.3"; sha256 = "14bm73758w6ydxlvckfy9nby015p20lh2yvl6pnrjz0k93h4giq9"; withAutoReconf = true; };
  emacs_27_0 = pkgs.callPackage ./emacs.nix { version = "27.0.90"; sha256 = "06qfn1kziyfv6sg4c7r2rrwzr4jyik17wf7nq3m7n8ii6lxllk5w"; withAutoReconf = true; };
  # TODO: HEAD
}
