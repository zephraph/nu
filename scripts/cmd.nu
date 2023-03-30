export def defined [name] {
  which $name | length | into bool
}