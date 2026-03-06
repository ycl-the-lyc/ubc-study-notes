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
  All possible events is thus conveniently $pws(Omega)$.

  A possibility, $P$, is the relevant probability measure on $Omega$ so that for all events $A subset.eq Omega, P(A) = "the probability that event" A "occurs"$.

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
  / Pick: To remove an element from the population, when order matters.
  / Choose: To remove an element in the population, when order does not matter.
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
Based on additivity of probability, if we can decompose an event with large sample space into smaller, disjoint events, such that
$
  abs(A) & = sum_(i = 1)^k abs(A_i).
$
If $A$ is uniform, and all the $A_i$ are equal in size, then
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
    Let $2 <= i eq.not k <= 14$ (J, Q, K, A being eleven to fourteen),
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
                 & = npk(13, 2) times "event size of one full house" / "sample space size of all hands" \
           Omega & := "all sets of five cards" \
      abs(Omega) & = nck(52, 5).
    $
    We pick that full house of two 2 and three 3 for no reason.
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

We decomposed problems of rank, suit, and position to smaller problems which are either ordered or unordered.
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
    where $oo$ is the event where tail never shows up, $i$ is the events which the first $i - 1$ flips are heads.

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
Finding symmetry can shrink sample space that is significance to us, like the probability of three dice rolls to be the same, is just the probability of two 2-rolls.

== Random Variables
#definition(title: [Random Variable])[
  Given a sample space $Omega$, a discrete random variable is a probability measure function
  $
    X: Omega -> RR.
  $
  Shorten $Set(omega in Omega, f(X(omega)))$ to ${f(X)}$.
]

A random variable is discrete if its sample space where sample probability is not zero is countable.

#example[
  Use the previous head toss number example.
  Let $X$ be the number of heads.
  $
    P_X (j) & = nck(n, j) p^j (i - p)^(n - j)
  $
  which expands from the particular case of one head.
]

= Conditional Probability
#definition(title: [Conditional Probability])[
  Denoted $P(A|B)$, it is the probability of event $A$ given event $B$ is happened.
  $P(A|B) + P(A^c|B) = 1$.

  Since
  $
    P(A inter B) & = P(B) P(A given B) \
                 & = P(A) P(B given A),
  $
  if $P(B) > 0$,
  $
    P(A|B) & = P(A "and" B "happen") / P(B "happens") \
           & = P(A inter B) / P(B).
  $
]

Given multiple conditions,
$
  P(A_1 inter A_2 inter A_3 inter ... inter A_n) = & P(A_1) P(A_2 given A_1) P(A_3 given A_1 inter A_2) \
                                                   & ... P(A_n given A_1 inter A_2 inter ... inter A_(n - 1)).
$

== Symmetry
#theorem[
  Given $k$ elements from a uniformly distributed $Omega$, the first $k$ items of a random permutation of $Omega$ is the same as $k$ elements sampled from $Omega$ without replacement.
  All the $npk(abs(Omega), n)$ possibilities are equal.
]

#theorem(title: [Total Probability Formula])[
  $
    P(A) = & P(A inter B) + P(A inter B^c) \
         = & P(A given B) P(B) + P(A given B^c) P(B^c).
  $
  If $B_i$ partitions $Omega$, then
  $
    P(A) = & sum_(i = 0)^oo P(A inter B_i) \
         = & sum_(i = 0)^oo P(A given B_i) P(B_i).
  $
]

This fact can dissect complicated probability into simpler probabilities for individual cases.

