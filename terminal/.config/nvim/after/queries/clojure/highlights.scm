; extends

; Plumatic Schema definition forms - highlight like their core equivalents

; s/defn as @keyword.function (same color as defn)
((sym_lit) @keyword.function
  (#eq? @keyword.function "s/defn"))

; s/def and s/defschema as @keyword (same color as def)
((sym_lit) @keyword
  (#any-of? @keyword "s/def" "s/defschema" "s/defrecord"))

; Highlight the function name after s/defn (same as regular defn)
(list_lit
  .
  ((sym_lit) @_schema.defn
    (#eq? @_schema.defn "s/defn"))
  .
  (sym_lit)? @function
  .
  (str_lit)?)
