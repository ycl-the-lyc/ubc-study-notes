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
  $xor$, $#math.xor$, [Exclusive or],
  $neg$, $not quad excl$, [Not],
  $->$, $$, [Tends to],
  $implies$, $$, [Implies],
  $<=$, $$, [Implies (reversed)],
  $iff$, $"iff"$, [If and only if],
  $forall$, $$, [For all, for any],
  $exists$, $$, [There exists],
  $suchthat$, $$, [Such that],
))

= Set
#definition(title: [Set])[
  A collection of objects.
  The objects are referred to as elements or members of the set.

  Ordering of a set and occurrences of its elements are trivial.
]

#example(title: [Building sets])[
  - $Set(n^2, n in ZZ) = {0, 1, 4, 9, 16, ...}$
  - $Set(x in RR, x^2 - 2 = 0) = {-sqrt(2), +sqrt(2)}$
  - $Set(x in ZZ, x^2 - 2 = 0) = nothing$
  - $Set(x^2, x in (-3, 1]) = [0, 9)$
  - $A = Set(1 / n, n in NN), B = Set(x in A, x < 1 / (2 pi)) -> B = {1 / 7, 1 / 8, 1 / 9, ...}$
]

#example(title: [Building more sets])[
  Let $A = {..., -8, -4, 0, 4, 8, ...}, B = {..., -6, -3, 0, 3, 6, ...}$.
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

#definition(title: [Cardinality of Set])[
  For a set $S$, cardinality is the number of elements in it, $abs(S)$, even when they cannot be definitely counted.
]


#theorem(title: [Set Equality])[
  For sets $S, T$,
  $
    S = T iff (S subset T) and (T subset S)
  $

  #example[
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

#theorem(title: [Bézout's Identity])[
  Let $a$ and $b$ be integers with greatest common divisor $d$. Then there exist integers $x$ and $y$ such that $a x + b y = d$. Moreover, the integers of the form $a z + b t$ are exactly the multiples of $d$.
]

= Logic

#definition(title: [Statement])[
  A claim that is either true false, and there is only once case which it is true.
]

#definition(title: [Open Sentence])[
  A sentence whose truth value depends on the variable(s) that it contains.
]

Statements and open sentences are mutually exclusive, since statements have defined truth value, while open sentences have variables not _clearly_ defined, thus have no clearly defined truth cases.

To think of them mathematically, a statement is a variable, an open sentence is a function.

#definition(title: [Implication])[
  For statements $P$ and $Q$, if $P$ implied $A$, $P implies Q$, then if $P$ is true, $Q$ must be true.
  _An implication is true unless proven false._

  #table(
    columns: 3,
    table.header($P$, $Q$, $P implies Q$),
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
+ show that $P: T implies Q: F$ cannot happen.
Since the implication _cannot be false_, it must be true.

== Parity and Divisibility

#definition(title: [Parity])[
  A number $n$ is even if $n = 2k$ for some integer $k$.

  A number $n$ is odd if $n = j + 1$ for some integer $j$.
]

To prove parity,
+ substitute variable with the definition of even/odd number;
+ factor expression, most likely with $2$ since it is the coefficient in the definitions;
+ find definition of even/odd number, $2("some integer") "or" 2("some integer") + 1$.

#note-box[
  Proving divisibility involves similar steps.
  We generally use Euclidean division with remainder to prove if something is divisible or not.
  Fractions are not used.
]

Here, we introduce a crucial proof procedure: starting with assumptions, not the hypothesised implication.
#proof[
  Let $x in RR$. Prove that if $x > 0$, then $x + 2 / x > 2$.

  Multiply all terms by $x$, signs are unchanged since $x > 0$; move all terms to LHS.
  $
        x + 2 / x & >2 \
     x^2 - 2x + 2 & > 0 \
    (x - 1)^2 + 1 & > 0.
  $
  We can prove that the LHS function is continuous and has a minimum value of 1, but we _cannot start with the answer!_

  To start with the conditions, which is logical, we assume $x in RR, x > 0$.
  Note that
  $
                (x - 1)^2 & >= 0 \
    implies (x - 1)^2 + 1 & > 0 \
     implies x^2 - 2x + 2 & > 0 \
    implies x^2 + 2 > 2x.
  $
  we divide all terms by $x$, with $x > 0$ all signs is unchanged,
  $
    x + 2 / x > 2.
  $
]

