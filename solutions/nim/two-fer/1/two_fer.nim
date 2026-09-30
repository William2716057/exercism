proc twoFer*(name = ""): string =
  let person = if name == "": "you" else: name
  "One for " & person & ", one for me."