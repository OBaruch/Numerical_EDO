# Specification

[← Back to README](../../README.md) · [Intent](intent.md) · **Spec** · [Plan](plan.md)

> A **descriptive** (reverse-engineered) specification: it states what the original code
> *does*, not what it should do. Where the code deviates from an ideal implementation, the
> spec records the actual behavior and links to
> [possible-improvements.md](../possible-improvements.md). Part A covers the original project;
> Part B covers the repository refactor.

---

## Part A — Original project

### A.1 Scope

Three standalone MATLAB scripts in [`src/`](../../src/). No functions, inputs, files or
external dependencies. Output is a MATLAB figure.

### A.2 Functional requirements (as implemented)

#### Common to all scripts

| ID | Requirement | Evidence |
|---|---|---|
| FR-0.1 | The script clears the workspace and command window before running (`clear all; clc`). | All files, line 1–2 |
| FR-0.2 | The ODE right-hand side is defined as an anonymous function `f = @(t,y)(...)`. | All files |
| FR-0.3 | Integration uses a fixed step `h` and a `while (t(i) <= t_end)` loop. | All files |
| FR-0.4 | The analytical solution is evaluated on the same grid as the numerical one. | All files |
| FR-0.5 | Numerical solution is plotted in blue, analytical in red, with the Spanish legend *"Solución numérica (aproximada)"*, *"Solución analítica (exacta)"*. | All files |

#### `metEDOEuler.m`

| ID | Requirement |
|---|---|
| FR-1.1 | Solve `y' = y + t²(cos t − sin t) + t(cos t − 3 sin t) − cos t`, `y(0) = 0`, up to `tf = 5`. |
| FR-1.2 | Update rule: `y(i+1) = y(i) + h·f(t(i), y(i))`. |
| FR-1.3 | Repeat for `g = 10` step sizes `h = 10⁻¹ … 10⁻¹⁰`. |
| FR-1.4 | Draw each run in its own subplot of a 1 × 10 grid, with the analytical solution `3cos t − 3eᵗ + t² sin t + 2t cos t + 3t sin t`. |
| FR-1.5 | Label the x-axis *"Método de Euler"* (applied to the last subplot). |

#### `metEDOEulerMejorado.m`

| ID | Requirement |
|---|---|
| FR-2.1 | With `d = 572`, solve `y' = y − (t³ − d t² − d(d+2)t + d³ + 2d²)·e^(−t²/(2d))/d`, `y(d) = 0`, on `[d, d+2]`. |
| FR-2.2 | Step size `h = 10⁻³`. |
| FR-2.3 | Predictor `y1(i) = y(i) + h·f(t(i), y(i))`; corrector `y(i+1) = y(i) + (h/2)·(f(t(i), y(i)) + f(t(i)+h, y1(i)))`. |
| FR-2.4 | Plot against `(t − d)²·e^(−t²/(2d))` using `'r*'` markers; x-label *"Método de Euler mejorado"*. |

#### `metEDORungeKutta4Orden.m`

| ID | Requirement |
|---|---|
| FR-3.1 | Same problem, interval and step size as FR-2.1 / FR-2.2. |
| FR-3.2 | Classic RK4 stages `k1…k4` and update `y(i+1) = y(i) + (h/6)(k1 + 2k2 + 2k3 + k4)`. |
| FR-3.3 | Plot as in FR-2.4 with x-label *"RungaKutta"*. |

### A.3 Non-functional characteristics (as implemented)

| ID | Characteristic |
|---|---|
| NF-1 | Platform: MATLAB (version unknown). Core language only, no toolboxes. |
| NF-2 | Source encoding ISO-8859-1, CRLF line endings. |
| NF-3 | Heun and RK4 scripts: ~2 001 steps, run in well under a second on a modern machine. |
| NF-4 | Euler script: does **not** complete in practical time (~5 × 10¹⁰ steps for `h = 10⁻¹⁰`). |
| NF-5 | Arrays grow dynamically; no preallocation. |

### A.4 Acceptance criteria (observable)

| ID | Criterion | Status |
|---|---|---|
| AC-1 | Analytical solution of Problem A satisfies its ODE and `y(0) = 0`. | ✅ Verified symbolically |
| AC-2 | Analytical solution of Problem B satisfies its ODE and `y(d) = 0` for any `d > 0`. | ✅ Verified symbolically |
| AC-3 | Euler error decreases ~linearly with `h`. | ✅ Reproduced independently for `h = 10⁻¹…10⁻⁵` |
| AC-4 | Heun is more accurate than Euler-level accuracy; RK4 more accurate than Heun at equal `h`. | ✅ Reproduced independently (≈ 3 × 10⁻⁶ vs ≈ 8 × 10⁻¹¹ relative error) |
| AC-5 | Scripts run unmodified in a current MATLAB release. | ❔ Not verified (no MATLAB available during documentation) |

---

## Part B — Repository refactor

### B.1 Constraints (hard)

| ID | Constraint |
|---|---|
| C-1 | The content of every `.m` file must remain byte-identical to commit `c922ad5` (verified by SHA-256). |
| C-2 | File names of the scripts must not change; relocation into `src/` is allowed. |
| C-3 | `LICENSE` must remain unchanged. |
| C-4 | No new tooling (CI, Docker, package managers, linters, test frameworks, Makefiles). |
| C-5 | No invented facts; every claim is labeled *Confirmed*, *Inferred* or *Unknown* where relevant. |
| C-6 | Documentation in English. |
| C-7 | All commits authored by Baruch Lopez. |

### B.2 Deliverables

| ID | Deliverable |
|---|---|
| D-1 | `README.md` with overview, context, structure, original-implementation note, technologies, how it works, I/O, running instructions, documentation links and historical note. |
| D-2 | `src/` containing the three original scripts. |
| D-3 | `docs/project-context.md`, `docs/numerical-methods.md`, `docs/code-overview.md`, `docs/possible-improvements.md`. |
| D-4 | `docs/sdlc/intent.md`, `docs/sdlc/spec.md`, `docs/sdlc/plan.md`. |
| D-5 | `AGENTS.md` with rules that protect the original code. |
| D-6 | `.gitattributes` preventing line-ending/encoding normalization of `.m` files; `.gitignore` for MATLAB/Octave artifacts. |

### B.3 Not created (and why)

| Item | Reason |
|---|---|
| `docs/original/` | No original PDF/Word/other documents exist. |
| `docs/assignment.md` | No evidence of an assignment statement. |
| `docs/architecture.md` | Three independent scripts; no meaningful architecture. |
| `data/`, `assets/`, `examples/`, `archive/` | No datasets, images, outputs or historical variants exist. |
