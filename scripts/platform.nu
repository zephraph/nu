export def prepend-if [os, text] {
  if $nu.os-info.name == $os {
    prepend $text
  } else {
    $in
  }
}