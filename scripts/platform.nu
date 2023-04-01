export def prepend-if [os, text] {
  if $nu.os-info.name == $os {
    prepend $text
  } else {
    $in
  }
}

export def append-if [os, text] {
  if $nu.os-info.name == $os {
    append $text
  } else {
    $in
  }
}