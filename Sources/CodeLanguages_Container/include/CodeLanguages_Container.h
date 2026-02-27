// CodeLanguages_Container.h

#ifndef CodeLanguages_Container_h
#define CodeLanguages_Container_h

typedef struct TSLanguage TSLanguage;

#ifdef __cplusplus
extern "C" {
#endif

// A collection of pointers to supported tree-sitter languages
extern TSLanguage *tree_sitter_agda();
extern TSLanguage *tree_sitter_bash();
extern TSLanguage *tree_sitter_c();
extern TSLanguage *tree_sitter_cpp();
extern TSLanguage *tree_sitter_c_sharp();
extern TSLanguage *tree_sitter_css();
extern TSLanguage *tree_sitter_dart();
extern TSLanguage *tree_sitter_dockerfile();
extern TSLanguage *tree_sitter_elixir();
extern TSLanguage *tree_sitter_go();
extern TSLanguage *tree_sitter_gomod();
extern TSLanguage *tree_sitter_haskell();
extern TSLanguage *tree_sitter_html();
extern TSLanguage *tree_sitter_java();
extern TSLanguage *tree_sitter_javascript();
extern TSLanguage *tree_sitter_jsdoc();
extern TSLanguage *tree_sitter_json();
extern TSLanguage *tree_sitter_julia();
extern TSLanguage *tree_sitter_kotlin();
extern TSLanguage *tree_sitter_lua();
extern TSLanguage *tree_sitter_markdown();
extern TSLanguage *tree_sitter_markdown_inline();
extern TSLanguage *tree_sitter_objc();
extern TSLanguage *tree_sitter_ocaml();
extern TSLanguage *tree_sitter_ocaml_interface();
extern TSLanguage *tree_sitter_perl();
extern TSLanguage *tree_sitter_php();
extern TSLanguage *tree_sitter_python();
extern TSLanguage *tree_sitter_regex();
extern TSLanguage *tree_sitter_ruby();
extern TSLanguage *tree_sitter_rust();
extern TSLanguage *tree_sitter_scala();
extern TSLanguage *tree_sitter_sql();
extern TSLanguage *tree_sitter_swift();
extern TSLanguage *tree_sitter_toml();
extern TSLanguage *tree_sitter_tsx();
extern TSLanguage *tree_sitter_typescript();
extern TSLanguage *tree_sitter_verilog();
extern TSLanguage *tree_sitter_yaml();
extern TSLanguage *tree_sitter_zig();

#ifdef __cplusplus
}
#endif

#endif // !CodeLanguages_Container_h
