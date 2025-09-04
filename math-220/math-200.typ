#import "../lib.typ": *

#show: setup.with(
  title: [MATH 220 \ _Mathematical Proof_],
  author: "Yecheng Liang",
)

= Notations

#figure(table(
  columns: 3,
  table.header([Symbol], [Definition/Alternative], [Description]),
  $NN$, ${1, 2, 3, ...}$, [Natural numbers],
  $ZZ$, ${..., -2, -1, 0, 1, 2, ...}$, [Integers],
  $QQ$, $$, [Rational numbers],
  $RR$, $$, [Real numbers],
  $II$, $$, [Irrational numbers (for this course)],
  $in$, $$, [An element of],
  $in.not$, $$, [Not an element of],
  $nothing$, ${}$, [Empty set],
  $Set(..., ...)$, ${...: ...}$, [Set builder],
  $divides$, $$, [Divides],
))

= Set
- Not ordered
- Deduplicated

#example[Building sets][
  - $Set(n^2, n in ZZ) = {0, 1, 4, 9, 16, ...}$
  - $Set(x in RR, x^2 - 2 = 0) = {-sqrt(2), +sqrt(2)}$
  - $Set(x in ZZ, x^2 - 2 = 0) = nothing$
  - $Set(x^2, x in (-3, 1]) = [0, 9)$
  - $A = Set(1 / n, n in NN), B = Set(x in A, x < 1 / (2 pi)) -> B = {1 / 7, 1 / 8, 1 / 9, ...}$
]

#example[Building more sets][
  Let $A = {..., -8, -4, 0, 4, 8, ...}, B = {..., -6, -3, 0, 3, 6, ...$.
  $
    A &= Set(4 n, n in ZZ) \
    B &= Set(3 k, k in ZZ)
  $
  Let C be the set of all elements which are sums of an element from A and an element from B.
  $
    C &= Set(4n + 3k, n, k in ZZ) \
    &= Set(x + y, x in A, y in B) \
    &= Set(m in ZZ, m = 4x + 3y, x, y in ZZ)
  $
  Prove that $C = ZZ$.
  #proof[][
    Let $t = 1, x = 4t, y = -3t$.
    $
      x + y &= 4t - 3t \
      &= t \
      &= 1 \
      therefore 1 &in C
    $
    Let $t in ZZ$.
    $
      x + y &= 4t - 3t \
      &= t \
      therefore C &in ZZ
    $
  ]
]

