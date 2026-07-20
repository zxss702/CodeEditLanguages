// swift-tools-version: 5.7

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
            url: "https://github.com/tree-sitter/swift-tree-sitter",
            from: "0.9.0"
        ),
    ],
    targets: [
        .target(name: "CodeLanguages_Container"),
        .target(
            name: "CodeEditLanguages",
            dependencies: [
                "CodeLanguages_Container",
                .product(name: "SwiftTreeSitter", package: "swift-tree-sitter"),
                "TreeSitterYAML",
                "TreeSitterDockerfile",
                "TreeSitterLua",
                "TreeSitterKotlin",
                "TreeSitterC",
                "TreeSitterCPP",
                "TreeSitterCSharp",
                "TreeSitterElixir",
                "TreeSitterGo",
                "TreeSitterGoMod",
                "TreeSitterHaskell",
                "TreeSitterJava",
                "TreeSitterJavaScript",
                "TreeSitterJSON",
                "TreeSitterPHP",
                "TreeSitterRuby",
                "TreeSitterRust",
                "TreeSitterSwift",
                "TreeSitterZig",
                "TreeSitterBash",
                "TreeSitterCSS",
                "TreeSitterObjc",
                "TreeSitterDart",
                "TreeSitterRegex",
                "TreeSitterHTML",
                "TreeSitterTOML",
                "TreeSitterPython",
                "TreeSitterScala",
                "TreeSitterTypeScript",
                "TreeSitterTSX",
                "TreeSitterSql",
                "TreeSitterOCaml",
                "TreeSitterAgda",
                "TreeSitterJulia",
                "TreeSitterPerl",
                "TreeSitterVerilog",
                "TreeSitterJSDoc",
                "TreeSitterMarkdown",
                "TreeSitterMarkdownInline"
            ],
            resources: [
                .copy("Resources")
            ],
            linkerSettings: [
                .linkedLibrary("c++", .when(platforms: [.macOS])),
                .linkedLibrary("stdc++", .when(platforms: [.linux]))
            ]
        ),
        .target(
            name: "TreeSitterYAML",
            path: "Sources/TreeSitterGrammars/tree-sitter-yaml",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterDockerfile",
            path: "Sources/TreeSitterGrammars/tree-sitter-dockerfile",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterLua",
            path: "Sources/TreeSitterGrammars/tree-sitter-lua",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterKotlin",
            path: "Sources/TreeSitterGrammars/tree-sitter-kotlin",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterC",
            path: "Sources/TreeSitterGrammars/tree-sitter-c",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterCPP",
            path: "Sources/TreeSitterGrammars/tree-sitter-cpp",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterCSharp",
            path: "Sources/TreeSitterGrammars/tree-sitter-c-sharp",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterElixir",
            path: "Sources/TreeSitterGrammars/tree-sitter-elixir",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterGo",
            path: "Sources/TreeSitterGrammars/tree-sitter-go",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterGoMod",
            path: "Sources/TreeSitterGrammars/tree-sitter-go-mod",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterHaskell",
            path: "Sources/TreeSitterGrammars/tree-sitter-haskell",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterJava",
            path: "Sources/TreeSitterGrammars/tree-sitter-java",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterJavaScript",
            path: "Sources/TreeSitterGrammars/tree-sitter-javascript",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterJSON",
            path: "Sources/TreeSitterGrammars/tree-sitter-json",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterPHP",
            path: "Sources/TreeSitterGrammars/tree-sitter-php",
            sources: [
                "php/src/parser.c",
                "php/src/scanner.c",
                "php_only/src/parser.c",
                "php_only/src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("php/src")]
        ),
        .target(
            name: "TreeSitterRuby",
            path: "Sources/TreeSitterGrammars/tree-sitter-ruby",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterRust",
            path: "Sources/TreeSitterGrammars/tree-sitter-rust",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterSwift",
            path: "Sources/TreeSitterGrammars/tree-sitter-swift",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterZig",
            path: "Sources/TreeSitterGrammars/tree-sitter-zig",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterBash",
            path: "Sources/TreeSitterGrammars/tree-sitter-bash",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterCSS",
            path: "Sources/TreeSitterGrammars/tree-sitter-css",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterObjc",
            path: "Sources/TreeSitterGrammars/tree-sitter-objc",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterDart",
            path: "Sources/TreeSitterGrammars/tree-sitter-dart",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterRegex",
            path: "Sources/TreeSitterGrammars/tree-sitter-regex",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterHTML",
            path: "Sources/TreeSitterGrammars/tree-sitter-html",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterTOML",
            path: "Sources/TreeSitterGrammars/tree-sitter-toml",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterPython",
            path: "Sources/TreeSitterGrammars/tree-sitter-python",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterScala",
            path: "Sources/TreeSitterGrammars/tree-sitter-scala",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterTypeScript",
            path: "Sources/TreeSitterGrammars/tree-sitter-typescript",
            sources: [
                "typescript/src/parser.c",
                "typescript/src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift/typescript",
            cSettings: [.headerSearchPath("typescript/src")]
        ),
        .target(
            name: "TreeSitterTSX",
            path: "Sources/TreeSitterGrammars/tree-sitter-typescript",
            sources: [
                "tsx/src/parser.c",
                "tsx/src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift/tsx",
            cSettings: [.headerSearchPath("tsx/src")]
        ),
        .target(
            name: "TreeSitterSql",
            path: "Sources/TreeSitterGrammars/tree-sitter-sql",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterOCaml",
            path: "Sources/TreeSitterGrammars/tree-sitter-ocaml",
            sources: [
                "grammars/ocaml/src/parser.c",
                "grammars/ocaml/src/scanner.c",
                "grammars/interface/src/parser.c",
                "grammars/interface/src/scanner.c",
                "grammars/type/src/parser.c",
                "grammars/type/src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("grammars/ocaml/src")]
        ),
        .target(
            name: "TreeSitterAgda",
            path: "Sources/TreeSitterGrammars/tree-sitter-agda",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterJulia",
            path: "Sources/TreeSitterGrammars/tree-sitter-julia",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterPerl",
            path: "Sources/TreeSitterGrammars/tree-sitter-perl",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterVerilog",
            path: "Sources/TreeSitterGrammars/tree-sitter-verilog",
            sources: [
                "src/parser.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterJSDoc",
            path: "Sources/TreeSitterGrammars/tree-sitter-jsdoc",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterMarkdown",
            path: "Sources/TreeSitterGrammars/tree-sitter-markdown/tree-sitter-markdown",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .target(
            name: "TreeSitterMarkdownInline",
            path: "Sources/TreeSitterGrammars/tree-sitter-markdown/tree-sitter-markdown-inline",
            sources: [
                "src/parser.c",
                "src/scanner.c"
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "CodeEditLanguagesTests",
            dependencies: ["CodeEditLanguages"]
        ),
    ],
    cLanguageStandard: .c11
)
