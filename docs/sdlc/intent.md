# Intent

[← Back to README](../../README.md) · **Intent** · [Spec](spec.md) · [Plan](plan.md)

> Part of a lightweight *intent → spec → plan* workflow. These three documents were written
> **after the fact**, reverse-engineered from what already exists in the repository. They
> describe the original project and the later repository refactor; they do not introduce new
> features.

## 1. Original intent (reconstructed)

**Status:** Inferred — no original statement of intent exists in the repository.

> Implement, by hand, three classic explicit one-step methods for first-order ODE initial
> value problems — Euler, Improved Euler (Heun) and 4th-order Runge–Kutta — and demonstrate
> their accuracy by plotting each numerical solution against a known analytical solution.

### Why (inferred)

- To practice translating numerical-method formulas into working MATLAB code.
- To observe, visually, how step size and method order affect accuracy.
- Most likely to fulfill a numerical-methods coursework activity (see
  [project context](../project-context.md); the academic origin is **not confirmed**).

### Who

- **Author:** Baruch Lopez (confirmed).
- **Audience:** Unknown. *Inferred:* an instructor or the author themself.

### Success looked like (inferred)

- Each script runs and produces a figure in which the numerical curve (blue) overlays the
  analytical curve (red).

## 2. Repository refactor intent (2026)

**Status:** Confirmed — this is the goal of the documentation effort.

> Turn an undocumented upload of three scripts into a clear, navigable, historically honest
> portfolio repository **without modifying a single byte of the original source code**.

### Goals

- **G1** — Anyone can understand what the project does in under five minutes from the README.
- **G2** — The original implementation is preserved exactly and this is stated explicitly.
- **G3** — Context is documented with a clear distinction between *Confirmed*, *Inferred* and
  *Unknown* information.
- **G4** — The mathematics and the behavior of each script are documented.
- **G5** — Known issues and improvement ideas are recorded separately from the code.
- **G6** — Future contributors (human or AI agent) have explicit rules that protect the
  original code ([AGENTS.md](../../AGENTS.md)).

### Non-goals

- Fixing, optimizing, reformatting, re-encoding or rewriting any `.m` file.
- Adding tests, CI/CD, build tooling, packaging or new features.
- Inventing context (course, institution, dates) not supported by evidence.
- Making a small learning project look like production software.

### Guiding principle

**Modernize the repository, not the project.**
