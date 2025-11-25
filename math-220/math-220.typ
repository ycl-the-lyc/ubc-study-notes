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
  $[a]$, $$, [Collection of $a$],
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
] <th:bezouts>

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

== Set Proofs
Proofs involving sets can require us to interpret -- to rewrite the sets so they can be used with respect to what we wish to proof.

=== Subset and Equality
If an element is in a set, which set is a subset of another set, than the element is also in the master set.
$
  A subset.eq B & equiv forall x in A, x in B           & equiv x in A implies x in B \
          A = B & equiv A subset.eq B and B subset.eq A &     equiv x in A iff x in B
$

=== Intersection and Union
$
  x in A inter B & equiv x in A and x in B \
  x in A union B & equiv x in A or x in B
$

=== Complement and Difference
$
  x in overline(A) & equiv x in.not A \
        x in A - B & equiv x in A and x in.not B
$

== Relations

#definition(title: [Relation])[
  Let $A$ be a set, a relation $R$ on $A$ is a subset of $A times A$.
  $
    R subset.eq A times A.
  $
  If $(x, y) in R$ we write $x R y$, otherwise $x cancel(R) y$.

  $emptyset$ is a trivial relation on $A$, and $S = A times A$ is the universal relation on $A$.
]

A trivial or universal relation is not useful to us, we are more interested in some special ones.

#definition(title: [Special Relation Properties])[
  Let $R$ be a relation on set $A$, then $R$ is...
  - reflexive when $forall a in A, a R a$.
  - symmetric when $forall a, b, a R b implies b R a$.
  - transitive when $forall a, b, c, a R b and b R c implies a R c$.
]

For example, the congruency relation has all three properties, which makes it a...

=== Equivalence Relation
#definition(title: [Equivalence Relation])[
  Let $R$ be a relation on $A$, then $R$ is an equivalence relation when it is reflexive, symmetric and transitive, with the three properties ordered by strictness.
]

When proving an equivalence relation, we must prove all three spacial properties.

The smallest possible equivalence relation whould be $R: a = b$.
We first prove that it is reflexive, than show that it satisfies the other two.
Since every other possible equivalence relation must contain such relation, it is the smallest.

#example[
  Prove that $R$ on $ZZ$ defined by $a R b$ if $7a^2 equiv 2b^2 modulo(5)$ is an equivalent relation.

  #solution[
    - Reflexiveness: For any integer $a$, $7a^2 = 5a^2 + 2a^2$,
    $
      7a^2 & equiv 5a^2 modulo(5) + 2a^2 modulo(5) \
           & equiv 0 + 2a^2 modulo(5).
    $
    - Symmetry: For integers $a, b$, if $2a^2 equiv 2b^2 modulo(5)$, then $2b^2 equiv 2a^2 modulo(5)$.
    - Transitivity: If $2a^2 equiv 2b^2 modulo(5), 2b^2 equiv 2c^2 modulo(5)$, then $2a^2 equiv 2c^2 modulo(5)$.
  ]

  There are alternative proofs using divisibility.
]

The smallest size of an equivalence relation is the size of the set it is on.

=== Equivalenec Classes
#definition(title: [Equivalence Class])[
  Let $R$ be an equivalence relation on $A$.
  The equivalence class of $x in A$ with respect to $R$ is
  $
    [x] = Set(a in A, a R x).
  $
  It contains all elements related to $x$ under that relation.

  No equivalence class is empty, for any $a in A, a in [a]$.
]

#example[
  Using the previous example, find the equivalence class $[0]$.

  #solution[
    By definition, $[0] = Set(y in A, 0 R y)$.
    We need $y$ where
    $
                7 dot 0^2 & equiv 2 y^2 modulo(5) \
                        5 & divides 2 y^2 \
      cancel(5 divides 2) & or 5 divides y^2 \
              5 divides y & or 5 divides y.
    $
    $y & := 5k$ for some integer $k$.
    Hence, $[0] = Set(5k, k in ZZ)$.
  ]
]

#example[
  Again, determine $[1]$.

  #solution[
    By definition, $[1] = Set(y in A, 1 R y)$.
    We need $y$ where
    $
                7 dot 1^2 & equiv 2 y^2 modulo(5) \
                        5 & divides (2y^2 - 2) \
      cancel(5 divides 2) & or 5 divides (y^2 - 1) \
        5 divides (y + 1) & or 5 divides (y - 1) \
              y := 5k - 1 & or y := 5k + 1.
    $
    Hence, $[1] = Set(5k + 1, k in ZZ) union Set(5k - 1, k in ZZ)$.
  ]
]

=== Relation Partitions
A set can be partitioned to equivalence classes.
$
  A = [a] union [b] union [c] ...
$

