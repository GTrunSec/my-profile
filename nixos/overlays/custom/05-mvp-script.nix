self: super:
{
  mpv-with-scripts = super.mpv-with-scripts.override {
    scripts = [super.mpvScripts.convert];
  };
}
