import strutils
  
proc hey*(s: string): string =
  
  var hasLetter = false

  for c in s:
    if c.isAlphaAscii:
      hasLetter = true

  let message = s.strip()

  if message.toUpperAscii() == message and hasLetter and message.endsWith("?"):
    "Calm down, I know what I'm doing!"

  elif message.endsWith("?"):
    "Sure."

  elif s.toUpperAscii() == s and  s.endsWith("?"):
    "Calm down, I know what I'm doing!"

  elif s.toUpperAscii() == s and s.toLowerAscii() != s: 
    "Whoa, chill out!"

  elif s.strip() == "":
    "Fine. Be that way!"

  elif s.endswith(" "):
    "Whatever."

  else:
    "Whatever."
