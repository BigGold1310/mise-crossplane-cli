<div align="center">

# mise-crossplane-cli [![Build](https://github.com/BigGold1310/asdf-mise-crossplane-cli/actions/workflows/build.yml/badge.svg)](https://github.com/BigGold1310/asdf-mise-crossplane-cli/actions/workflows/build.yml) [![Lint](https://github.com/BigGold1310/asdf-mise-crossplane-cli/actions/workflows/lint.yml/badge.svg)](https://github.com/BigGold1310/asdf-mise-crossplane-cli/actions/workflows/lint.yml)

mise-crossplane-cli is a plugin for [mise](https://mise.jdx.dev/) installing the [crossplane cli](https://docs.crossplane.io/latest/cli/command-reference/).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin install mise-crossplane-cli
# or
asdf plugin install mise-crossplane-cli https://github.com/BigGold1310/asdf-mise-crossplane-cli.git
```

mise-crossplane-cli:

```shell
# Show all installable versions
asdf list-all mise-crossplane-cli

# Install specific version
asdf install mise-crossplane-cli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global mise-crossplane-cli latest

# Now mise-crossplane-cli commands are available
crossplane version
```

Check [mise](https://mise.jdx.dev/) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome!

[Thanks goes to these contributors](https://github.com/BigGold1310/asdf-mise-crossplane-cli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Cyrill Näf](https://github.com/BigGold1310/)
