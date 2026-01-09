#import "../lib.typ": *
#show: setup.with(
  title: [MATH 302 _Introduction to Probability_],
  author: "Yecheng Liang",
)

= Sample Spaces and Probabilities
#definition[
  A sample point $omega$, is a possible outcome.

  A sample space, $Omega$, is a set of all sample points.

  An event is a subset of $Omega$.
  All possible events is thus conviniently $pws(Omega)$.

  A possibility, $P$, is the relevant proabbility measure on $Omega$ so that for all events $A subset.eq Omega, P(A) = "the probability that event" A "occurs"$.

  A complement of an event, $A$, in $Omega$, is $A^C = Omega - A$.
]

Naturally, $P(Omega) = P(A union.plus A^C) = 1$, and $P(union.plus_(i=1)^n A_i)$ where $A$ is a _countable_ set, for $n in NN union {oo}$.

#theorem[
  $
    abs(A^d) = abs(A)^d
  $
]

A uniform distribution $P$ on a finite $Omega$ is defined via:
$
  forall omega in Omega, P({omega}) = 1 / abs(Omega).
$

#theorem(title: [Additivity of Probability])[
  Intuitively, for a uniform distribution of outcomes,
  $
    forall A subset.eq Omega, P(A) = abs(A) / abs(Omega).
  $
  #proof[
    $
      P(A) & := sum_(a in A) P(a) \
           & = sum_(a in A) 1 / abs(Omega) \
           & = abs(A) / abs(Omega).
    $
  ]

]

#theorem[
  Probability is monotonic on event size.
  If $A subset.eq B subset.eq Omega$, then $P(A) <= P(B) <= 1$.

  #proof[
    $
         B & = A union.plus (B - A) \
      P(B) & = P(A union.plus (B - A)) \
           & = P(A) + P(B - A) \
           & >= P(A).
    $
  ]
]

Above, we assumed that the events are disjoint.
However, if not, we get a commonly used inequality,

#theorem(title: [Union Bound])[
  $
    forall 1 <= k <= oo "and" A_i subset.eq Omega, P(union_(i=1)^k A_i) <= sum_(1<=i<=k) P(A_i).
  $

  #proof[
    Using monotonicity of probability,
    $
      P(A union B) & = P(A union.plus B - A) \
                   & = P(A) + P(B - A) \
                   & <= P(A) + P(B).
    $
  ]
]

== Random Sampling
#definition[
  Given a set $D$,
  - sampling $k$ _with replacement_ means that each sample is independent of each other; the sample space is $D^k$;
  - sampling $k$ _without replacement_ means that each choice reduces the population; the sample space is $(D)_k := Set(d, d in pws(D), abs(d) = k)$.
]

We denote "number of ways to pick $k$ _distinct_ elements out of $n$ elements" using $(n)_k$, which is $n! / (n - k)!$.

#theorem[
  $
    abs((A)_k) = (abs(A))_k.
  $
]

