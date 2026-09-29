# Numerical Methods and Test Problems

[← Back to README](../README.md)

This document describes the mathematics implemented by the original scripts. It explains the
code; it does not change it.

## 1. The initial value problem

All three scripts solve a scalar first-order IVP

$$
y'(t) = f(t, y), \qquad y(t_0) = y_0,
$$

on a uniform grid $t_{i+1} = t_i + h$, producing approximations $y_i \approx y(t_i)$.

## 2. Test problems

### Problem A — used by `metEDOEuler.m`

$$
y' = y + t^2(\cos t - \sin t) + t(\cos t - 3\sin t) - \cos t, \qquad y(0) = 0, \qquad t \in [0, 5]
$$

Analytical solution (as written in the script):

$$
y(t) = 3\cos t - 3e^{t} + t^2 \sin t + 2t\cos t + 3t\sin t
$$

*Verified:* substituting $y(t)$ gives a residual $y' - f(t, y) = 0$, and $y(0) = 3 - 3 = 0$.
The solution is dominated by $-3e^{t}$, so it decreases rapidly (≈ −480 at $t = 5$).

### Problem B — used by `metEDOEulerMejorado.m` and `metEDORungeKutta4Orden.m`

With the parameter $d = 572$:

$$
y' = y - \frac{\left(t^3 - d\,t^2 - d(d+2)\,t + d^3 + 2d^2\right) e^{-t^2/(2d)}}{d},
\qquad y(d) = 0, \qquad t \in [d,\ d+2]
$$

Analytical solution (as written in the scripts):

$$
y(t) = (t - d)^2 \, e^{-t^2/(2d)}
$$

*Verified:* the residual $y' - f(t, y)$ simplifies to $0$ for any $d > 0$, and $y(d) = 0$.

**Numerical scale.** On $[572, 574]$ the factor $e^{-t^2/(2d)}$ is about $10^{-124}$–$10^{-125}$,
so both the exact and the numerical solutions are extremely small numbers (≈ $3.3 \times 10^{-125}$
at the end of the interval). They are still representable in double precision, so the
comparison is meaningful, but the curves look flat when plotted on a linear scale.

## 3. Methods

### Explicit Euler (order 1) — `metEDOEuler.m`

$$
y_{i+1} = y_i + h\, f(t_i, y_i)
$$

Local truncation error $O(h^2)$, global error $O(h)$.

### Improved Euler / Heun (order 2) — `metEDOEulerMejorado.m`

A predictor–corrector scheme: an Euler predictor followed by trapezoidal averaging of slopes.

$$
\tilde y_{i+1} = y_i + h\, f(t_i, y_i), \qquad
y_{i+1} = y_i + \frac{h}{2}\left[f(t_i, y_i) + f(t_i + h, \tilde y_{i+1})\right]
$$

In the code the predictor is stored in the array `y1`. Global error $O(h^2)$.

### Classic Runge–Kutta (order 4) — `metEDORungeKutta4Orden.m`

$$
\begin{aligned}
k_1 &= f(t_i, y_i) \\
k_2 &= f\!\left(t_i + \tfrac{h}{2},\ y_i + \tfrac{h}{2}k_1\right) \\
k_3 &= f\!\left(t_i + \tfrac{h}{2},\ y_i + \tfrac{h}{2}k_2\right) \\
k_4 &= f(t_i + h,\ y_i + h k_3) \\
y_{i+1} &= y_i + \tfrac{h}{6}\left(k_1 + 2k_2 + 2k_3 + k_4\right)
\end{aligned}
$$

Global error $O(h^4)$. The code stores every stage in arrays `k1 … k4`.

## 4. Independent re-computation (reference only)

> The following figures were produced while writing this documentation by re-implementing the
> same update formulas in a separate, throw-away script. They are **not** part of the original
> project and no such script was added to the repository. They are included only to
> characterize the behavior of the original algorithms.

**Euler on Problem A** — absolute error at the last grid point (≈ $t = 5$):

| `h` | Steps | Absolute error |
|---|---|---|
| 10⁻¹ | 51 | ≈ 1.2 × 10² |
| 10⁻² | 501 | ≈ 1.2 × 10¹ |
| 10⁻³ | 5 000 | ≈ 1.2 |
| 10⁻⁴ | 50 000 | ≈ 1.2 × 10⁻¹ |
| 10⁻⁵ | ~500 000 | ≈ 1.2 × 10⁻² |

The error shrinks by ≈ 10× per decade of `h`, as expected for a first-order method. Extending
the table to `h = 10⁻¹⁰` (as the original script attempts) would need ~5 × 10¹⁰ steps.

**Problem B, `h = 10⁻³`, 2 001 steps** — maximum relative error over the interval:

| Method | Max. relative error |
|---|---|
| Improved Euler (Heun) | ≈ 3 × 10⁻⁶ |
| Runge–Kutta 4 | ≈ 8 × 10⁻¹¹ |

These values are consistent with the theoretical orders 2 and 4.

## Related documents

- [Code overview](code-overview.md)
- [Possible improvements](possible-improvements.md)