#problem[
  For three coin flips, roll a dice on each head.
  What is the probability of the sum of dice rolls to be 3?

  #solution[
    Let $S = "sum of dice values", X = "n.o. of heads"$.
    The dice rolls needed for each viable $X$ are ${3}, {1, 2} "or" {2, 1}, {1, 1, 1}$.
    $
      P(S = 3) = & sum_(i = 0)^3 P(X = i) P(S = 3 given X = i) \
      = & 1 / 2^3 times 0 + nck(3, 1) / 2^3 times 1 / 6 + nck(3, 2) / 2^3 times 1 / 6^2 times 2 + nck(3, 3) / 2^3 times 1 / 6^3.
    $
  ]

  #problem[
    And, get $P(X = 1 given S = 3)$.

    #solution[
      $
        P(X = 1 given S = 3) = & P(S = 3 inter X = 1) / P(S = 3) \
                             = & (P(S = 3 given X = 1) P(X = 1)) / P(S = 3) \
                             = & (3 / 8 times 1 / 6) / P(S = 3).
      $
    ]
  ]
]

#theorem(title: [Bayes' Formula])[
  $
    P(B given A) = & P(A inter B) / P(A) \
                 = & (P(A given B) P(B)) / P(A) \
                 = & (P(A given B) P(B)) / (P(A given B) P(B) + P(A given B^c) P(B^c))
  $
]

#problem[
  A rare disease affects $1 / 10^6$ of the population.
  The test for it has
  - $1 / 10^4$ chance of false positive;
  - $1 / 10^5$ chance of false negative.

  You tested positive, but what is the chance that you actually have the disease?

  #solution[
    Let
    $
      D = & { "have disease" } \
      T = & { "tested positive" }.
    $
    We want $P(D given T)$.
    $
                P(D) = & 1 / 10^6 \
      P(T given D^c) = & 1 / 10^4 \
      P(T^c given D) = & 1 / 10^5 \
        P(T given D) = & 1 - P(T^c given D) \
        P(D given T) = & (P(T given D) P(D)) / P(T) \
                     = & (P(T given D) P(D)) / (P(T given D) P(D) + P(T given D^c) P(D^c)).
    $
  ]
]

#important-box[
  Given a condition, the sum of probabilities of an event and its complement is $1$.
]

#problem[
  Someone has two children.
  Get
  $
    P("two daughters" given "at least one child is a daughter born on Sunday").
  $

  #solution[
    The chances of sex and weekday of birth are independent, and are uniformly distributed.
    Let
    $
      A = & "two daughters" \
      D = & "at least one is a daughter born on Sunday".
    $
    $P(D)$ is not obvious, but $P(A), P(D^c)$ are easy to get.
    Use the total probability formula:
    $
      P(A given D) = & P(A inter D) / P(D) \
              P(D) = & 1 - P(D^c) \
                   = & 1 - (1 - 1 / 2 times 1 / 7)^2 \
                   = & 27 / 196 \
      P(A inter D) = & P(A) - P(A inter D^c) \
                   = & (1 / 2)^2 - (1 / 2 times 6 / 7)^2 \
                   = & 13 / 196 \
      P(A given D) = & 13 / 27.
    $
  ]
]

== Independence
#definition(title: [Independence])[
  Given events $A, B$, they are independent iff
  $
    P(A inter B) = & P(A) P(B).
  $
]

Hence, if $A, B$ are independent and $P(B) eq.not 0$,
$
  P(A given B) = & P(A inter B) / P(B) \
               = & (P(A) P(B)) / P(B) \
               = & P(A).
$

#theorem[
  If $A, B$ are independent, then so are
  - $A, B^c$,
  - $A^c, B$,
  - $A^c, B^c$.
]

#theorem[
  Any event is independent to $Omega$ or $emptyset$.
]

#theorem[
  If $A, B$ are disjoint, $A, B$ are independent iff $P(A) = 0 or P(B) = 0$.

  #proof[
    Given that $A, B$ are disjoint.
    $
      P(A inter B) = & 0.
    $

    - Assume that they are independent.
      $
              P(A) P(B) = P(inter B) = & 0 \
        A, B "are independent" implies & P(A) = 0 or P(B) = 0.
      $
    - Assume that $P(A) = 0 or P(B) = 0$.
      $
                     P(A) P(B) = 0 = & P(A inter B) \
        P(A) = 0 or P(B) = 0 implies & A, B "are independent".
      $
  ]
]

