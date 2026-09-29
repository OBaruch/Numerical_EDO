# Code Overview

[← Back to README](../README.md)

A file-by-file walkthrough of the original scripts in [`src/`](../src/). Code excerpts are
quoted verbatim (only the Spanish accents are shown correctly here; in the files they are
stored in Latin-1).

## Overall structure

- Three **independent scripts** — no functions, no shared files, no calls between them.
- Each script clears the workspace, defines `f(t, y)`, integrates with a `while` loop, computes
  the analytical solution and plots both.
- Arrays (`t`, `y`, `k1…k4`, `y1`) grow dynamically inside the loop (no preallocation).
- There are no inputs, no files read or written, and no return values.

```
metEDOEuler.m               metEDOEulerMejorado.m        metEDORungeKutta4Orden.m
   Problem A                    Problem B (d=572)            Problem B (d=572)
   Euler                        Heun (RK2)                   RK4
   h = 1e-1 … 1e-10             h = 1e-3                     h = 1e-3
   10 subplots                  1 plot                       1 plot
```

Because the project consists of three standalone scripts, no separate architecture document
was created.

---

## `metEDOEuler.m` — Euler method (23 lines)

**Purpose:** solve Problem A with explicit Euler for ten step sizes and plot each result next
to the exact solution.

| Variable | Meaning |
|---|---|
| `f` | Right-hand side of Problem A, `@(t,y)(...)` |
| `g = 10` | Number of plots / step sizes (comment: `%graficas`) |
| `h = 10.^-(1:g)` | Step sizes `[1e-1, 1e-2, …, 1e-10]` |
| `tf = 5` | Final time |
| `k` | Index of the current step size |
| `t`, `y`, `i` | Time grid, numerical solution, loop counter |
| `sol` | Analytical solution evaluated on `t` |

**Flow:**

```matlab
for k=1:g
    t(1)=0; y(1)=0; i=1;
    while(t(i)<=tf)
        y(i+1)=y(i)+h(k)*f(t(i),y(i));      % Euler step
        t(i+1)=t(i)+h(k); i=i+1;
    end
    sol=3.*cos(t)-3.*exp(t)+t.^2.*sin(t)+2.*t.*cos(t)+3.*t.*sin(t);
    subplot(1,g,k);plot(t,y,'b',t,sol,'r')
end
legend(...); xlabel(['Método de Euler'])
```

**Observations (behavior only, nothing changed):**

- The outer loop runs 10 times with `h` shrinking by a factor of 10 each time. The last
  iterations require ~5 × 10⁸, 5 × 10⁹ and 5 × 10¹⁰ steps, so the script does not complete
  in practice.
- `t` and `y` are not cleared between iterations of `k`; each new run overwrites the beginning
  of the arrays. Because each run is longer than the previous one, earlier data is fully
  overwritten, so this does not affect the plots.
- The loop condition `t(i)<=tf` lets the grid step one point past `tf` (e.g. `t ≈ 5.1` for
  `h = 0.1`).
- `legend` and `xlabel` are called once after the loop, so they apply only to the last subplot.
- The trailing comment `%Valor real` (*real value*) has no code under it.

---

## `metEDOEulerMejorado.m` — Improved Euler / Heun (29 lines)

**Purpose:** solve Problem B (`d = 572`) on `[572, 574]` with Heun's predictor–corrector
method and `h = 10⁻³`.

| Variable | Meaning |
|---|---|
| `d = 572` | Problem parameter and start time |
| `f` | Right-hand side of Problem B |
| `h = 10.^(-3)` | Step size |
| `y1` | Euler predictor at each step |
| `t`, `y`, `i` | Time grid, numerical solution, loop counter |
| `sol` | Analytical solution `(t-d).^2.*exp(-t.^2/(2*d))` |

**Flow:**

```matlab
y(d)=0;
i=1;
t(1)=d;
while(t(i)<=d+2)
    y1(i)=y(i)+h*f(t(i),y(i));                          % predictor
    y(i+1)=y(i)+(h/2)*(f(t(i),y(i))+f(t(i)+h,y1(i)));   % corrector
    t(i+1)=t(i)+h;
    i=i+1;
end
sol=(t-d).^2.*exp(-t.^2/(2*d));
plot(t,y,'b',t,sol,'r*')
```

**Observations:**

- `y(d)=0` creates a 1 × 572 vector of zeros, so the effective initial value is `y(1) = 0`,
  which matches the mathematical condition `y(t0 = d) = 0`. *Inferred:* the line reads like the
  mathematical notation `y(d) = 0` for the initial condition. Since the loop writes about 2 000
  entries, all preallocated zeros are overwritten.
- ~2 001 iterations; runs quickly.
- The exact solution is plotted with red asterisks (`'r*'`), which at 2 001 points appear as a
  thick red band. A commented-out line `%plot(t,y,'b')` shows an alternative that plots only
  the numerical solution.

---

## `metEDORungeKutta4Orden.m` — Runge–Kutta 4th order (31 lines)

**Purpose:** same problem, interval and step size as the Heun script, integrated with classic
RK4.

The file is structurally identical to `metEDOEulerMejorado.m`; only the loop body and the
x-axis label differ:

```matlab
k1(i)=f(t(i),y(i));
k2(i)=f(t(i)+(h/2),y(i)+h*(k1(i)/2));
k3(i)=f(t(i)+(h/2),y(i)+h*(k2(i)/2));
k4(i)=f(t(i)+h,y(i)+h*k3(i));
y(i+1)=y(i)+(h/6)*(k1(i)+2*k2(i)+2*k3(i)+k4(i));
```

**Observations:**

- All stage values are kept in arrays `k1…k4`, although only the current step's values are
  needed.
- The x-axis label reads `'RungaKutta'` (original spelling).

---

## Dependencies observed

Only core MATLAB: anonymous functions, element-wise operators (`.*`, `.^`), `cos`, `sin`,
`exp`, `plot`, `subplot`, `legend`, `xlabel`, `clear`, `clc`. No toolboxes.

## Related documents

- [Numerical methods](numerical-methods.md)
- [Possible improvements](possible-improvements.md)
- [Specification](sdlc/spec.md)
