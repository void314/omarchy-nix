# NOTE: I manually package the Zen browser for myself.

#

# HACK: This does, however, mean that I will need to manually

# tweak the `version` and `hash` here if I wish to update it.

# This produces the package (derivation):

```nix
(let version = "1.16.4b"; in pkgs.appimageTools.wrapType2 {
    inherit version;
    name = "zen"; # NOTE: This will be the name of the executable in $PATH.
    src = pkgs.fetchurl {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen-aarch64.AppImage";
        hash = "sha256:a636fc040adadc65edf6cc3e16320f68fdb2cca3377fd8c56da22f748389eb76";
    };
})
```

# This makes the browser the default one.

```nix
xdg = {
    enable = true;
    desktopEntries."zen-browser" = {
        name = "Zen Browser";
        genericName = "Web Browser";
        exec = "zen"; # NOTE: Ideally should be `"${pkgs.aeon.zen}/bin/zen"`, but that's for snowfall.
        terminal = false;
        mimeType = [
            "text/html"
            "text/xml"
        ];
    };
};
```
