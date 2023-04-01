def gpt [prompt: string] {
  $prompt | chat-gpt | glow
}

def ghdl [url: string, path: string = "."] {
  let parsed_url = ($url | url parse)
  let filename = ($parsed_url.path | path basename)
  let raw_url = ($parsed_url.path | str replace '/blob/' '/' | $"https://raw.githubusercontent.com($in)")
  http get $raw_url | save $"($path)/($filename)"
}