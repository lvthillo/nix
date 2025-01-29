# Nix for macOS configuration

This is my personal Nix for macOS configuration.

## Prerequisites

<details>
<summary>Nix</summary>
<br>
<pre>
$ sh <(curl -L https://nixos.org/nix/install)
</pre>
</details>

<details>
<summary>Xcode Command Line Tools</summary>
<br>
<pre>
$ xcode-select --install
</pre>
</details>

<details>
<summary>Rosetta 2</summary>
<br>
<pre>
$ softwareupdate --install-rosetta
</pre>
</details>

## Get started

### 1. Clone this repository

```bash
$ git clone git@github.com:lvthillo/nix.git
```

### 2. Deploy the configuration

```bash
$ nix build .#darwinConfigurations.BEKT7VWGFQDP.system --extra-experimental-features 'nix-command flakes'

$ ./result/sw/bin/darwin-rebuild switch --flake .#BEKT7VWGFQDP
```

After deploying the configuration for the first time, you can simply run `just deploy` to apply changes.

To view all available commands, run `just` .
