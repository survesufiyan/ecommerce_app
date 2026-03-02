# Contributing to ShopHub

Thank you for your interest in contributing! Here's how to get started.

## Getting Started

1. **Fork** the repository on GitHub
2. **Clone** your fork:
```bash
   git clone https://github.com/YOUR-USERNAME/shophub.git
   cd shophub
```
3. **Create a branch** for your change:
```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-name
```
4. **Install dependencies:**
```bash
   flutter pub get
```
5. **Make your changes**, then verify:
```bash
   flutter analyze
   flutter run
```
6. **Commit** with a clear message:
```bash
   git commit -m "feat: add wishlist sorting by price"
```
7. **Push** to your fork:
```bash
   git push origin feature/your-feature-name
```
8. **Open a Pull Request** on GitHub against the `main` branch.

## Commit Message Format

Use conventional commits:

| Prefix | Use for |
|--------|---------|
| `feat:` | New feature |
| `fix:` | Bug fix |
| `ui:` | Visual/layout change |
| `refactor:` | Code restructure, no behavior change |
| `docs:` | Documentation only |
| `chore:` | Dependency updates, config |

## Code Style Guidelines

- Use the **orange accent color** `Color(0xFFFF6B35)` — don't introduce new primary colors
- Use `BorderRadius.circular(12)` for small cards, `BorderRadius.circular(16)` for larger containers
- Follow existing **Provider pattern** for state — don't introduce new state management libraries
- Keep widgets under **300 lines** — split large screens into sub-widgets
- Run `flutter analyze` before submitting — zero warnings policy

## What We Welcome

- Bug fixes (check open Issues first)
- UI polish and animation improvements
- New screens: order tracking, product reviews, notifications
- Performance improvements (image loading, API caching)
- Accessibility improvements
- Test coverage

## What to Avoid

- Changing the core color scheme or typography
- Introducing new dependencies without discussion (open an Issue first)
- PRs that mix unrelated changes — keep them focused

## Need Help?

Open an Issue with the `question` label and describe what you're trying to do.