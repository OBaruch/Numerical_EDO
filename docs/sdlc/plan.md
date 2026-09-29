# Plan

[← Back to README](../../README.md) · [Intent](intent.md) · [Spec](spec.md) · **Plan**

> Execution plan for the repository refactor described in [intent.md](intent.md) and
> [spec.md](spec.md). All tasks are complete; the plan is kept as a record of how the work was
> done and how the preservation constraint was verified.

## Phase 0 — Baseline and guardrails

| Task | Result |
|---|---|
| T0.1 Inventory every file in the repository. | `LICENSE`, 3 `.m` scripts. No docs, data or images. |
| T0.2 Record the git history. | 2 commits, 20 Feb 2021, author Baruch Lopez. |
| T0.3 Record SHA-256 of every original file. | Hashes listed in [README](../../README.md#original-implementation). |
| T0.4 Detect encoding and line endings. | ISO-8859-1, CRLF → must be protected (see T3.3). |
| T0.5 Work on a dedicated branch, never on `main`. | Branch `docs/repository-refactor`. |

## Phase 1 — Context recovery

| Task | Result |
|---|---|
| T1.1 Read every script line by line. | Methods, ODEs, parameters and plotting identified. |
| T1.2 Search for PDFs, Word, slides, images, notebooks, datasets. | None present. |
| T1.3 Decode names (`met`, `EDO`, `Mejorado`, `4Orden`). | Spanish numerical-methods vocabulary. |
| T1.4 Verify analytical solutions symbolically. | Both satisfy their ODE and initial condition. |
| T1.5 Re-compute the algorithms independently (throw-away, not committed). | Orders 1, 2 and 4 observed; Euler sweep infeasible beyond ~10⁻⁷. |
| T1.6 Classify origin with evidence levels. | *Unknown*, likely coursework (inferred). |

## Phase 2 — Structure

| Task | Result |
|---|---|
| T2.1 Choose the minimal structure that fits the content. | `src/` + `docs/` (+ `docs/sdlc/`). |
| T2.2 Move scripts with `git mv` (history-preserving rename). | 100 % similarity renames. |
| T2.3 Decide which reference folders to omit. | See [spec B.3](spec.md#b3-not-created-and-why). |

## Phase 3 — Documentation and repository hygiene

| Task | Result |
|---|---|
| T3.1 Write `README.md`. | Done. |
| T3.2 Write `docs/*.md` (context, methods, code overview, improvements). | Done. |
| T3.3 Add `.gitattributes` (`*.m -text`) so git never rewrites line endings or encoding of the originals. | Done. |
| T3.4 Add `.gitignore` for MATLAB/Octave editor and workspace artifacts. | Done. |
| T3.5 Add `AGENTS.md` with the preservation rules. | Done. |
| T3.6 Write intent / spec / plan. | Done. |

## Phase 4 — Verification

| Check | Method | Result |
|---|---|---|
| V1 Source untouched | `sha256sum src/*.m` equals the Phase 0 hashes | ✅ |
| V2 No content diff | `git diff --stat -M main -- '*.m'` shows renames only | ✅ |
| V3 License untouched | `git diff main -- LICENSE` is empty | ✅ |
| V4 Links | Every relative link in the Markdown files points to an existing file | ✅ |
| V5 No invented facts | Review of each claim against the evidence labels | ✅ |

### Re-running V1 at any time

```bash
sha256sum src/*.m
# 2a9c5afbc8efaa2d725202bfd2a322de4c6e746b0beae90a813360a73acf3ef5  src/metEDOEuler.m
# aa6106084c0272a008ef62dd08884790dafa152d259e47c1ad3d5281764b4ea9  src/metEDOEulerMejorado.m
# 6bcd8401fb4ab4b01a1ececd8acea4b9a89309b1d66490e34b3b3a58a8f3006c  src/metEDORungeKutta4Orden.m
```

## Phase 5 — Delivery

| Task | Result |
|---|---|
| T5.1 Commit in small, descriptive commits authored by Baruch Lopez. | Done. |
| T5.2 Open a pull request from `docs/repository-refactor` into `main`. | Done. |

## Out of scope / future work

Any change to the scripts themselves (see [possible-improvements.md](../possible-improvements.md))
would require a new intent and spec, and should live in a **separate** folder or repository so
that `src/` keeps representing the 2021 implementation.
