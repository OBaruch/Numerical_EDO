# AGENTS.md

Rules for anyone — human contributor or AI coding agent — working on this repository.

## Golden rule

**`src/` is a historical record. Do not modify any file in it.**

The three MATLAB scripts are the original 2021 implementation and are preserved byte-for-byte:
no refactoring, formatting, bug fixes, renaming, re-encoding (they are ISO-8859-1 with CRLF on
purpose) or line-ending normalization. Verify before every commit:

```bash
sha256sum src/*.m
# 2a9c5afbc8efaa2d725202bfd2a322de4c6e746b0beae90a813360a73acf3ef5  src/metEDOEuler.m
# aa6106084c0272a008ef62dd08884790dafa152d259e47c1ad3d5281764b4ea9  src/metEDOEulerMejorado.m
# 6bcd8401fb4ab4b01a1ececd8acea4b9a89309b1d66490e34b3b3a58a8f3006c  src/metEDORungeKutta4Orden.m
```

## Allowed changes

- Documentation (`README.md`, `docs/`), written in English.
- Repository hygiene (`.gitignore`, `.gitattributes`) that does not alter `src/`.
- Improvement ideas go to [`docs/possible-improvements.md`](docs/possible-improvements.md) —
  never into the code.

## Documentation rules

- Label claims as **Confirmed**, **Inferred** or **Unknown**; never present an inference as fact.
- Do not invent course names, institutions, dates, versions, dependencies or commands.
- Keep the project's real size and character; do not add CI/CD, Docker, package managers,
  test frameworks or other tooling.

## Workflow

Follow *intent → spec → plan* ([`docs/sdlc/`](docs/sdlc/)): any new work states its intent,
updates the spec and records a plan before changes are made. A modernized version of the
algorithms, if ever wanted, belongs in a separate folder or repository — not in `src/`.