#theorem[
  Given events $A, B$ and that $A subset.eq B$.
  $A, B$ are independent iff $P(A) in {0, 1} or P(B) in {0, 1}$.
]

#theorem[
  Given a finite $Omega$ are $P$ that is uniform over $Omega$.
  $A, B subset.eq Omega$ are independent iff
  $
    abs(A inter B) / abs(Omega) = & abs(A) / abs(Omega) abs(B) / abs(Omega).
  $

  See whose probabilities the terms correspond to for proof.
]

We can extend the independence between two random variables to multiple's.

#theorem[
  Let $X_1, X_2, ..., X_n$ be discrete random variables defined on the same sample space.
  They are independent of each other iff
  $
    P(X_1 = k_1, X_2 = k_2, ..., X_n = k_n) = product_i P(X_i = k_i)
  $
  for all viable $k$ values.
]

== Bernoulli, Binomial and Geometric Random Variables
#definition(title: [Bernoulli Random Variable])[
  $Bern(p)$ is the outcome of an experiment that is either 1 or 0.
  $
    P(X follows Bern(p) = 1) = & p \
    P(X follows Bern(p) = 0) = & 1 - p.
  $
]

#definition(title: [Binomial Random Variable])[
  $Bin(n, p)$ is the number of 1 in $n$ independent experiments that are either 1 or 0.
  $
    P(X follows Bin(n, p) = k) = & nck(n, k) p^k (1 - p)^(n - k).
  $
]

#definition(title: [Geometric Random Variable])[
  $Geom(p)$ is the number of trials until the first experiments resulting in 1 in a sequence of independent experiments that are either 1 or 0.
  $
    P(X follows Geom(p) = k) = & (1 - p)^(k - 1) p \
    P(X follows Geom(p) > k) = & (1 - p)^k.
  $
]

#problem[
  Let $X_i follows Geom(p_i)$, solve for $P(X > k)$.

  #solution[
    $
      P(X > k) = & product_i^oo P(X_i > k) \
               = & product_0^oo (1 - p_i)^k \
               = & [product_0^oo (1 - p_i)]^k.
    $
  ]
]

== Poisson Distribution
#definition(title: [Poisson Distribution])[
  $Pois(lambda)$ is the number of 1 in some number of independent experiments that are either 1 or 0.
  $
    P(X follows Pois(lambda) = k) = & (e^(-lambda) lambda^k) / k!.
  $

  Note that for a sample space of $X follows Pois(lambda)$ elements, the number of 1, $Y follows Pois(lambda p)$, and the number of 0, $Z follows Pois(lambda (1 - p))$ are independent.
  $
    P(Y = k and Z = j) = & P(Pois(lambda) = k + j) P(Bin(k + j, p) = k).
  $
]

== Conditional Independence
#definition(title: [Conditional Independence])[
  Given events $D$, events $A, B$ are conditionally independent iff
  $
    P(A inter B given D) = & P(A given D) P(B given D).
  $
]

== Probability Density
#definition(title: [Probability Density Function (PDF)])[
  The probability density function, $f(x)$, of random variable $X$ is defined by
  $
    P(X <= a) = integral_(-oo)^(a) f(x) dd(x).
  $

  Notably,
  $
                   forall x, f(x) >= & 0 \
    integral_(-oo)^(oo) f(x) dd(x) = & 1.
  $
]

Although the integral of a PDF from $-oo$ to $oo$ is $1$, it can be larger than $1$ at any point.

#theorem[
  Random variable $X$ has a PDF iff
  $
    forall B in RR "and" k, P(Unif[-k, k] in B) = 0 and P(X in B) = 0.
  $
]

