{ pkgs, ... }:
with pkgs;
let
  R-with-my-packages = rWrapper.override{ packages = with rPackages;[ 
        bookdown
        devtools
        dplyr
        ggplot2
        xts
        #grid
        gtable
        htmltools
        jsonlite
        kableExtra
        KernSmooth
        #Knitr
        labeling
        lazyeval
        magrittr
        markdown
        openssl
        parallel
        Rcpp
        reshape2
        revealjs
        rmarkdown
        tidyr
        tidyselect
        tinytex
        udpipe
        utf8
        #utils
        xml2
        xopen
        yaml
        ]; 
    };
in
{
  environment.systemPackages = with pkgs; [
    R-with-my-packages
  ];
}
