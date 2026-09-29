# Possible Improvements

[← Back to README](../README.md)

> **None of the items below has been applied.** The code in [`src/`](../src/) is kept exactly
> as originally written to preserve the historical implementation. This list only records
> observations that a present-day reader might find useful.

## Correctness / feasibility

1. **Euler step-size sweep is infeasible.** `h = 10.^-(1:10)` on `[0, 5]` implies ~5 × 10¹⁰
   steps for the smallest `h`, with arrays growing each step. Limiting the sweep (e.g. to
   `10^-1 … 10^-4`) would let the script finish.
2. **Floating-point roundoff at small `h`.** For very small step sizes, accumulated roundoff in
   `t(i+1) = t(i) + h` and in `y` would dominate the truncation error, so the smallest step
   sizes would not improve accuracy anyway.
3. **Loop overshoot.** `while (t(i) <= tf)` produces one extra grid point beyond `tf`.
   Computing the number of steps `N = round((tf - t0)/h)` and using a `for` loop would end
   exactly at `tf`.
4. **Initial condition idiom.** `y(d)=0` allocates 572 zeros to set `y(1) = 0`; `y(1) = 0`
   states the intent directly.

## Code structure

5. **Duplicated code.** The Heun and RK4 scripts share everything except the update step.
   A common driver taking a stepping function (or separate `function` files such as
   `euler(f, t0, y0, h, tf)`) would remove duplication.
6. **No preallocation.** Arrays grow inside the loop (MATLAB editor warning). Preallocating
   `t`, `y` with `zeros(1, N+1)` improves performance.
7. **Unneeded arrays.** `y1`, `k1…k4` only need scalar values for the current step.
8. **`clear all`** also clears breakpoints and loaded functions; `clear` or `clearvars` is
   usually preferred, and scripts converted to functions would not need it at all.

## Presentation

9. **Error visualization.** On Problem B both solutions are ≈ 10⁻¹²⁵ and look flat; plotting
   the absolute or relative error (optionally on a log scale) would show the accuracy
   difference between Heun and RK4 far more clearly.
10. **Legend placement.** In the Euler script `legend`/`xlabel` apply only to the last of ten
    subplots; `sgtitle` or per-subplot titles showing `h` would improve readability.
11. **Typo.** `'RungaKutta'` → `'Runge–Kutta'` in the RK4 plot label.
12. **Encoding.** Saving the files as UTF-8 would make accented comments display correctly on
    GitHub (current MATLAB versions default to UTF-8).

## Validation

13. **Convergence study.** An automated check of observed order (error ratio when halving `h`)
    would confirm orders 1, 2 and 4 numerically. See the reference figures in
    [numerical-methods.md](numerical-methods.md#4-independent-re-computation-reference-only).
14. **Comparison with a built-in solver** such as `ode45` as an additional reference.
