// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CodeEditLanguages",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "CodeEditLanguages",
            targets: ["CodeEditLanguages"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ChimeHQ/SwiftTreeSitter.git",
            from: "0.9.0"
        ),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-yaml.git", branch: "master"),
        .package(url: "https://github.com/camdencheek/tree-sitter-dockerfile.git", branch: "main"),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-lua", branch: "main"),
        .package(url: "https://github.com/fwcd/tree-sitter-kotlin", branch: "main"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-c.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-cpp.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-c-sharp.git", branch: "master"),
        .package(url: "https://github.com/elixir-lang/tree-sitter-elixir.git", branch: "main"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-go.git", branch: "master"),
        .package(url: "https://github.com/camdencheek/tree-sitter-go-mod.git", branch: "main"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-haskell.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-java.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-javascript.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-json.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-php.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-ruby.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-rust.git", branch: "master"),
        .package(url: "https://github.com/alex-pinkus/tree-sitter-swift.git", branch: "with-generated-files"),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-zig.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-bash.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-css.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-objc", branch: "master"),
        .package(url: "https://github.com/UserNobody14/tree-sitter-dart.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-regex.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-html.git", branch: "master"),
        .package(url: "https://github.com/cengelbart39/tree-sitter-toml.git", branch: "feature/spm"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-python.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-scala.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-typescript.git", branch: "master"),
        .package(url: "https://github.com/DerekStride/tree-sitter-sql.git", branch: "gh-pages"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-ocaml.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-agda.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-julia.git", branch: "master"),
        .package(url: "https://github.com/ganezdragon/tree-sitter-perl.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-verilog.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter/tree-sitter-jsdoc.git", branch: "master"),
        .package(url: "https://github.com/tree-sitter-grammars/tree-sitter-markdown", branch: "split_parser"),
    ],
    targets: [
        .target(
            name: "CodeEditLanguages",
            dependencies: [
                "SwiftTreeSitter",
                .product(name: "TreeSitterYAML", package: "tree-sitter-yaml"),
                .product(name: "TreeSitterDockerfile", package: "tree-sitter-dockerfile"),
                .product(name: "TreeSitterLua", package: "tree-sitter-lua"),
                .product(name: "TreeSitterKotlin", package: "tree-sitter-kotlin"),
                .product(name: "TreeSitterC", package: "tree-sitter-c"),
                .product(name: "TreeSitterCPP", package: "tree-sitter-cpp"),
                .product(name: "TreeSitterCSharp", package: "tree-sitter-c-sharp"),
                .product(name: "TreeSitterElixir", package: "tree-sitter-elixir"),
                .product(name: "TreeSitterGo", package: "tree-sitter-go"),
                .product(name: "TreeSitterGoMod", package: "tree-sitter-go-mod"),
                .product(name: "TreeSitterHaskell", package: "tree-sitter-haskell"),
                .product(name: "TreeSitterJava", package: "tree-sitter-java"),
                .product(name: "TreeSitterJS", package: "tree-sitter-javascript"),
                .product(name: "TreeSitterJSON", package: "tree-sitter-json"),
                .product(name: "TreeSitterPHP", package: "tree-sitter-php"),
                .product(name: "TreeSitterRuby", package: "tree-sitter-ruby"),
                .product(name: "TreeSitterRust", package: "tree-sitter-rust"),
                .product(name: "TreeSitterSwift", package: "tree-sitter-swift"),
                .product(name: "TreeSitterZig", package: "tree-sitter-zig"),
                .product(name: "TreeSitterBash", package: "tree-sitter-bash"),
                .product(name: "TreeSitterCSS", package: "tree-sitter-css"),
                .product(name: "TreeSitterObjc", package: "tree-sitter-objc"),
                .product(name: "TreeSitterDart", package: "tree-sitter-dart"),
                .product(name: "TreeSitterRegex", package: "tree-sitter-regex"),
                .product(name: "TreeSitterHTML", package: "tree-sitter-html"),
                .product(name: "TreeSitterTOML", package: "tree-sitter-toml"),
                .product(name: "TreeSitterPython", package: "tree-sitter-python"),
                .product(name: "TreeSitterScala", package: "tree-sitter-scala"),
                .product(name: "TreeSitterTypeScript", package: "tree-sitter-typescript"),
                .product(name: "TreeSitterSQL", package: "tree-sitter-sql"),
                .product(name: "TreeSitterOCaml", package: "tree-sitter-ocaml"),
                .product(name: "TreeSitterAgda", package: "tree-sitter-agda"),
                .product(name: "TreeSitterJulia", package: "tree-sitter-julia"),
                .product(name: "TreeSitterPerl", package: "tree-sitter-perl"),
                .product(name: "TreeSitterVerilog", package: "tree-sitter-verilog"),
                .product(name: "TreeSitterJSDoc", package: "tree-sitter-jsdoc"),
                .product(name: "TreeSitterMarkdown", package: "tree-sitter-markdown"),
                .product(name: "TreeSitterMarkdownInline", package: "tree-sitter-markdown"),
            ],
            resources: [
                .copy("Resources")
            ],
            linkerSettings: [.linkedLibrary("c++")]
        ),
        .testTarget(
            name: "CodeEditLanguagesTests",
            dependencies: ["CodeEditLanguages"]
        ),
    ]
)
