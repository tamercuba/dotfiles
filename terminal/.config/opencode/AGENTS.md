# Clojure Tooling

## Rules

- After writing or editing any Clojure/ClojureScript code, evaluate it with
  `clj-nrepl-eval` to verify it works before considering the task done.
- After every edit to a Clojure file (`.clj`, `.cljs`, `.cljc`), run
  `clj-paren-repair <file>` to fix delimiters. Never attempt to repair
  parentheses manually.

## Project: musicaltec/app

- This project always has an nREPL running on port `7888`.
  Use `clj-nrepl-eval -p 7888 "<code>"` for evaluation there.

## REPL Evaluation

The command `clj-nrepl-eval` is installed on your PATH for evaluating Clojure code via nREPL.

**Discover nREPL servers:**

`clj-nrepl-eval --discover-ports`

**Evaluate code:**

`clj-nrepl-eval -p <port> "<clojure-code>"`

With timeout (milliseconds):

`clj-nrepl-eval -p <port> --timeout 5000 "<clojure-code>"`

The REPL session persists between evaluations - namespaces and state are maintained.
Always use `:reload` when requiring namespaces to pick up changes.

## Parenthesis Repair

The command `clj-paren-repair` is installed on your PATH.

Examples:

`clj-paren-repair path/to/file.clj`
`clj-paren-repair src/core.clj src/util.clj test/core_test.clj`

**IMPORTANT:** Do NOT try to manually repair parenthesis errors.
If you encounter unbalanced delimiters, run `clj-paren-repair` on the file
instead of attempting to fix them yourself. If the tool doesn't work,
report to the user that they need to fix the delimiter error manually.

The tool automatically formats files with cljfmt when it processes them.
