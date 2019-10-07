{ pkgs, ... }:
with pkgs;
let
  R-with-my-packages = rWrapper.override{ packages = with rPackages;[
        bookdown
        devtools
        dplyr
        ggplot2
        xts
        languageserver
        parallel
        gtable
        htmltools
        jsonlite
        kableExtra
        KernSmooth
        knitr
        rmarkdown
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
        summarytools
        doBy
        ]; 
    };
in
{
  environment.systemPackages = with pkgs; [
    R-with-my-packages
    rstudio
  ];
}
