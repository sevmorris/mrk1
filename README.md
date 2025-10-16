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
- This repo intentionally does **not** include any features that hide network or Time Machine volumes from the Desktop.

## CI

[![CI](https://github.com/sevmorris/mrk1/actions/workflows/ci.yml/badge.svg)](https://github.com/sevmorris/mrk1/actions/workflows/ci.yml)