If random variable $X$ has a PDF, then
- $X$ is continuous, thus $P(X = k) = 0$;
- $P(X in B) = integral_B f(x) dd(x)$;
- $P(X in [a, b]) = integral_(a)^(b) f(x) dd(x)$.

Define $F_X (t) := P(X <= t)$.
If PDF $f(x)$ is right-continuous, then
$
  f(x) = & lim_(epsilon -> 0^+) (F_X (t + epsilon) - F_X (t)) / epsilon \
       = & dv(, x) F_X (t).
$

#problem[
  Let $X = "fair 6-sided dice roll", Y follows Unif[0, 2]$ and they are independent.
  Find $P(X + Y <= 3)$.

  #solution[
    The viable $X$ are $1, 2, 3$.
    $
      X + Y <= 3 implies & cases(
                             X = & 1 and Y <= & 2,
                             X = & 2 and Y <= & 1,
                             X = & 3 and Y = & 0
                           ) \
         P(X + Y <= 3) = & P(X = 1) P(Y <= 2) + P(X = 2) + P(Y <= 1) + P(X = 3) P(Y = 0) \
                       = & 1 / 6 times (1 + 1 / 2 + 0) \
                       = & 1 / 4.
    $

    #note-box[
      It looks like we did not count the probability of $Y = 0$, which can totally happen.
      However, the result is correct.
    ]
  ]
]

#problem[
  Let $U follows Unif[0, 1], X := ln (1 / U)$.

  + Express $F_X (x) := P(X <= x)$.

    #solution[
      When $x >= 0$,
      $
        F_X (x) = & 1 - P(X > x) \
                = & 1 - P(ln(1 / U) > x) \
                = & 1 - P(1 / U > e^x) \
                = & 1 - P(U < e^(-x)) \
                = & 1 - e^(-x).
      $
      When $x < 0$, $F_X (x) = 0$.

      $
        F_X (x) = & cases(
                      1 - e^(-x) quad & x >= 0,
                      0 & x < 0
                    ).
      $
    ]

  + Find the PDF of $X$.

    #solution[
      The PDF is the derivative of $F_X$:
      $
        f_X (x) = & cases(
                      e^(-x) quad & x >= 0,
                      0 & x < 0
                    ).
      $
    ]
]

What is $F_X$ in the problem?

== Cumulative Distribution
#definition(title: [Cumulative Distribution Function (CDF)])[
  The cumulative distribution function, $F(x)$, of a random variable $X$, is defined as
  $
    F(s) := P(X <= s) quad s in RR.
  $

  Notably, $forall s in RR$,
  $
     F(s) <= & 1 \
    F'(s) >= & 0.
  $
]

#example[
  Given random variable $X follows Unif[0, 1]$,
  $
    F_X (s) = & cases(
                  0 quad & s < 0,
                  s & s in [0, 1],
                  1 & s > 1
                ).
  $
]

Obviously, CDF of a non-discrete continuous random variable is the integral of its PDF over $(-oo, s]$.
However, CDF also exists for discrete random variables.

= Expectation
#definition(title: [Expectation])[
  The expectation, the mean value of a random variable $X$ is
  $
    EE X := sum_k k P(X = k) = sum_(omega in Omega) X(omega) P(omega)
  $
  when $X$ is discrete;
  $
    EE X := integral_(-oo)^(oo) x f_X (x) dd(x)
  $
  when $X$ is continuous.
]

#example[
  The expectation of a dice roll is
  $
    EE X = & sum_(k = 1)^6 1 / 6 k \
         = & 21 / 6.
  $
]

/ Bernoulli:
  $
    EE X follows Bern(p) = & p dot 1 + (1 - p) dot 0 \
                         = & p.
  $

/ Binomial:
  $
    EE X follows Bin(n, p) = & sum_(k = 1)^oo P(X >= k)               && X "is discrete non-negative integer" \
                      "or" = & integral_(0)^(oo) P(X >= x) dd(x) quad && X "is continuous".
  $

