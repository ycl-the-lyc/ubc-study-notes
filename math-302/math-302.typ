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
  / "Pick": To remove an element from the population, when order matters.
  / "Choose": To remove an element in the population, when order does not matter.
]

#definition[
  Given a set $D$,
  - sampling $k$ _with replacement_ means that each sample is independent of each other; the sample space is $D^k$;
  - sampling $k$ _without replacement_ means that each choice reduces the population; the sample space is $npk(D) := Set(d, d in pws(D), abs(d) = k)$.

  Note that replacement has nothing to do with order.
  The definition above concerns no ordering during or after sampling.
]

The "number of ways to _pick_ $k$ elements out of $n$ elements" with
$
  npk() & = n (n - 1) (n - 2) ... (n - k + 1) \
        & =n! / (n - k)!
$

The "number of ways to _choose_ $k$ elements out of $n$ elements" with
$
  nck() & := npk() / k! \
        & = n! / (k! (n - k)!).
$

#theorem[
  Given sets $A, B$ where $abs(B) = n$,
  $
        abs((A)_k) & = (abs(A))_k \
    abs(nck(B, k)) & = nck(abs(B), k) \
                   & = nck(n, k).
  $
]

== Decomposing Events
Based on additivity of probability, if we can decompose an event with large sample space to smaller, disjoint events, such that
$
  abs(A) & = sum_(i = 1)^k A_i.
$
If $A$ is uniform, and each of the $A_i$ are equal in size, then
$
  P(A) & = k P(A_i).
$

#problem[
  Given a set of poker of fifty-two cards, define
  $
    A & := { "full house" }.
  $
  Give $P(A)$.

  #solution[
    Let $2 <= i, eq.not k <= 14$ (J, Q, K, A being 11 to 14),
    $
      A_(i, j) := { i "appears with two suits", j "appears with three suits" }.
    $
    Hence,
    $
      A & = union.plus_("all" (i, j) suchthat 2 <= i eq.not j <= 14) A_(i, j).
    $
    We are picking two numbers out of thirteen, so
    $
      abs(A) & = npk(13, 2) \
             & = 13 times 12.
    $

    Recall that the poker distribution is uniform (as we assume), thus each number is equally likely to be drawn.
    $
            P(A) & = k P(A_1) \
                 & = npk(13, 2) times "probability of a specific full house" \
                 & = npk(13, 2) times "size of sample space of one full house" / "size of sample space of all hands" \
           Omega & := "all sets of five cards" \
      abs(Omega) & = nck(52, 5).
    $
    We pick that full house of two 2's and three 3's for no reason.
    $
      abs(A_(2, 3)) & = nck(4, 2) nck(4, 3) \
               P(A) & = npk(13, 2) (nck(4, 2) nck(4, 3)) / nck(52, 5).
    $
  ]
]

