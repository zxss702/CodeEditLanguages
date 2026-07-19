#!/usr/bin/env python3
"""Vendor tree-sitter grammar sources into Sources/TreeSitterGrammars/."""

from __future__ import annotations

import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = Path(__file__).resolve().parent / "grammars.json"
LOCK = Path(__file__).resolve().parent / "grammars.lock"
VENDOR_ROOT = ROOT / "Sources" / "TreeSitterGrammars"
PACKAGE_SWIFT = ROOT / "Package.swift"


def run(cmd: list[str], **kwargs) -> subprocess.CompletedProcess:
    print("+", " ".join(cmd), flush=True)
    return subprocess.run(cmd, check=True, **kwargs)


def copy_path(src_root: Path, rel: str, dest_root: Path) -> None:
    src = src_root / rel
    dest = dest_root / rel
    if not src.exists():
        # LICENSE may be named differently
        if rel.upper().startswith("LICENSE"):
            for candidate in src_root.iterdir():
                if candidate.name.upper().startswith("LICENSE"):
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(candidate, dest_root / candidate.name)
                    return
        print(f"  warn: missing {rel}", flush=True)
        return
    if src.is_dir():
        if dest.exists():
            shutil.rmtree(dest)

        def _ignore(directory: str, names: list[str]) -> set[str]:
            ignored = {".git", "node_modules", "test", "corpus", "tests"}
            for name in names:
                if name.endswith("Tests"):
                    ignored.add(name)
            return ignored

        shutil.copytree(src, dest, ignore=_ignore)
    else:
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest)


def filter_sources(vendor_dir: Path, target: dict) -> list[str]:
    base = vendor_dir / target["path"] if target["path"] != "." else vendor_dir
    existing = []
    for src in target["sources"]:
        if (base / src).exists():
            existing.append(src)
        else:
            print(f"  warn: skip missing source {target['name']}: {src}", flush=True)
    if not existing:
        raise SystemExit(f"No sources found for {target['name']} under {base}")
    return existing


def vendor_one(grammar: dict, tmp: Path, lock: dict) -> list[dict]:
    gid = grammar["id"]
    url = grammar["url"]
    ref = grammar["ref"]
    clone_dir = tmp / gid
    print(f"\n==> {gid} ({ref})", flush=True)
    run(
        [
            "git",
            "clone",
            "--depth",
            "1",
            "--branch",
            ref,
            url,
            str(clone_dir),
        ]
    )
    sha = run(
        ["git", "-C", str(clone_dir), "rev-parse", "HEAD"],
        capture_output=True,
        text=True,
    ).stdout.strip()
    lock[gid] = {"url": url, "ref": ref, "revision": sha}

    dest = VENDOR_ROOT / gid
    if dest.exists():
        shutil.rmtree(dest)
    dest.mkdir(parents=True)

    for rel in grammar["copy"]:
        copy_path(clone_dir, rel, dest)

    # Some grammars (e.g. perl) ship without Swift bindings; synthesize a header.
    for target in grammar["targets"]:
        headers_rel = target["publicHeadersPath"]
        if target["path"] != ".":
            headers_dir = dest / target["path"] / headers_rel
        else:
            headers_dir = dest / headers_rel
        if headers_dir.exists() and any(headers_dir.rglob("*.h")):
            continue
        func = "tree_sitter_" + gid.removeprefix("tree-sitter-").replace("-", "_")
        # Special-cases where SPM/symbol names diverge from repo id.
        special = {
            "TreeSitterGoMod": "tree_sitter_gomod",
            "TreeSitterCSharp": "tree_sitter_c_sharp",
            "TreeSitterMarkdownInline": "tree_sitter_markdown_inline",
            "TreeSitterTSX": "tree_sitter_tsx",
            "TreeSitterSql": "tree_sitter_sql",
        }
        func = special.get(target["name"], func)
        module_dir = headers_dir / target["name"]
        module_dir.mkdir(parents=True, exist_ok=True)
        header_name = gid.removeprefix("tree-sitter-").replace("-", "_") + ".h"
        header_path = module_dir / header_name
        guard = target["name"].upper()
        header_path.write_text(
            "#ifndef TREE_SITTER_%s_H_\n"
            "#define TREE_SITTER_%s_H_\n\n"
            "typedef struct TSLanguage TSLanguage;\n\n"
            "#ifdef __cplusplus\n"
            'extern "C" {\n'
            "#endif\n\n"
            "const TSLanguage *%s(void);\n\n"
            "#ifdef __cplusplus\n"
            "}\n"
            "#endif\n\n"
            "#endif\n"
            % (guard, guard, func)
        )
        print("  synthesized header %s" % header_path.relative_to(dest), flush=True)

    resolved_targets = []
    for target in grammar["targets"]:
        sources = filter_sources(dest, target)
        resolved_targets.append({**target, "sources": sources, "grammar_id": gid})
    return resolved_targets


