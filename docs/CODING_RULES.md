# Coding Rules

These rules define one consistent way to write code in this repository. Follow them exactly. When they conflict with a habit, the rules win. When they conflict with the existing code around you, refactor toward the rules.

## 1. Code against guarantees, not possibilities

At every point in the program, know what is true: which values exist, which invariants hold, what the caller has promised. Write code that relies on those guarantees. Never write code for states that cannot occur.

## 2. Validation happens once, at the boundary

- Validate where untrusted data enters: HTTP handlers, CLI args, file parsers, external APIs, database reads, environment variables.
- Validation converts raw input into typed, trustworthy domain values. After the boundary, the data is valid **by construction**.
- Inside the system, do not re-validate. No `if x is None`, no `hasattr`, no `isinstance` checks against your own code, no try/except around internal calls unless the callee's contract explicitly allows that failure.

## 3. No dead checks

- Never write `if x is None: return` (or `continue`, `raise`, a default value) where `x` is already guaranteed non-None by a type, a constructor, or a check above.
- Never branch on impossible states. A branch for a case that cannot happen hides design errors and doubles the reader's work.
- If you cannot tell whether a value can be absent, the contract is broken. Fix the contract (signature, type, construction site) - do not patch the call site with a check.

## 4. Make invalid states unrepresentable

- Prefer types over checks. Parse strings into domain types at the boundary. Use dataclasses / TypedDict / enums instead of loose dicts.
- Narrow `Optional` away as early as possible. A field that is always present after validation is not `Optional`.
- One canonical representation per concept. Raw JSON/dicts do not travel past the boundary layer.

## 5. Failure policy: loud at the boundary, silent nowhere

- At the boundary, reject bad input with a clear error message naming what was expected and what was received.
- In the interior, let exceptions propagate to the layer that can act on them. Never catch an exception to return `None` or a default; never swallow; never log-and-continue past a broken invariant.
- `assert` is acceptable for internal invariants that must hold by construction.

## 6. Functions

- One function, one job. If it fits on one screen and needs no sections, it is the right size.
- The name states what it does; the body does exactly that.
- When types do not say it all, document the contract in the docstring:
  - **Pre:** what the caller must guarantee (non-empty list, sorted input, open connection).
  - **Post:** what the function guarantees (returns the matching row or raises `NotFoundError`).
- A function body trusts its Pre completely. A caller establishes the Pre before calling.

## 7. Naming

- Names say what the thing is, long enough to be unambiguous: `retry_delay_seconds`, not `rd`.
- Booleans read as predicates: `is_ready`, `has_items`, `can_retry`. Never negated (`no_items`, `is_not_valid`).
- No abbreviations except universal ones (`id`, `url`, `db`). Include units and qualifiers in the name instead of in a comment.

## 8. Comments

Code must explain itself. The default number of comments is **zero**; each comment must earn its place.

Allowed, when they add information the code cannot carry:
- **Why**: a non-obvious reason, constraint, or decision (`# OrderedDict: iteration order is part of the wire format`).
- **Contracts**: Pre/Post on functions whose types don't say enough.
- **References**: spec section, issue link, or standard that justifies a non-obvious implementation.

Forbidden:
- Narrating *what* the code does (`# increment counter`, `# loop over users`). If the what needs explaining, rename or extract a function instead.
- Restating the signature or the type annotation.
- Self-justifying comments that excuse weak code (`# this is a bit hacky but...`, `# not ideal but works for now`). Fix the code, or document the real constraint that forces the shape.
- Commented-out code and changelog comments. Version control owns history.

A comment that justifies a workaround is a bug report, not documentation. Treat it as a prompt to refactor.

## 9. Consistency

- One way to do each thing in this codebase. Match the surrounding patterns; if the pattern violates these rules, refactor it.
- Let the formatter and linter own layout. Do not hand-format.

## Example

```python
# Bad: defensive, noisy, hides the contract
def get_discount(user):
    if user is None:
        return 0
    if not hasattr(user, "plan"):   # TODO: shouldn't happen but just in case
        return 0
    if user.plan is None:
        return 0
    plan = PLANS.get(user.plan)
    if plan is None:
        return 0
    return plan.discount

# Good: validated at the boundary, typed, trusts the contract
def get_discount(user: User) -> float:
    """Pre: user.plan is a key of PLANS (enforced at login).
    Post: returns the plan's discount rate."""
    return PLANS[user.plan].discount
```

The good version is shorter **and** safer: the guarantee lives in one place (the boundary), and every reader can see it.
