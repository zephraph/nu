export def prepend-if [name, path] {
  if $nu.os-info.name == $name {
    prepend $path
  } else {
    $in
  }
}
