# Project Context

[← Back to README](../README.md)

This document reconstructs the origin and purpose of the project from the evidence available in
the repository. Every statement is labeled:

- **Confirmed** — directly supported by files, code or git history.
- **Inferred** — a reasonable deduction from the repository, not proven.
- **Unknown** — cannot be determined from the repository.

## Classification

**Project origin: Unknown** — most likely **Coursework / Assignment** in a numerical methods
course (**Inferred**).

## Available sources

The original repository contained only:

| File | Type | Notes |
|---|---|---|
| `LICENSE` | License | MIT, "Copyright (c) 2021 Baruch Lopez" |
| `metEDOEuler.m` | MATLAB script | Euler method |
| `metEDOEulerMejorado.m` | MATLAB script | Improved Euler (Heun) method |
| `metEDORungeKutta4Orden.m` | MATLAB script | 4th-order Runge–Kutta |

There were **no** PDF, Word, PowerPoint, image, dataset, notebook, output or configuration
files, and no README. Consequently, all context below comes from the code itself, file names,
the repository name and the git history.

## Findings

### Confirmed

- **Author:** Baruch Lopez (GitHub `OBaruch`), per `LICENSE` and git history.
- **Date:** the repository was created and the three scripts were uploaded on
  **20 February 2021** (commits `e0d7778` "Initial commit" and `c922ad5` "Add files via upload").
  The upload through the GitHub web interface means the files were written *before* that date;
  the actual development date is **Unknown**.
- **Language:** MATLAB.
- **Subject:** numerical solution of first-order ordinary differential equations (ODE / EDO).
  The file names spell out the methods: `met` (*método*), `EDO` (*Ecuaciones Diferenciales
  Ordinarias*), `Euler`, `EulerMejorado` (*Improved Euler*), `RungeKutta4Orden`
  (*4th-order Runge–Kutta*).
- **Language of the author's annotations:** Spanish (`Solución numérica`, `Solución analítica`,
  `graficas`, `Graficacion`, `Método de Euler`).
- **Validation approach:** each script compares the numerical result with a closed-form
  analytical solution. Both analytical solutions were verified symbolically during this
  documentation effort (they satisfy the ODEs and the initial conditions exactly).
- **Encoding:** the scripts are ISO-8859-1 (Latin-1) text with CRLF line endings, typical of
  files saved by MATLAB on Windows.

### Inferred

- **Academic origin.** Euler → Improved Euler → RK4 is the canonical progression of a
  numerical-methods or differential-equations course. The test problems are constructed so
  that their exact solutions are known, a common teaching device.
- **Assigned parameter.** `d = 572` in the Heun and RK4 scripts parameterizes the ODE and the
  integration interval `[d, d+2]`. An arbitrary-looking integer used this way resembles a
  value assigned per student (e.g. derived from a student ID or list number). This is a
  hypothesis only.
- **Two separate exercises.** The Euler script uses a different ODE (Problem A) and a
  step-size sweep, while Heun and RK4 share Problem B and a single step size. This suggests
  either two different exercises or two stages of the same assignment.
- **Learning goal.** The Euler script's sweep of `h = 10^-1 … 10^-10` with one subplot per
  step size suggests the intent was to show visually how the approximation converges as `h`
  decreases.

### Unknown

- University, course, professor, assignment statement or grading criteria.
- Whether the scripts were a graded deliverable, practice, or self-study.
- The meaning of `d = 572`.
- The MATLAB version used.
- Whether the Euler script was ever run to completion with all ten step sizes (it is
  computationally infeasible as written; see [possible-improvements.md](possible-improvements.md)).
- Whether any report, plots or results accompanied the code.

The original repository does not provide enough information to determine these points.

## Scope

The project is small and self-contained: three independent scripts, no shared functions, no
data files, no user input, and plots as the only output. It should be read as a compact
demonstration of hand-coded ODE integrators, not as a reusable library.

## Related documents

- [Numerical methods and test problems](numerical-methods.md)
- [Code overview](code-overview.md)
- [Intent](sdlc/intent.md) · [Spec](sdlc/spec.md) · [Plan](sdlc/plan.md)