#lemma(title: [Contrapositive])[
  The contrapositive of $P implies Q$ is
  $
    (neg Q) implies (neg P).
  $
  The contrapositive is _logically_ equivalent to the original statement.
]

Note that $(P implies Q) implies.not (neg P implies neg Q)$, as $P implies Q$ does not require $P$ to be true.

#lemma(title: [Converse])[
  The converse of $P implies Q$ is
  $
    Q implies P
  $
  which may not be true.
]

#lemma(title: [DeMorgan's Laws])[
  $
     neg (P or Q) & equiv (neg P) and (neg Q) \
    neg (P and Q) & equiv (neg P) or (neg Q)
  $
]

#lemma(title: [Implication])[
  $
    (P implies Q) equiv (neg P) or Q
  $
]

#lemma(title: [Bicondition])[
  $
    (P <implies Q) equiv (P implies Q) and (Q implies P)
  $
]

#lemma(title: [Exclusive Or])[
  $ (P xor Q) equiv (P and neg Q) or (neg P and Q) $
]

#example[
  Using all four lemmas: implication, bicondition, DeMorgan's Laws and exclusive or,
  $
        (P <implies Q) & equiv (P implies Q) and (Q implies P) \
    neg (P <implies Q) & equiv neg ((P implies Q) and (Q implies P)) \
                       & equiv neg (P implies Q) or neg (Q implies P) \
                       & equiv neg (neg P or Q) or neg (neg Q or P) \
                       & equiv (P and neg Q) or (Q and neg P) \
                       & equiv (P and neg Q) or (neg P and Q) \
                       & equiv P xor Q
  $
]

== Modular Arithmetic

#definition(title: [Congruent and modulus])[
  Let $a, b in ZZ$ and $n in NN$, $a$ is congruent to $b$ modulo $n$ when $n divides (a - b)$.
  The $n$ is referred to as the modulus.
  $ a equiv b modulo(n) $
  If not, then $a$ is not congruent to $b$ modulo $n$, $a equiv.not b modulo(n)$
]

Or to put it simply, a smaller number that yields the same reminder to the modulus.

#theorem(title: [Modular Arithmetic])[
  Let $n in NN, a, b, c, d in ZZ$ such that
  $ a equiv c modulo(n) quad "and" quad b equiv d modulo(n). $
  Then,
  $ a + b equiv c + d modulo(n), quad a - b equiv c - d modulo(n), quad a b equiv c d modulo(n) $
]

Division modular arithmetic is avoided in this course.

#example[
  $
    12 times 108 & equiv ? modulo(5) \
              12 & equiv 2 modulo(5) \
             108 & equiv 3 modulo(5) \
    12 times 108 & equiv 2 times 3 equiv 6 equiv 1 modulo(5)
  $
]

To proof congruency, we should factor out the modulus to show that $n divides a - b$.

#proof[
  Let $n in ZZ$, then $n equiv 3 modulo(5) iff 5 divides (3n + 1)$.

  By definition, from the LHS there exists some integer $k$ that
  $
         n & = 3 + 5k \
        3n & = 9 + 15k \
    3n + 1 & = 10 + 15k \
           & = 5 (2 + 3k).
  $
  Since $2 + 3k & in ZZ$, $5 & divides 3n + 1$.
  Thus, $n equiv 3 modulo(5) implies 5 divides (3n + 1)$

  On the RHS, $15 divides 9n + 3$, so there exists some integer $l$ that
  $
             9n + 3 & = 15l \
      (10n - n) + 3 & = 15l \
      10n - 15l + 3 & = n \
    3 + 5 (2n - 3l) & = n.
  $
  Since $2n - 3l in ZZ$, $5 divides n - 3$.
  Thus, $5 divides (3n + 1) implies n equiv 3 modulo(5)$.

  Therefore, $n equiv 3 modulo(5) iff 5 divides (3n + 1)$.
]