/ Geometric:
  $
    EE X follows Geom(k, p) = & sum_(k = 1)^oo k (1 - p)^(k - 1) p \
                            = & p sum_(k = 1)^oo dv(, p) [-(1 - p)^k] \
                            = & -p dv(, p) sum_(k = 0)^oo (1 - p)^k \
                            = & -p dv(, p) 1 / p \
                            = & 1 / p.
  $

/ Uniform:
  $
    EE X follows Unif[a, b] = & integral_(a)^(b) 1 / (b - a) x dd(x) \
                            = & (b + a) / 2.
  $

If given specific PDF, we can solve for expectation using its definition.

#example[
  / PDF of $e^(-x)$:
    $
      f_X (x) = & cases(
                    e^(-x) quad & x >= 0,
                    0 & x < 0
                  ); \
         EE X = & integral_(0)^(oo) P(X >= x) dd(x) \
              = & integral_(0)^(oo) e^(-x) dd(x) \
              = & 1.
    $

  / PDF of $1 / x^2$:
    $
      f_X (x) = & cases(
                    1 / x^2 quad & x >= 1,
                    0 & x < 1
                  ) \
         EE X = & integral_(1)^(oo) 1 / x^2 x dd(x) \
              = & [ln(x)]_1^oo \
              = & oo.
    $
    #note-box[
      Expectation can be infinity.
    ]

  / PDF of $1 / (2 x^2)$ as an even function:
    $
      f_X (x) = & cases(
                    1 / (2 x^2) quad & abs(x) >= 1,
                    0 & -1 < x < 1
                  ) \
         EE X = & integral_(-oo)^(-1) 1 / (2x) dd(x) + integral_(1)^(oo) 1 / (2x) dd(x) \
              = & -oo + oo \
      therefore & "DNE".
    $
]

/ PDF of an odd function $g(x)$ such that $integral_(-oo)^(oo) abs(g(x)) dd(x) < oo$:
  $
    EE X = & 0.
  $

When checking for definition of PDF for $f(x)$, if it is hard to check for the integral $A$ itself, we can check for
$
  A^2 = & 1
$
along with $f(x) >= 0$ for all $x$.

Using Fubini's Theorem,
$
  A^2 = & integral_(-oo)^(oo) f(x) dd(x) integral_(-oo)^(oo) f(y) dd(y) \
      = & integral_(-oo)^(oo) integral_(-oo)^(oo) f(x) f(y) dd(x, y)
$
which might be easier to solve.

Just like in MATH 253, we may want to convert the integrals to polar coordinate form when encountering $x^2 + y^2$ patterns.
$
               dd(x, y) = & r dd(r, theta) \
    r : (-oo, oo) implies & [0, oo] \
  theta : [0, oo) implies & [0, 2pi].
$

#theorem(title: [Linearity of Expectation])[
  $
    EE [X_1 + X+2 + X_3 + ... + X_n] = & EE X_1 + EE X_2 + EE X_3 + ... + EE X_n \
                        EE [a X + b] = & a EE [X] + b
  $
  where $a, b in RR$, and $EE X_i$ can be _dependent_ of each other.
]

#example[
  Given
  $
    X follows & Bin(n, p).
  $
  Let $X_i follows Bern(p)$ be independent identical experiments of $X$.
  $
    EE X = & EE sum_(k = 1)^n X_i ] \
         = & sum_(k = 1)^n EE X_i \
         = & sum_(k = 1)^n p \
         = & n p.
  $
]

