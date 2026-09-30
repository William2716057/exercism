import std/sets

proc sum*(limit: int, factors: openArray[int]): int =
  var multiples = initHashSet[int]()

  for factor in factors:
    if factor > 0:
      var multiplier = 1

      while factor * multiplier < limit:
        multiples.incl(factor * multiplier)
        multiplier += 1

  for multiple in multiples:
    result += multiple
