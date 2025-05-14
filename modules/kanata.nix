{
  services.kanata = {
    enable = true;
    keyboards.default = {
      config = ''
        ;; Inspired by
        ;; https://www.youtube.com/watch?v=sLWQ4Gx88h4
        ;; https://github.com/mhantsch/maxtend/blob/main/kanata/colemax-maxtend.kbd
        ;; https://github.com/DreymaR/BigBagKbdTrixPKL
        (defsrc
         ‹⇧ ⇧› ⎇› ; ' [
        )
        ;; I use symbols cause they're not as wide as the text versions.
        ;; See https://github.com/jtroo/kanata/blob/main/docs/fancy_symbols.md



        (defalias
          deflt (layer-switch default-layer)
          altgr (one-shot 500 (layer-while-held alt-graph))

          ;; Special keys
          æ (fork (unicode æ) (unicode Æ) (lsft rsft))
          ø (fork (unicode ø) (unicode Ø) (lsft rsft)) 
          å (fork (unicode å) (unicode Å) (lsft rsft)) 
        )
        (deflayer (default-layer)
          _ _ @altgr _ _ _
        )
        (deflayer (alt-graph)
          _ _ @altgr @æ @ø @å
        )
      '';
    };
  };
}
