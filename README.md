# mrk1

## Quick start

```bash
git clone https://github.com/sevmorris/mrk1.git
cd mrk1
make fix-exec && make install
make defaults
```

Utilities and scripts for setting up and maintaining a macOS workstation.

## Installation

Clone the repo and run the setup via `make`:

```bash
git clone https://github.com/sevmorris/mrk1.git
cd mrk1
make fix-exec && make install
```

To apply macOS defaults afterward:

To uninstall (if supported by your setup):

```bash
make uninstall
```

```bash
make defaults
```

## Executable permissions

If you see `permission denied` when running scripts after a fresh clone or unzip, fix executable bits:

```bash
# One-shot fixer
bash mrk1/scripts/fix-exec.sh

# Or manually
chmod +x mrk1/scripts/install mrk1/scripts/defaults.sh
find mrk1/scripts -type f -name "*.sh" -exec chmod +x {} \;
```

## Makefile usage

```bash
make fix-exec      # Ensure all scripts are executable
make install       # Run the main installer
make defaults      # Apply macOS defaults configuration
```

## Portability

- No hardcoded usernames — paths use `${HOME}`.
- Scripts aim to be idempotent and safe if re-run.

## CI

[![CI](https://github.com/sevmorris/mrk1/actions/workflows/ci.yml/badge.svg)](https://github.com/sevmorris/mrk1/actions/workflows/ci.yml)


## Built-in utilities

From the repo root, you can run these via `make` or directly from `scripts/`:

- `make fix-exec` — ensure all scripts are executable (covers `.sh` files **and** common entrypoints without an extension, and any file with a shebang).
- `make install` — run the main installer (`scripts/install`).
- `make defaults` — apply macOS defaults (`scripts/defaults.sh`).
- `make uninstall` — run the uninstaller (`scripts/uninstall.sh`, which delegates to `scripts/uninstall-defaults.sh` if present).

> Tip: If you add new helpers under `scripts/` without `.sh` extensions, make sure they either have a shebang (`#!/usr/bin/env bash`) or are named like one of the common entrypoints listed above so `make fix-exec` will mark them executable.

### Utilities via `make`

Run the built-in utilities with friendly targets:

```bash
make doctor         # scripts/doctor
make syncall        # scripts/syncall
make link-tools     # scripts/link-tools
make bootstrap      # scripts/bootstrap
make mrk1-maint     # scripts/mrk1-maint
make brew-cleanup   # scripts/brew-cleanup.sh
```

### Generic `make <script>` runner

You can run **any executable** under `scripts/` directly via `make`:

```bash
# These run scripts/<name>
make doctor
make syncall
make link-tools
make bootstrap
make mrk1-maint
make brew-cleanup
# ...and any new helper you add:
make my-new-helper
```

> If a helper doesn’t end in `.sh`, that’s fine. Ensure it has a shebang (`#!/usr/bin/env bash`) or run `make fix-exec` after adding it so permissions are correct.