#problem(title: [The Birthday Problem])[
  Let $X$ be the number of students who share a birthday with at least one other classmate in a class with $n$ students.
  Give $EE X$.

  #solution[
    Number each student with an increasing ID from 1.
    Let $A_j$ be the event that student $j$ shares their birthday with at least one other student.
    Let $X_j$ be the indicator of $A_j$, and $p = P(A_1)$, so
    $
           X = & sum_(j = 1)^n X_j \
      P(A_j) = & p.
    $

    Despite that $A_j$ are not independent of each other, linearity of expectation applies.
    $
      EE X = & EE sum_(j = 1)^n X_j \
           = & n p \
         p = & 1 - P(A_1^c) \
           = & 1 - (365 times 364^(n - 1)) / 365^n \
           = & 1 - (364 / 365)^(n - 1).
    $
  ]
]

#theorem(title: [Law of the Unconscious Statistician (LOTUS)])[
  Given random variable $X$ which is contained in a real-valued domain of $g(x)$,
  $
    EE g(X) := & cases(
                   sum_k g(k) p_X (k) & X "is discrete",
                   integral_(-oo)^(oo) g(x) f_X (x) dd(x) quad & X "is continuous"
                 ).
  $

  Note that
  $
    EE g(X) equiv.not & g(EE X).
  $
]

#problem[
  Given $X follows Geom(1/2)$ is the chance we double or nothing, starting with \$1.
  Let $Y = 2^(X - 1)$ be the amount we gain.
  Given $EE Y$.

  #solution[
    Using LOTUS, $Y = g(X), g(k) = 2^(k - 1)$.
    $
      EE Y = & EE 2^(X - 1) \
           = & sum_(k = 1)^oo g(k) P(X = k) \
           = & sum_(k = 1)^oo 2^(k - 1) dot (1 / 2)^(k - 1) dot 1 / 2 \
           = & sum_(k = 1)^oo 1 / 2 \
           = & oo.
    $

    Notice that we should not expect this outcome in real life.
  ]
]

== Moments of a Random Variable
#definition(title: [Moment])[
  Given a random variable $X$, the $n^"th"$ moment of $X$ is $EE X^n$.
]

#example[
  The $n^"th"$ moment of $X follows Unif[0, 1]$ is
  $
    EE X^n = & integral_(-oo)^(oo) x^n f(x) dd(x) \
           = & integral_(0)^(1) x^n dd(x) \
           = & 1 / (n + 1).
  $
]

#theorem[
  Given random variable $X$.

  - If its PDF is an even function such that
    $
      EE abs(X)^(2n + 1) = & integral_(-oo)^(oo) abs(x)^(2n + 1) f(x) dd(x) \
                         = & 2 integral_(0)^(oo) x^(2n + 1) f(x) dd(x) \
                         < & oo
    $
    where $n in ZZ$, then
    $
      EE X^(2n + 1) = 0
    $
    since the integrand will be $"even" times "odd" implies "odd"$.

  - If its PDF is an odd function such that $EE abs(f(x)) < oo$, then
    $
      EE f(X) = & 0.
    $
]

== Variance
#definition(title: [Variance])[
  Given random variable $X$ with expectation $mu$,

  $
    Var(X) := & EE (X - mu)^2 \
            = & EE X^2 - (EE X)^2. quad ("LOTUS")
  $
]

#example[
  $
    Var(X follows Unif[-1000, 1000]) = & EE (X - 0)^2 \
                                     = & integral_(-oo)^(oo) x^2 f_X (x) dd(x) \
                                       & "where" f_X = 1 / 2000 dot 1_{x in [-1000, 1000]} \
                                     = & 1 / 2000 integral_(-1000)^(1000) x^2 dd(x) \
                                     = & 1000^2 / 3. \
          Var(Y follows Unif[-1, 1]) = & EE (Y - 0)^2 \
                                     = & integral_(-oo)^(oo) y^2 f_Y (y) dd(y) \
                                       & "where" f_Y = 1 / 2 dot 1_{y in [-1, 1]} \
                                     = & 1 / 2 integral_(-1)^(1) y^2 dd(y) \
                                     = & 1 / 3.
  $

  #theorem[
    If $Y follows Unif[-1, 1]$, then
    $
      forall a > 0, b in RR, (a Y + b) follows Unif[-a + b, a + b].
    $
  ]

  In this example,
  $
      1000 Y eq^d & X \
    Var(1000 Y) = & EE (1000 Y - EE 1000 Y)^2 \
                = & EE 1000^2 Y^2 \
                = & 1000^2 EE Y^2.
  $
]