#definition(title: [Partition])[
  A partition of a set $A$ is a collection $part$ of non-empty _subsets_ of $A$, so that
  - there is no overlap: if sets $X, Y in part$, then $X inter Y = emptyset or X = Y$;
  - it has full coverage: if $x in A$, then $exists X in part suchthat x in X$.
]

#note-box[
  The meaning of $cal(P)$ changes in contexts.
  Used as a function of a set, it means power set.
  Used as a collection, it means partition.

  One thing in common is that they are all collection of subsets.
]

In this course, a collection can be viewed as a set, though it may not be accurate.

An equivalence relation effectively partitions a set.
Hence, for each equivalence relation, there are partiions for every set of related elements.

In fact, given the properties of a partition, for each partition, there is an equivalence relation for the set.

#proof[
  Given a partition $part$ of set $A$, define a relation $R: x, y in S$ for some $S in part$.

  - For $x in S, x in S$. The relation is reflexive.
  - Since there is no overlap between subsets of $part$, $x, y in "and only" in S$. The relation is symmetric.
  - For the same reason, for $x, y in S$, $y, z in S$, $x, y, z in "and only" in S$. The relation is transitive.

  - $forall a in A, s in S in part$. $a$ and itself are in the same set.
    The relation is _reflexive._
  - $a R b implies a, b in S in part$.
    Hence, $b, a in S, b R a$.
    The relation is _symmetric._
  - Assume $a R b, b R c$. $exists S, T in part suchthat a, b in S and b, c in T$.
    Since $b in S inter T$, $S inter T eq.not emptyset$, thus $S = T$.
    Then, $a, c in S, a R c$.
    The relation is transitive.

  $R$ is an equivalence relation on $A$.
]

We will find Bézout's Identity useful for equivalence relation related proofs that also involve congruency.

= Functions
#definition(title: [Function])[
  For sets $A, B$, a function $f$ from $A$ to $B$, written $f: A -> B$, is a subset of $A times B$ with two properties.
  - $forall a in A, exists b in B suchthat (a, b) in f$.
  - $(a, b) in f and (a, c) in f implies b = c$.
]

#definition(title: [Domain, Co-domain and Range])[
  In the previous example, we call $A$ _domain_, $B$ _co-domain_, and the set of elements of $B$ actually being mapped to by $f$ the _range_.
]

#definition(title: [Image and Preimage])[
  Let $f: A -> B$ be a function, and $C subset.eq A, D subset.eq B$.
  - The set $f(C) = Set(f(x), x in C)$ is the _image_ of $C$ in $B$.
  - The set $f^(-1)(D) = Set(x in A, f(x) in D)$ is the _preimage_ of $D$ in $A$.

  When applying a function to a set, we yield a set as well.
]

#note-box[
  A preimage is not necessarily an inverse function; some functions are not invertible.
  If an image has multiple elements mapping to less elements, the preimage would "grow" in size, violating the function definition.
]

#example[
  Suppose that $f: A -> B$ is a function and let $C$ be a subset of $A$.
  Prove that $f(A) - f(C) subset.eq f(A - C)$.

  #proof[
    Let $y in f(A) - f(C)$, we are to prove that $y in f(A - C)$.
    $
      y in f(A) and f in.not f(C) \
      forall y in f(A), exists x in A suchthat f(x) = y \
      forall y in.not f(C), exists.not z in C suchthat f(z) = y \
      x in A - C \
      therefore f(x) in f(A - C).
    $
    Since $f(x) = y$, $y in f(A - C)$.
    Thus, $f(A) - f(C) subset.eq f(A - C)$.
  ]

  The statement which the subset in the original statement is swapped with superset, is easily disproved by counterexample.
]

#definition(title: [Injectiveness])[
  Let $a_1, a_2 in A$ and let $f: A -> B$ be a function, we say that if $f$ is _injective_ (one-to-one) when
  $
    a_1 eq.not a_2 iff f(a_1) eq.not f(a_2).
  $
]
To prove injectiveness, we need to prove the preimage for any image has only one element.

#definition(title: [Surjectiveness])[
  Let $f: A -> B$ be a function, we say that $f$ is _surjective_ (onto) when for every $b in B$ there is some $a in A$ such that $f(a) = b$.
]

To prove surjectiveness, we only need to prove exisitence of a non-empty preimage.

== Compositions
#definition(title: [Composition])[
  Let $f: A -> B, g: B -> C$ be functions.
  The composition of $f$ and $g$, denoted $g compose f$, defines a new function
  $
    g compose f: A -> C quad (g compose f)(a) = g(f(a)) quad forall a in A.
  $
  Function composition is associative.
]

#theorem[
  Let $f: A -> B, g: B -> C$ be functions.
  - If $f, g$ are injective, so is $g compose f$.
  - If $f, g$ are surjective, so is $g compose f$.
]

This can be proven simply by definition of composition.