def swift_string_list(items: list[str], indent: int) -> str:
    pad = " " * indent
    inner = ",\n".join(f'{pad}    "{item}"' for item in items)
    return f"[\n{inner}\n{pad}]"


def generate_package_swift(all_targets: list[dict]) -> None:
    dep_names = [t["name"] for t in all_targets]
    # Keep a stable, readable order matching historical Package.swift
    preferred = [
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
        "TreeSitterMarkdownInline",
    ]
    by_name = {t["name"]: t for t in all_targets}
    ordered = [by_name[n] for n in preferred if n in by_name]
    for t in all_targets:
        if t["name"] not in {x["name"] for x in ordered}:
            ordered.append(t)

    grammar_targets_swift = []
    for t in ordered:
        root_path = "Sources/TreeSitterGrammars/" + t["grammar_id"]
        if t["path"] != ".":
            target_path = root_path + "/" + t["path"]
        else:
            target_path = root_path
        sources = t["sources"]
        headers = t["publicHeadersPath"]
        searches = t["headerSearchPaths"]

        c_settings = ", ".join('.headerSearchPath("%s")' % p for p in searches)
        name = t["name"]
        sources_literal = swift_string_list(sources, 12)
        grammar_targets_swift.append(
            "        .target(\n"
            '            name: "%s",\n' % name
            + '            path: "%s",\n' % target_path
            + "            sources: %s,\n" % sources_literal
            + '            publicHeadersPath: "%s",\n' % headers
            + "            cSettings: [%s]\n" % c_settings
            + "        )"
        )

    dep_lines = [
        '                "CodeLanguages_Container"',
        '                .product(name: "SwiftTreeSitter", package: "swift-tree-sitter")',
    ]
    dep_lines += ['                "%s"' % n for n in preferred if n in by_name]
    deps_block = ",\n".join(dep_lines)
    targets_block = ",\n".join(grammar_targets_swift)

    content = """// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.
// Generated by Scripts/vendor-grammars.py — re-run after updating Scripts/grammars.json.

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
%s
            ],
            resources: [
                .copy("Resources")
            ],
            linkerSettings: [
                .linkedLibrary("c++", .when(platforms: [.macOS])),
                .linkedLibrary("stdc++", .when(platforms: [.linux]))
            ]
        ),
%s,
        .testTarget(
            name: "CodeEditLanguagesTests",
            dependencies: ["CodeEditLanguages"]
        ),
    ],
    cLanguageStandard: .c11
)
""" % (deps_block, targets_block)
    PACKAGE_SWIFT.write_text(content)
    print("\nWrote %s" % PACKAGE_SWIFT, flush=True)


def main() -> int:
    manifest = json.loads(MANIFEST.read_text())
    VENDOR_ROOT.mkdir(parents=True, exist_ok=True)
    lock: dict = {}
    all_targets: list[dict] = []

    with tempfile.TemporaryDirectory(prefix="vendor-grammars-") as tmp:
        tmp_path = Path(tmp)
        for grammar in manifest["grammars"]:
            all_targets.extend(vendor_one(grammar, tmp_path, lock))

    LOCK.write_text(json.dumps(lock, indent=2, sort_keys=True) + "\n")
    print(f"\nWrote {LOCK}", flush=True)
    generate_package_swift(all_targets)

    # Keep directory so SPM sees sources
    (VENDOR_ROOT / ".gitkeep").write_text("")
    print("\nDone.", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
