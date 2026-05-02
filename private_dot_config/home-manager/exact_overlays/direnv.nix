# HACK: Since direnv's tests fail on darwin, we need to disable them in the overlay.
final: prev: {
  direnv = prev.direnv.overrideAttrs (old: {
    doCheck = false;
    doInstallCheck = false;
  });
}