#theorem[
  Let $f: A -> B, g: B -> C$ be functions.
  - If $g compose f$ is injective, so is $f$.
  - If $g compose f$ are surjective, so is $g$.
]

Notice that only a part of the converse is true.
- $g compose f$ being injective only guarantees the range of $f$ on domain of $g$ leads to injectiveness.
- $g compose f$ being surjective only guarantees the range of $g$ on range of $f$ leads to surjectiveness.

== Inverses
#definition(title: [Inverses])[
  Let $f: A -> B, g: B -> A$ be functions, and $i_A, i_B$ be identity functions on $A, B$.
  - If $g compose f = i_A$, then $g$ is a left-inverse of $f$.
  - If $f compose g = i_B$, then $g$ is a right-inverse of $f$.
  If $g$ is both a left-inverse and a right-inverse of $f$, then $g$ is _the_ inverse of $f$.

  $f$ must be bijective to have a total inverse.
]

#example[
  Let $f: A -> B$ be a function.
  Prove that if there is a function $g: B -> A$ such that $g compose f(x) = x$, then for all $x in A$, $f$ is injective.

  #proof[
    Let $f(x_1) = f(x_2)$ for some $x_1, x_2 in A$.
    Apply $g$ to both sides,
    $
      g compose f(x_1) & = g compose f(x_2) \
                   x_1 & = x_2.
    $
    $f$ is injective by definition.
  ]
]


#example[
  Let $f: A -> B$ be a function.
  Prove that if $f$ is injective, then there is a function $g: B -> A$ such that $forall x in A, g compose f(x) = x$.

  #proof[
    Pick a function that for $b in B$.
    - If $b in "range"(f)$,
      $
        exists a in A suchthat f(a) = b.
      $
      Since $f$ is injective, $a_1, a_2 in A suchthat f(a_1) = f(a_2) implies a_1 = a_2$, $a$ is unique.
      Define $g(b) = a$.
    - If  $b in.not "range"(f)$, define $g(b) = c$ where $c in A$ is some constant.

    Since $f(x) in "range"(f)$, by definition, $g compose f(x) = x$; $g$ is an left-inverse of $f$.
  ]
]

#theorem[
  Let $f: A -> B$ be a function.
  $
    f "is injective" iff exists g: B -> A suchthat g compose f(x) = x.
  $
]

= Proof by Contradiction
If $S$ is true, then $neg S$ is false; vice versa.

#example[
  Prove that $sqrt(7)$ is irrational.

  #proof[
    Assume that $sqrt(7) in QQ$.
    $
      sqrt(7) & := a/b
    $
    where $a, b$ are some integers, $b eq.not 0$, and $markhl(gcd(a, b) = 1)$.
    $
          7 & = a^2 / b^2 \
      7 b^2 & = a^2 \
          7 & divides a^2.
    $
    $7$ is a prime number, thus
    $
      7 divides a^2 & implies 7 divides a or 7 divides a \
                  a & := 7k
    $
    for some integer $k$.
    $
      7b^2 & = (7k)^2 \
           & = 49k^2 \
       b^2 & := 7 j \
    $
    for some integer $j$.
    $
      7 & divides b^2 \
      7 & divides b.
    $
    This is a contradiction with $gcd(a, b) = 1$.

    Since $sqrt(7) in QQ xor sqrt(7) in II$, $sqrt(7) in II$.
  ]
]

#example[
  Let $x in RR$ satisfy $x^7 + 5x^2 - 3 = 0$.
  Prove that $x$ is irrational.

  #proof[
    Assume that $x in QQ$.
    $
      x & := a/b
    $
    for some $a, b in ZZ, b eq.not 0, gcd(a, b) = 1$.
    $
                   x^7 + 5x^2 - 3 & = (a/b)^7 + 5(a/b)^2 - 3 \
                                  & = 0 \
      a^7 / b^7 + 5 a^2 / b^2 - 3 & = 0 \
          a^7 + 5 a^2 b^5 - 3 b^7 & = 0
    $
    - If $a, b$ are odd.
      $
        a & := 2k + 1 \
        b & := 2j + 1
      $
      for $k, j in ZZ$.
      $
        (2k+1)^7 + 5 (2k+1)^2 (2j+1)^5 - 3 (2j+1)^7 & = 0.
      $
      Take modulo of $2$ on both sides.
      $
        1 + 5 - 3 = 0
      $
      Contradiction.
    - If $a$ is odd, $b$ is even...
      $
              ... & mod 2 \
        1 + 0 - 0 & = 0.
      $
      Contradiction.
    - If $a$ is even, $b$ is odd...
      $
              ... & mod 2 \
        0 + 0 - 3 & = 0.
      $
      Contradiction.

    $a, b$ cannot both be even, since $gcd(a, b) = 1$.

    Since $x in QQ xor x in II$, $x in II$.
  ]
]
