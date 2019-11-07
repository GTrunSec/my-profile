{ config, lib, pkgs, ... }:
{

  beagleImage = pkgs.dockerTools.buildImage {
        name = "beagleImage";
        tag = "latest";
        fromImage = pkgs.dockerTools.pullImage {
          imageName = "yampelo/beagle";
          finalImageTag = "latest";
          imageDigest = "sha256:06b59018f030074f61077e9df70b02d33be3272235f70b5db1c806feecf75165";
          sha256 = "0nhh1bl3d2czja7c2v02ljg8dgxyw77l01m7ylwcqzw5irw9zxcq";
        };
    #config.Cmd = [ "" ];
  };
}
