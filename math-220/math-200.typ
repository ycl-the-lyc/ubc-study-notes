#import "../lib.typ": *

#let args = range(0, 3).map(_ => range(0, 3))

#table(
  columns: 3,
  ..args.flatten().map(str)
)