#theorem(title: [Linearity of Variance Under Pairwise Independence])[
  Given independent random variables $X, Y$,
  $
    Var(X + Y) = & Var(X) + Var(Y).
  $
  This can be proven using (when independent)
  $
    EE (X + Y) = & EE X dot EE Y
  $
  and the LOTUS definition of variance.

  Plus,
  $
    Var (X_1 + X+2 + X_3 + ... + X_n) = & Var X_1 + Var X_2 + Var X_3 + ... + Var X_n.
  $
  where $a, b in RR$, and $X_i$ must be _pairwise independent_ of each other.
]

/ Bernoulli:
  $
    Var(X follows Bern(p)) = & p - p^2 \
                           = & p (1 - p).
  $

/ Binomial:
  Using the linearity of variance under pairwise independence,
  $
    Var(X follows Bin(n, p)) = & n p (1 - p).
  $

/ Geometric:
  $
    Var(X follows Geom(p)) = & (1 - p) / p^2.
  $
  (Proof omitted)

#theorem(title: [Sum of Dependent Indicators])[
  Given events $A_1, A_2, ... A_n$ and their indicators $X_1, X_2, ... X_n$.
  $
    Var(X) = & EE(X) - EE(X)^2 + 2 sum_(1 <= i < j <= n)^n P(A_i inter A_j).
  $

  Furthermore, if
  $
        forall 1 <= j <= n, & p := P(A_1) = P(A_j) \
    forall 1 <= i < j <= n, & q := P(A_1 inter A_2) = P(A_i inter A_j),
  $
  then
  $
    Var(X) = & n p - n^2 p^2 - n (n - 1) q.
  $
]

#problem[
  Let $X$ be the number of students in a class of $n$ students who share their birthday with other students.
  Let $A_i$ be the events that student $i$ does not share their birthday with any other student.

  Give the expectation and variance of $Y = sum_(j = 1)^n 1_A_j$.

  #solution[
    By symmetry,
    $
                            p := P(A_j) = P(A_1) = & (365 dot 364^(n - 1)) / 365^n \
                                                 = & (364 / 365)^(n - 1); \
                           q := P(A_j inter A_k) = & P(A_1 inter A_2) \
                                                 = & (365 dot 364 dot 363^(n - 2)) / 365^n \
                                                 = & 364 / 365 dot (363 / 365)^(n - 2). \
                                           EE(Y) = & EE sum_(k = 1)^n 1_A_k \
                                                 = & sum_(k = 1)^n EE(1_A_k) \
                                                 = & sum_(k = 1)^n P(A_k) \
                                                 = & sum_(k = 1)^n p \
                                                 = & n p; \
      2 sum_(1 <= j < k <= n)^n P(A_j inter A_k) = & 2q dot ((1 + n - 1) (n - 1)) / 2 \
                                                 = & q n (n - 1) \
                                 Var(Y) = Var(X) = & EE(Y) - EE(Y)^2 + q n (n - 1).
    $
  ]
]

#theorem[
  Given random variable $X$ and $a, b in RR$,
  $
    Var(a X + b) = & a^2 Var(X).
  $
]

