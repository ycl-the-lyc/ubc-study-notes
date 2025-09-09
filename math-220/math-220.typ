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
  $EE$, $$, [Even numbers],
  $in$, $$, [An element of],
  $in.not$, $$, [Not an element of],
  $nothing$, ${}$, [Empty set],
  $Set(..., ...)$, ${...: ...}$, [Set builder],
  $divides$, $$, [Divides],
  $and$, $$, [And],
  $or$, $$, [Or],
  $xor$, $"xor"$, [Exclusive or],
  $tilde$, $not quad excl$, [Not],
  $->$, $$, [Tends to],
  $==>$, $$, [Implies],
))

= Set
#definition[Set][
  A collection of objects.
  The objects are referred to as elements or members of the set.

  Ordering of a set and occurrences of its elements are trivial.
]

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
    A & = Set(4 n, n in ZZ) \
    B & = Set(3 k, k in ZZ)
  $
  Let C be the set of all elements which are sums of an element from A and an element from B.
  $
    C & = Set(4n + 3k, n, k in ZZ) \
      & = Set(x + y, x in A, y in B) \
      & = Set(m in ZZ, m = 4x + 3y, x, y in ZZ)
  $
]

#definition[Cardinality of Set][
  For a set $S$, cardinality is the number of elements in it, $abs(S)$, even when they cannot be definitely counted.
]


#theorem[Set Equality][
  For sets $S, T$,
  $
    S = T iff (S subset T) and (T subset S)
  $

  #example[][
    $
      S = Set(3x + 7y, x, y in ZZ)
    $
    For any $x = -2y$, note that $x, y in ZZ$,
    $
      3x + 7y & = -6y + 7y \
              & = y \
              & therefore ZZ subset.eq S
    $
    Also, every element of $S$ is of the form $3x + 7y$,
    $
           x, y & in ZZ \
      (3x + 7y) & in ZZ \
                & therefore S subset.eq ZZ
    $
    Thus, $S = ZZ$.
  ]
]

In essence, to prove set equality, we need to show that "every element of S is made by rules of T" and "every element of T is made by rules of S".

#theorem[Bézout's Identity][
  Let $a$ and $b$ be integers with greatest common divisor $d$. Then there exist integers $x$ and $y$ such that $a x + b y = d$. Moreover, the integers of the form $a z + b t$ are exactly the multiples of $d$.
]

= Logic

#definition[Statement][
  A claim that is either true false, and there is only once case which it is true.
]

#definition[Open Sentence][
  A sentence whose truth value depends on the variable(s) that it contains.
]

Statements and open sentences are mutually exclusive, since statements have defined truth value, while open sentences have variables not _clearly_ defined, thus have no clearly defined truth cases.

To think of them mathematically, a statement is a variable, an open sentence is a function.

#definition[Implication][
  For statements $P$ and $Q$, if $P$ implied $A$, $P ==> Q$, then if $P$ is true, $Q$ must be true.
  _An implication is true unless proven false._

  #table(
    columns: 3,
    table.header($P$, $Q$, $P ==> Q$),
    [T], [T], [T],
    [T], [F], [F],
    [F], [T], [T],
    [F], [F], [T],
  )
]

Generally, "if... then..." indicates an implication.

To prove an implication, the typical workflow is
+ assume the hypothesis of implication is true;
+ work...;
+ show that $P: T ==> Q: F$ cannot happen.
Since the implication _cannot be false_, it must be true.

== Parity and Divisibility

#definition[Parity][
  A number $n$ is even if $n = 2k$ for some integer $k$.

  A number $n$ is odd if $n = j + 1$ for some integer $j$.
]

To prove parity,
+ substitute variable with the definition of even/odd number;
+ factor expression, most likely with $2$ since it is the coefficient in the definitions;
+ find definition of even/odd number, $2("some integer") "or" 2("some integer") + 1$.
