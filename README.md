# Numerical_EDO — Numerical Methods for Ordinary Differential Equations (MATLAB)

Three standalone MATLAB scripts that solve initial value problems (IVPs) for first-order
ordinary differential equations with classic one-step numerical methods — **Euler**,
**Improved Euler (Heun)** and **fourth-order Runge–Kutta** — and plot the numerical
approximation against the known analytical solution.

> *EDO* is the Spanish acronym for *Ecuaciones Diferenciales Ordinarias*
> (Ordinary Differential Equations). The original code, comments and plot labels are in Spanish.

---

## Project Overview

| | |
|---|---|
| **Language** | MATLAB (`.m` scripts) |
| **Size** | 3 scripts, 83 lines of code in total |
| **Methods** | Explicit Euler · Improved Euler / Heun (RK2) · Classic Runge–Kutta (RK4) |
| **Output** | MATLAB figures comparing numerical vs. analytical solutions |
| **Original upload** | 20 February 2021 |
| **License** | [MIT](LICENSE) |

## Project Context

**Project origin: Unknown** — most likely **Academic / Coursework** (*inferred, not confirmed*).

The repository contains no assignment statement, report, course name or institution. The
coursework hypothesis rests only on indirect evidence: the topic (a standard numerical-methods
syllabus unit), the Spanish naming, the use of textbook-style test problems with closed-form
solutions, and a hard-coded problem parameter (`d = 572`) that resembles a per-student assigned
value. See [`docs/project-context.md`](docs/project-context.md) for the full evidence breakdown.

## Problem Statement

Given an IVP `y' = f(t, y)`, `y(t0) = y0`, approximate `y(t)` on an interval using a fixed step
size `h`, and visually check the quality of the approximation by overlaying the exact solution.

## Objective

*Inferred:* implement three explicit one-step methods by hand (no use of `ode45` or other built-in
solvers) and compare each against an analytical solution to observe their accuracy.

## Repository Structure

```
.
├── README.md                  ← you are here
├── AGENTS.md                  ← rules for humans/AI agents working on this repo
├── LICENSE                    ← original MIT license (2021)
├── src/                       ← ORIGINAL MATLAB source code (unchanged)
│   ├── metEDOEuler.m
│   ├── metEDOEulerMejorado.m
│   └── metEDORungeKutta4Orden.m
└── docs/
    ├── project-context.md     ← origin, evidence, confirmed / inferred / unknown
    ├── numerical-methods.md   ← the IVPs, the methods and their mathematics
    ├── code-overview.md       ← file-by-file walkthrough of the scripts
    ├── possible-improvements.md ← observations NOT applied to the code
    └── sdlc/
        ├── intent.md          ← why this repository exists (reconstructed)
        ├── spec.md            ← what the code does (reverse-engineered spec)
        └── plan.md            ← how the repository refactor was planned and executed
```

## Original Implementation

This repository preserves the original implementation of the project. The source code has
intentionally not been refactored or modernized in order to retain the historical context and
original development approach.

The three scripts in [`src/`](src/) are byte-for-byte identical to the files uploaded in 2021
(same content, Latin-1 / ISO-8859-1 encoding and Windows CRLF line endings). They were only
moved into `src/`. Accented characters in Spanish comments (e.g. `Solución`) may display as `�`
on GitHub because of that original encoding; this is expected and deliberately left as is.

| File | SHA-256 |
|---|---|
| `src/metEDOEuler.m` | `2a9c5afbc8efaa2d725202bfd2a322de4c6e746b0beae90a813360a73acf3ef5` |
| `src/metEDOEulerMejorado.m` | `aa6106084c0272a008ef62dd08884790dafa152d259e47c1ad3d5281764b4ea9` |
| `src/metEDORungeKutta4Orden.m` | `6bcd8401fb4ab4b01a1ececd8acea4b9a89309b1d66490e34b3b3a58a8f3006c` |

## Technologies

- **MATLAB** — confirmed by `.m` extension and syntax (anonymous functions `@(t,y)`,
  `plot`, `subplot`, `legend`, `xlabel`).
- No toolboxes, external libraries or data files are used.
- The MATLAB version used originally is **unknown**. *Inferred:* the scripts use only core
  language features and should also run in GNU Octave, but this has not been verified.

## How It Works

Every script follows the same pattern:

1. `clear all; clc;` — reset the workspace.
2. Define the right-hand side `f(t, y)` as an anonymous function.
3. Set the step size `h` and the initial condition.
4. March forward with a `while` loop, applying the method's update formula.
5. Evaluate the closed-form analytical solution on the same time grid.
6. Plot numerical (blue) vs. analytical (red) solutions with a Spanish legend.

| Script | Method | Order | IVP | Interval | Step size |
|---|---|---|---|---|---|
| `metEDOEuler.m` | Explicit Euler | 1 | Problem A | `[0, 5]` | `h = 10^-1 … 10^-10` (10 subplots) |
| `metEDOEulerMejorado.m` | Improved Euler (Heun) | 2 | Problem B (`d = 572`) | `[572, 574]` | `h = 10^-3` |
| `metEDORungeKutta4Orden.m` | Runge–Kutta 4 | 4 | Problem B (`d = 572`) | `[572, 574]` | `h = 10^-3` |

**Problem A:** `y' = y + t²(cos t − sin t) + t(cos t − 3 sin t) − cos t`, `y(0) = 0`,
exact solution `y = 3cos t − 3eᵗ + t² sin t + 2t cos t + 3t sin t`.

**Problem B:** `y' = y − (t³ − d t² − d(d+2) t + d³ + 2d²)·e^(−t²/(2d)) / d`, `y(d) = 0`,
exact solution `y = (t − d)²·e^(−t²/(2d))`.

Both exact solutions were verified symbolically during documentation. Details in
[`docs/numerical-methods.md`](docs/numerical-methods.md) and [`docs/code-overview.md`](docs/code-overview.md).

## Inputs and Outputs

- **Inputs:** none at runtime. All parameters (`f`, `h`, interval, initial condition, `d`) are
  hard-coded in each script.
- **Outputs:** a MATLAB figure window. Nothing is written to disk. No historical output images
  were included in the original upload.

## Running the Project

Each file is an independent script (no functions, no shared state). In MATLAB:

```matlab
cd src
metEDOEulerMejorado        % Improved Euler (Heun)
metEDORungeKutta4Orden     % Runge–Kutta 4
metEDOEuler                % Euler — see warning below
```

> ⚠️ **`metEDOEuler.m` does not finish in practice.** It loops over step sizes down to
> `h = 10^-10`, which requires about 5 × 10¹⁰ iterations on `[0, 5]` with arrays that grow
> inside the loop. This is original behavior and has intentionally not been changed; see
> [`docs/possible-improvements.md`](docs/possible-improvements.md).

Each script starts with `clear all`, so running it erases the current MATLAB workspace.

## Documentation

- [Project context](docs/project-context.md)
- [Numerical methods and test problems](docs/numerical-methods.md)
- [Code overview](docs/code-overview.md)
- [Possible improvements (not applied)](docs/possible-improvements.md)
- Agentic SDLC artifacts: [intent](docs/sdlc/intent.md) · [spec](docs/sdlc/spec.md) · [plan](docs/sdlc/plan.md)
- [Contributor / agent rules](AGENTS.md)

## Historical Note

This repository was later reorganized and documented to improve readability and preserve the
historical context of the original project. The original source code remains unchanged.

## Author

**Baruch Lopez** — [@OBaruch](https://github.com/OBaruch)
