# Setup

## Usage

Install [psioniq Header extensions from Visual Studio.](https://marketplace.visualstudio.com/items?itemName=psioniq.psi-header#language-configuration)

Fill in the fields in `paste-this-into-vscode-user-settings.json` and copy and paste them into your VSCode user settings.

```json
  "psi-header.variables": [
    ["author", ""],
    ["authoremail", ""],
    ["initials", ""],
    ["github-user", ""]
  ]
```

For convenience, you can also run this somewhat useless script.

```bash
$ chmod +rx ext-setup.sh
$ ./ext-setup.sh
```

This should output the configuration settings with errors. Copy the block of valid JSON and paste into user settings.
