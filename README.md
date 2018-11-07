# Kata-bash

## Install

* clone the repository

### install bats

```bash
sudo apt-get install bats
```

Mac:
```bash
brew install bats
```

## Rules

* Start with `0.money_vars.bats` suite. Launch tests with : `bats 0.money_vars.bats`.
* Skip tests one by one
* All tests should pass before starting a new suite.
* All your bash files must contain these headers :

```bash
#!/usr/bin/env bash
set -o errexit
set -o nounset
```