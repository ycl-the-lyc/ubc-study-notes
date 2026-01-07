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

