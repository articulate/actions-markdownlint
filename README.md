# markdownlint action

> [!CAUTION]
> This action is deprecated. Use [DavidAnson/markdownlint-cli2-action](https://github.com/DavidAnson/markdownlint-cli2-action)
> or [super-linter](https://github.com/super-linter/super-linter) instead.

This action lints your Markdown files with [markdownlint-cli](https://github.com/igorshubovych/markdownlint-cli).

## Usage

Including the action without any defaults will find a local markdownlint config
file (`.markdownlint.{yaml,yml,json}`) or use our included default and scan all
files with the `md` or `markdown` extension.

```yaml
- uses: articulate/actions-markdownlint@v1
```

You can set the config file, the files it scans, files/directories to ignore, or
the version of markdownlint-cli to install.

```yaml
- uses: articulate/actions-markdownlint@v1
  with:
    config: markdownlint-config.json
    files: 'docs/**/*.md'
    ignore: node_modules
    version: 0.28.1
```
