{ pkgs ? import <nixpkgs> {}
}:
{
  emacs_26_2 = pkgs.callPackage ./emacs.nix { version = "26.2"; sha256 = "1sxl0bqwl9b62nswxaiqh1xa61f3hng4fmyc69lmadx770mfb6ag"; withAutoReconf = true; };
  emacs_26_3 = pkgs.callPackage ./emacs.nix { version = "26.3"; sha256 = "14bm73758w6ydxlvckfy9nby015p20lh2yvl6pnrjz0k93h4giq9"; withAutoReconf = true; };
  emacs_27_0 = pkgs.callPackage ./emacs.nix { version = "27.0.90"; sha256 = "1sgcs1kibks9x7zw3dsc14d43wsjqw051g33brb97bq3y1pqhvrz"; withAutoReconf = true; };
  # TODO: HEAD
}
