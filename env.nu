# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

use ./scripts/platform.nu

let-env PATH = (
  $env.PATH 
  | split row (char esep) 
  | platform prepend-if linux '/home/linuxbrew/.linuxbrew/bin'
  | platform prepend-if macos '/opt/homebrew/bin'
  | prepend '/usr/local/bin'
  | append './node_modules/.bin' 
  | append '~/.config/carapace/bin'
  | append '~/go/bin' 
  | append '~/.cargo/bin' 
  | append '~/.bin' 
  | append '~/.deno/bin'
  | append '~/scripts'
  )

let-env EDITOR = (which code).0.path

# Setup starship prompt
let-env STARSHIP_SHELL = "nu"
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = ""

let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = "❯ "
let-env PROMPT_INDICATOR_VI_NORMAL = "<=> "
let-env PROMPT_MULTILINE_INDICATOR = "::: "

# ASDF
let-env ASDF_NU_DIR = (brew --prefix asdf | str trim | into string | path join 'libexec')

# Ensure link directory exists
mkdir ~/.nu-link

# Given that you can't dynamically source a file, I create a dynamic link to the asdf.nu file
# and source that in the config.nu file. This is a hack, but it works. 
if $nu.os-info.name == "linux" {
  ln -sf /home/linuxbrew/.linuxbrew/opt/asdf/libexec/asdf.nu ~/.nu-link/asdf.nu
} else if $nu.os-info.name == "macos" {
  ln -sf /opt/homebrew/opt/asdf/libexec/asdf.nu ~/.nu-link/asdf.nu
}