== Gaussian Distribution
#definition(title: [Gaussian/Normal Distribution])[
  A random variable $X$ has the _standard_ Gaussian distribution if it has the PDF of
  $
    f_X = phi(x) = & 1 / sqrt(2 pi) e^(- x^2 / 2),
  $
  denoted $X follows N(0, 1)$.

  Note that
  $
    integral_(-oo)^(oo) e^(- x^2 / 2) = & sqrt(2 pi) \
                         F_X = Phi(x) = & 1 / sqrt(2 pi) integral_(-oo)^(x) e^(- s^2 / 2) dd(s) \
                               phi(a) = & phi(-a) \
                               Phi(a) = & 1 - Phi(-a).
  $

  A random variable $Y = sigma X + mu$ has the _general_ Gaussian distribution, it has the PDF and CDF of
  $
    f_Y = & 1 / sigma f_X ((y - mu) / sigma) \
        = & 1 / sqrt(2 pi sigma^2) e^(- (y - mu)^2 / (2 sigma^2)), \
    F_Y = & sigma Phi((y - mu) / sigma).
  $
  denoted $Y follows N(mu, sigma^2) = N(EE(Y), Var(Y))$.

  Note that
  $
    (Y - mu) / sigma follows N(0, 1).
  $
]

#theorem[
  Given $X follows N(0, 1)$.
  $
     EE(X) = & 0 \
    Var(X) = & 1.
  $
]

#theorem[
  If $X follows N(mu, sigma^2)$ and $Y = a X + b$, then
  $
    Y follows N(a mu + b, a^2 sigma^2)
  $
]

== Law of Large Numbers and Central Limit Theorem for Binomial Distribution
Given random variable $S_n follows Bin(n, p)$, $EE(S_n) = n p, Var(S_n) = n p (1 - p)$.

#theorem(title: [Law of Large Numbers])[
  Given a random variable $S_n follows Bin(n, p)$,
  $
    forall epsilon > 0, lim_(n -> oo) P(abs(S_n / n - p) < epsilon) = 1,
  $
  meaning that for larger $n$, $S_n$ is less likely to deviate from $EE(S_n)$ (even if $EE(S_x) = plus.minus oo$).

  #proof[
    // TODO future lecture
  ]
]


#theorem(title: [Central Limit Theorem])[
  Given a random variable $S_n follows Bin(n, p)$, standardize it to be
  $
                       Q_n := & (S_n - EE(S_n)) / sqrt(Var(S_n)) \
                            = & (S_n - n mu) / sqrt(n sigma^2) \
    lim_(n -> oo) Q_n follows & N(0, 1);
  $
  then,
  $
    forall a < b, lim_(n -> oo) P(Q_n in [a, b]) = & P(N(0, 1) in [a, b]),
  $
  meaning that for all $a < b$, $lim_(n -> oo) P(Q_n in [a, b]) = Phi(b) - Phi(a)$.

  The approximation is accurate enough when $n p (1 - p) > 10$.
]

#problem[
  Flipping a coin for 10000 times, let $S_n$ be the number of heads.
  Give $P(S_n in [4850, 5100])$.

  #solution[
    $
        S_n follows & Bin(n, p) \
                n = & 10000 \
                p = & 1 / 2 \
              n p = & 5000 \
      n p (1 - p) = & 2500 >> 10.
    $
    Therefore, we approximate that
    $
                        Q_n follows & N(n p, n p (1 - p)) \
                                  = & N(5000, 2500) \
                                  = & N(5000, 50^2) \
                                  = & mu + sigma Z follows N(0, 1) \
                         S_n approx & 5000 + 50 Z \
      P(S_n in [4850, 5100]) approx & P(5000 + 50 Z in [4850, 5100]) \
                                  = & P(50 Z in [-150, 100]) \
                                  = & P(Z in [-3, 2]) \
                                  = & Phi(2) - Phi(-3).
    $
  ]
]

#problem(title: [One-dimension Random Walk])[
  Given a random walker on a line that moves $plus.minus 1$ per step, with equal chance of either value.
  Give its displacement after $n$ steps.

  #solution[
    Let $Y_i$ be result of the $i"th"$ coin flip, $X_i$ be the result of the $i"th"$ random walk.
    $
      X_i = & 2 Y_i - 1.
    $
    // TODO
  ]
]