== Quantifiers
To prove "there exists", we only have to come up with one case that satisfy the requirements.
To disprove "for all", we only have to come up with one case that does not satisfy the requirements.

#example[
  $forall m in ZZ, exists n in ZZ suchthat m^2 < n$.
  #proof[
    Given $m in ZZ$, let $n = m^2 + 1$.
    Note that $m^2 + 1 in ZZ$.
    Then, $m^2 < m^2 + 1 = n$.
  ]
]

=== Negation with Quantifiers
#theorem[
  Let $P(x)$ be an open sentence over the domain $A$, then
  $
            neg (forall x in A, P(x)) quad & equiv quad exists x in A suchthat neg P(x) \
    neg (exists x in A suchthat P(x)) quad & equiv quad forall x in A, neg P(x)
  $
]
Note that the comma and #suchthat are used based on English grammar alone.

We find that the negation is simialr to how we disprove the same sentences.

== Limits for Sentences
#definition[
  Let $(x_n)$ be a sequence of real numbers.
  We say that $(x_n)$ has a limit $L in RR$ when
  $
    forall epsilon > 0, exists N in NN suchthat forall n > N, abs(x_n - L) < epsilon
  $
]

When sequence elements are getting smaller and smaller, we typically let $N$ be a value that depends on $epsilon$.

== Limits for Functions
#definition[
  Let $a, L in RR "and" f: x mapsto RR$. We say that the limit of $f$ as $x$ approaches $a$ is $L$ when
  $ forall epsilon.alt > 0, exists delta > 0 suchthat (0 < abs(x - a) < delta) implies (abs(f(x) - L) < epsilon.alt) $ where $epsilon.alt, delta in RR$.
  In this case,
  $
    lim_(x -> a) f(x) = L "or" f(x) -> L "as" x -> a.
  $
  And we say $f$ convergese to $L$ as $x -> a$.
  Otherwise, we say $f$ diverges as $x -> a$.
]

By boxing the function domain and range, we make sure that the function is smooth around the limit.
Hence, we often make $delta$ depend on $epsilon$.

== Induction
+ Show that all base cases $k$ (starting points) holds.
+ Show that the statement holds for $n = k_"next"$.

To prove in scope of $ZZ$, the $n = k - 1$ case needs to be separately induced.

This course does not cover induction on other domains.

#example[
  Let $n in NN$.
  Prove that $forall n >= 7, n! > 3^n$.
  ($7! = 5040, 3^7 = 2187$.)

  For $n = 7$,
  $
    n! > 3^n.
  $
  For $n = k$ for some integer $k$,
  $
    (k + 1)! & = (k + 1) (k)! \
             & > (k + 1) 3^k \
             & > 3 (3^k) \
             & = 3^(k + 1).
  $
  By induction, $forall n in NN "and" n >= 7, n! > 3^n$.
]

#definition(title: [Strong Induction])[
  For series $(a_n)$, fix $j, k in NN, j < k$ such that $forall m in NN "and" j <= m <= k, a_m$.
]

= Set Theory
#definition(title: [Power Set])[
  Let $S$ be any set.
  The power set $pws(S)$ of $S$ is the set of all subsets of $S$, including $S$ and $emptyset$.
]

#important-box[
  All subsets of $S$ is not the same as all elements of $S$.
  Make sure to put every combination in a set when constructing power sets.
]

For every element, it can be present or absent in any subset.
Hence, the size of the power set of a set with size $n$ is $n^2$.
In other words, for set $T$,
$
  abs(pws(T)) = abs(T)^2.
$

== Set Arithmetic
Let $A, B$ be any two sets.
$
  A union B & = Set(x, x in A or x in B) \
      A - B & = Set(x, x in A, x in.not B) \
  A inter B & = Set(x, x in A, x in B) \
  A times B & = Set((x, y), x in A, y in B)
$

The $times$ for sets is called the Cartesian product.

#definition(title: [Relation])[
  Let $A$ be a set, a relation $R$ on $A$ is a subset of $A times A$.
  $
    R subset.eq A times A.
  $
  If $(x, y) in R$ we write $x R y$, otherwise $x R.not y$.
]


