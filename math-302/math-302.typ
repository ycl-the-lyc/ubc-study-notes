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
    Let $2 <= i, eq.not k <= 14$ (J, Q, K, A being eleven to fourteen),
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

#problem[
  Similar to above, but cards are replaced after removed.

  #solution[
    Only two things changed:
    - $Omega = 52^5$ since cards are replaced;
    - $abs(A_(2, 3))$ is different.

    Given two cards in a hand are 2, the rest are 3; the picking of each rank is trivial:
    $
      abs(A_(2, 3) ("some position")) & = 4^2 times 4^3.
    $
    What is left is choosing which two spots the 2 should reside in.
    $
      abs(A_(2, 3)) & = nck(5, 2) times 4^2 times 4^3.
    $

    The same follows.
  ]
]

We decomposed problems of rank, suit and position to smaller problems which are either ordered or unordered.
Commonly, making them unordered problems will be easier.

#important-box[
  Always think of utilizing uniform distribution of probability, and complement of events.
]

#problem[
  Flipping a coin with $p$ probability for tail, how many flips it takes for tail to show up?

  #solution[
    $
      Omega = NN + {oo}
    $
    where $oo$ is the events where tail never show up, $i$ is the events which the first $i - 1$ flips are head.

    $
      P(i) & = P_i ({"first" i - 1 "flips are heads"}) dot P_i ({"the" i"th" "flip is tail"}) \
           & = (1 - p)^(i - 1) p
    $

    We know that a tail will eventually show up, so $P(oo) = 0$.
    To show that, we take its complement
    $
      P(oo) & = 1 - P(NN) \
            & = 1 - sum_(i=1)^oo P(i) \
            & = 1 - sum_(i=1)^oo (1 - p)^(i - 1) p.
    $
    Sum $P(NN)$ up as a geometric series: let $j = i - 1$,
    $
      sum_(j=0)^oo (1 - p)^j p & = p dot 1 / (1 - (1 - p)) \
                               & = p / p \
                               & = 1 \
                         P(oo) & = 0.
    $
  ]
]

#definition(title: [Discrete])[
  Countably infinite and finite spaces are discrete spaces.
]

$
  P(A) = sum_(omega in A) P({omega})
$
provided that $A$ is discrete.

== Inclusion and Exclusion
For three sets overlapping like the color combinations, we can
+ count each set;
+ eliminate the three two-set overlaps;
+ add the three-set overlap back.

For all $A, B, C in Omega$,
$
  P(A union B union C) & = P(A) + P(B) + P(C) \
                       & - P(A inter B) - P(B inter C) - P(A inter C) \
                       & + P(A inter B inter C).
$

In times when calculating probability of an event is hard, we can take its complement and the parent probability.
Finding symmetry can shrink sample space that is significance to us, like the probability of three dice rolls to be the same, is just the probability of two two-rolls.

= Random Variables

