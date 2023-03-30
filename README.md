## Setup

Before changing nushell do be your default shell run the following command:

```nushell
ln -sf ($nu.config-path | path dirname) ~/.nu-config
```

This sets up a symlink in your home directory that's necessary for the config to execute correctly

### Starship

Make sure to add the following to `~/.config/starship.toml`

```toml
[character]
format = '''

'''
```

This effectively _disables_ starship's caret.
