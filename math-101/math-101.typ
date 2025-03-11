#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    MATH 101 Study Notes
    #underline[Integral Calculus with Applications]
  ],
  author: "Yecheng Liang",
)

#import "@preview/equate:0.2.1": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#import "@preview/physica:0.9.4": *
#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

#let plot-defaults = (
  size: (8, 4),
  axis-style: "school-book",
  x-min: -1.2,
  x-max: 1.2,
  y-max: 1.2,
  x-tick-step: 1,
  y-tick-step: 1,
)

#let plot-conf(..args) = {
  (:..plot-defaults, ..args.named())
}

#let all-terms = state("terms", ())
#show terms.item: it => context {
  let loc = here()
  all-terms.update(c => c + ((it, loc),))
  it
}
#let termlist = [
  #pagebreak(weak: true)
  #heading(level: 1, numbering: none)[Definitions]
  #context terms(
    ..all-terms
      .final()
      .map(el => {
        terms.item(link(el.at(1), el.at(0).term), el.at(0).description)
      }),
    tight: false,
  )
]

= General Principles

== Special Cases
In this course,
- $log "is" ln$.

== Sigma Notation
$
  sum_(i=1)^n i
$
means 'the sum of $i$ from 1 to $n$, where $i$ is an integer'.

= Definite Integral
$
  integral_a^b f(x) dd(x)
$
means 'the integral of $f(x)$ from $a$ to $b$'.

#let ex-abs = x => calc.abs(x)
Take $f(x) = abs(x)$, its integral from $-1$ to $1$ is:
$
  integral_(-1)^1 abs(x) dd(x)
$
looks like:
#cetz.canvas({
  import cetz: *
  import cetz-plot: *

  plot.plot(
    ..plot-conf(),
    {
      plot.add(domain: (-1, 1), ex-abs, samples: 128)
      plot.add-fill-between(domain: (-1, 1), ex-abs, x => 0, style: (stroke: none))
    },
  )
})

== Estimation

Right Riemann Sum (RRS) is an estimation of the area under the curve using rectangles with the right endpoint as the height.

#let ex-sqrt = x => calc.sqrt(x)
For example,
$
  integral_0^8 sqrt(x) dd(x).
$
Using RRS with 4 rectangles, we have:
+ each rectangle has width $(8 - 0) / 4 = 2$,
+ the right endpoints are $2, 4, 6, 8$,
+ the heights are $sqrt(2), sqrt(4), sqrt(6), sqrt(8)$.

That gives us the estimation:
$
  sum_(i=1)^4 2 sqrt(2i) &= 2 sqrt(2) + 2 sqrt(4) + 2 sqrt(6) + 2 sqrt(8) \
  &approx 2.83 + 4 + 5.29 + 5.66 \
  &= 17.78.
$

#cetz.canvas({
  import cetz: *
  import cetz-plot: *

  plot.plot(
    ..plot-conf(size: (8, 6), x-min: 0, x-max: 8, y-max: 3, x-tick-step: 2),
    {
      for i in range(1, 5) {
        let x = 2 * i
        plot.add-bar(
          ((x, ex-sqrt(x)),),
          bar-position: "end",
          bar-width: 2,
          style: (stroke: white.transparentize(80%) + 2pt, fill: gray.transparentize(80%)),
        )
        plot.add(domain: (0, 8), ex-sqrt, samples: 128)
      }
    },
  )
})

Similarly, Left Riemann Sum (LRS), Midpoint Riemann Sum (MRS), and Trapezoidal Riemann Sum (TRS) exist.

The generalized formula with $n$ rectangles/trapeziums from $a$ to $b$ are:
$
  "RRS"(a, b, n) &= sum_(i=1)^n f(x_i) Delta x \
  "LRS"(a, b, n) &= sum_(i=1)^n f(x_(i-1)) Delta x \
  "MRS"(a, b, n) &= sum_(i=1)^n f((x_(i-1) + x_i) / 2) Delta x \
  "TRS"(a, b, n) &= sum_(i=1)^n (f(x_(i-1)) + f(x_i)) (Delta x) / 2,
$
where $Delta x = (b - a) / n$ and $x_i = a + i Delta x$.

For an increasing function ($f'(x) > 0$), RRS is an overestimation, and LRS is an underestimation.
For a function concave up ($f''(x) > 0$), TRS is an overestimation.

== Signed Area
If the 'area under the curve' is below the $x$-axis, it can be called 'negative'.
Hence, the integral of a function can be interpreted as the signed area of a curve, which can be positive or negative.

Say, if we have an odd function ($pi$ rotation symmetry about the origin), then its signed area/integral over a symmetric interval is 0.

== Precise Calculation
Using Riemann Sums, we can see that the more rectangles we use, the closer the estimation is to the actual value.

So, let's bust up $n$ to infinity:
$
  lim_(n -> oo) "RRS"(a, b, n) &= lim_(n -> oo) sum_(i=1)^n f(x_i) Delta x \
  &= "the actual signed area" \
  &= "wait isn't this the definition of the integral?" \
  &= integral_a^b f(x) dd(x).
$

= Fundamental Theorem of Calculus

== Part 1
The Fundamental Theorem of Calculus (FTC) states that the derivative of the integral of a function is the function itself.
$
  (integral_a^x f(t) dd(t))' = f(x).
$

== Integral Properties
Integral with range $a$ to $b$ is a linear operator:
$
  integral_a^b f(x) dd(x) &= -integral_b^a f(x) dd(x) \
  integral_a^b f(x) dd(x) &= integral_a^c f(x) dd(x) + integral_c^b f(x) dd(x).
$

Scaling and summing are also allowed:
$
  integral_a^b k f(x) dd(x) &= k integral_a^b f(x) dd(x) \
  integral_a^b (f(x) + g(x)) dd(x) &= integral_a^b f(x) dd(x) + integral_a^b g(x) dd(x).
$

However, the integral of a product is not the product of integrals:
$
  integral_a^b f(x) g(x) dd(x) &eq.not integral_a^b f(x) dd(x) integral_a^b g(x) dd(x),
$
nor can an integral 'scale' like a scalar:
$
  integral_a^b f(x) g(x) dd(x) &eq.not g(x) integral_a^b f(x) dd(x).
$

== Anti-derivative
The anti-derivative of a function $f(x)$ is a function $F(x)$ such that $F'(x) = f(x)$.

For example, the anti-derivative of $x^n$ is $(1/(n+1)) x^(n+1) + c$, where $c$ is a constant. $c$ can be any number, since the derivative of a constant is 0.

Unfortunately, there is no systematic way to find the anti-derivative of a function, but there are some common rules to follow.
#figure(
  block(
    breakable: false,
    table(
      columns: 2,
      table.header([Function], [Anti-derivative]),
      $1 / x$, $ln(abs(x)) + c$,
      $e^x$, $e^x + c$,
      $ln(x)$, $x ln(x) - x + c$,
      $tan(x)$, $-ln(abs(cos(x))) + c$,
      $sin(x)$, $-cos(x) + c$,
      $cos(x)$, $sin(x) + c$,
      $sec^2(x)$, $tan(x) + c$,
      $csc^2(x)$, $-cot(x) + c$,
      $sec(x) tan(x)$, $sec(x) + c$,
      $csc(x) cot(x)$, $-csc(x) + c$,
    ),
  ),
)

Also, there are functions we can't find the anti-derivative for, like $e^(-x^2)$.

== Part 2
The second part of the Fundamental Theorem of Calculus states that the integral of a function can be calculated by finding an anti-derivative of the function.
For a definite integral, such operation will cancel out the constant $c$:
$
  integral_a^b f(x) dd(x) &= F(b) - c - F(a) - (-c) \
  &= F(b) - F(a).
$

To put it in other words, once $c$ is fixed, the integral has bounds, and is definite.

== Even and Odd Functions
/ Even function: $f(x) = f(-x)$, symmetrical about the $y$-axis.
/ Odd function: $f(x) = -f(-x)$, symmetrical about the origin.

For an even function, the integral over a symmetric interval is twice the integral over half the interval:
$
  integral_(-a)^a f(x) dd(x) &= 2 integral_0^a f(x) dd(x).
$

For an odd function, the integral over a symmetric interval is 0:
$
  integral_(-a)^a f(x) dd(x) &= 0.
$

== Integration by Substitution
In essence, integration by substitution is the chain rule in reverse.
$
  dv(,x) f(g(x)) &= f'(g(x)) dot g'(x) \
  integral f'(g(x)) dot g'(x) dd(x) &= f(g(x)) + c.
$

When we have $f'(g(x))$ and $g'(x)$, we can substitute $u(x) = g(x)$ and $u'(x) = g'(x) dd(x)$:
$
  integral f'(g(x)) dot g'(x) dd(x) &= integral f'(u(x)) u'(x) dd(x) \
  &= lr(integral g(u) dd(u) |)_(u=u(x)) \
  &= f(u) + c.
$
$u$ would typically be something that is easy to differentiate.

For example, consider $integral 9 sin^8(x) cos(x) dd(x)$.
Let $u = sin(x)$,
$
  dd(u) &= u'(x) dd(x) \
  &= cos(x) dd(x).
$ $
  integral 9 sin^8(x) cos(x) dd(x) &= 9 integral sin^8(x) underline(cos(x) dd(x)) \
  &= 9 integral sin^8(x) underline(dd(u)) \
  &= 9 integral u^8 dd(u) \
  &= 9 times (1 / 9) u^9 + c \
  &= sin^9(x) + c.
$

The expression to become $dd(u)$ would not always be so obvious, so it is a good idea to first factor the integrand.
Also, you will want $u$ to be some function with arguments more than just $x$, like $sqrt(x)$ or $(x^2 + 1)$.

=== Substitution with Definite Integrals
When substituting in a definite integral, the bounds must be changed accordingly:
$
  integral_a^b f'(g(x)) dot g'(x) dd(x) &= integral_(u(a))^(u(b)) f'(u) dd(u).
$

Alternatively, we can first find the indefinite integral, then take in the bounds.

The general steps are:
+ Determine $u$.
+ _Do not forget to_ substitute bounds.
+ Substitute to $dd(u)$.
+ Substitute the integrand with $u$.

=== Special Integrals
#figure(
  caption: [Integrals to Memorize],
  {
    show math.equation.where(block: true): it => $display(#it)$
    table(
      columns: 3,
      align: center + horizon,
      inset: (y: 1em),
      table.header([Function], [Anti-derivative], [Note]),
      $ 1 / (1 + x^2) $,
      $ arctan(x) + c $,
      [For denominator $a^2 + x^2$, use $1/a arctan(x / a)$. \ (Time $a^2$ to inside and substitute $u = x / a$.)],

      $ 1 / sqrt(1 - x^2) $,
      $ arcsin(x) + c $,
      [For denominator $sqrt(a - (x - b)^2)$, use $arcsin((x - b) / sqrt(a))$. \ (Time $sqrt(a)$ to inside and substitute $u = (x - b) / sqrt(a)$.)],
    )
  },
)

== Area Between Curves
Turns out, we were integrating some others functions against function $y = 0$ all this time!
So to find area between curves, we can just subtract the two functions and integrate the result.

Note that when asked to find the area, _not signed area_, we should make sure to subtract the function with smaller value in bounds from the one with larger value.
Usually it is done by finding intersections of the two functions and comparing the values around those points, or the derivatives at those points.

Sometimes, we will even break up the integral into multiple parts, where the functions are integrable.
When it is hard to integrate in terms of $x$, try taking an inverse approach and integrate in terms of $y$.

== Trigonometric Substitution
When dealing with integrals with square roots, we can use trigonometric substitution to simplify the integrand.

For example, consider $integral sqrt(1 - x^2) dd(x)$.
If the bounds like 0 to 1, we know it is a nice part area of circle, but what if not?

Forms of
$
  sqrt(a^2 - x^2), sqrt(a^2 + x^2), sqrt(x^2 - a^2)
$
can be simplified by using trigonometric substitution:
Known that
$
  sin^2(theta) + cos^2(theta) = 1 \
  tan^2(theta) + 1 = sec^2(theta),
$
then let $x = a sin(theta)$ where $a > 0$,
$
  sqrt(a^2 - x^2) &= sqrt(a^2 - a^2 sin^2(theta)) \
  &= sqrt(a^2 cos^2(theta)) \
  &= a abs(cos(theta)) \
  &= a cos(theta) "when" -pi / 2 <= theta <= pi / 2.
$

We can thus apply it, for example,
$
  integral sqrt(1 - x^2) dd(x) &= integral sqrt(1 - a^2 sin^2(theta)) space a cos(theta) dd(theta) \
  &= integral a^2 cos^2(theta) dd(theta) \
  &= a^2 integral cos^2(theta) dd(theta) \
  &= a^2 integral (1 + cos(2 theta)) / 2 dd(theta) \
  &= a^2 / 2 (theta + sin(2 theta) / 2) + c \
  &= a^2 / 2 (theta + sin(theta) cos(theta)) + c, \
  x / a &= sin(theta) \
  theta &= arcsin(x / a), \
  cos(theta) &= sqrt(1 - sin^2(theta)) \
  &= sqrt(1 - x^2 / a^2), \
  integral sqrt(1 - x^2) dd(x) &= a^2 / 2 (arcsin(x / a) + x sqrt(1 - x^2 / a^2)) + c.
$

#block(
  stroke: red,
  width: 100%,
  inset: 0.65em,
  [Memorize trigonometric identities!],
)

== Integration by Parts
Integration by parts is the reverse of the product rule.
$
  (u v)' = u' v + u v'.
$

When we have $u$ and $v'$, we can integrate by parts:
$
  integral u v dd(x) &= u integral v dd(x) - integral u' (integral v dd(x)) dd(x) \
  integral u' v dd(x) &= u v - integral u v' dd(x).
$

== Simpson's rule
We already know that integrals can be estimated by Riemann sums, but all those sums can be rather inaccurate.
What if, instead of using 2 points to form trapezoids or rectangles, we use 3 points to form parabolas?

/ Simpson's rule: $
    integral_a^b f(x) dd(x) &approx (Delta x) / 3 [f(x_0) + 4 f(x_1) + 2 f(x_2) + 4 f(x_3) + ... \
      &+ 2 f(x_(n - 2)) + 4 f(x_(n - 1)) + f(x_n)]
  $ where $n$ is an _even_ number.

= Improper Integrals
/ Improper integral: An integral either with an unbounded integrand, or taken over an infinite interval.

For example, $integral_(-1)^1 1 / x^2 "and" integral_0^oo e^(-x)$ are improper.

== Redefining Unbounded Improper Integral
If the integrand is discontinuous at some point or in some region, we can redefine it as one or more integrals with bounds approaching the discontinuities.

For example, given that $f(x)$ has discontinuity at $c in (a, b)$,
$
  integral_a^b f(x) dd(x) &= integral_a^c f(x) dd(x) = integral_c^b f(x) dd(x) \
  &= lim_(s -> a^-) integral_a^s f(x) dd(x) + lim_(t -> c^+) integral_t^b f(x) dd(x).
$
Notably, the LHS converges when both expressions in the RHS converge.

For example, given
$
  I = integral_0^5 (-cos(1 / x)) / x^2 dd(x),
$ notice that $I$ discontinues at $x = 0$.
$
  I &= lim_(t -> 0^+) integral_t^5 (-cos(1 / x)) / x^2 dd(x) \
  &= lim_(t -> 0^+) integral_(1 / t)^(1 / 5) -cos(u) dd(u) \
  &= lim_(t -> 0^+) (sin(1 / 5) - sin(1 / t)).
$
The integral does not exist.

== Redefining Improper Integral with Infinite Interval
$
  integral_a^oo f(x) dd(x) = lim_(R -> oo) integral_a^R f(x) dd(x) \
  integral_(-oo)^b f(x) dd(x) = lim_(T -> -oo) integral_T^b f(x) dd(x).
$
The LHS converges when the RHS converge.

For example,
$
  integral_0^oo e^(-x) dd(x) &= lim_(R -> oo) integral_0^R e^(-x) dd(x) \
  &= lim_(R -> oo) [-e^(-x)]_0^R \
  &= lim_(R -> oo) (-e^(-R) + e^0) \
  &= 1.
$

=== When Both Bounds Are Infinity
$
  integral_(-oo)^oo f(x) dd(x) eq.not lim_(R -> oo) integral_(-R)^(R) f(x) dd(x).
$
To realize this, think of $integral_(-oo)^oo (sin(x) - cos(x)) dd(x)$ geometrically.

Instead,
$
   integral_(-oo)^oo f(x) dd(x) = lim_(T -> -oo) integral_T^c f(x) dd(x) + lim_(R -> oo) integral_c^R f(x) dd(x)
$ where $c in RR$.

For example,
$
  integral_(-oo)^oo 1 / (1 + x^2) dd(x) &= lim_(T -> -oo) integral_T^0 1 / (1 + x^2) dd(x) + lim_(R -> oo) integral_0^R 1 / (1 + x^2) dd(x) \
  &= lim_(T -> -oo) [arctan(x)]_T^0 + lim_(R -> oo) [arctan(x)]_0^R \
  &= (0 - (- pi / 2)) + (pi / 2 - 0) \
  &= pi.
$

== Determining Convergence

=== Value Comparison Test
Let function $f, g$ be integrable on any interval contained in $(a, b)$, then:
- If $abs(f(x)) <= g(x)$ for $x in (a, b)$ and $integral_a^b g(x) dd(x)$ converges, then $integral_a^b f(x) dd(x)$ converges.
- If $f (x) >= g (x) >= 0$ for $x in (a, b)$ and $integral_a^b g(x) dd(x)$ diverges, then $integral_a^b f(x) dd(x)$ diverges.

=== Limit Comparison Test
Let $−oo < a < oo$. Let $f, g$ be functions that are defined and continuous for all $x >= a$ and assume that $g(x) >= 0$ for $x >= a$.

- If $integral_a^oo g(x) dd(x)$ converges and $lim_(x -> oo) f(x) / g(x)$ exists, then $integral_a^oo f(x) dd(x)$ converges.
- If $integral_a^oo g(x) dd(x)$ diverges and $lim_(x -> oo) f(x) / g(x)$ exists and _is nonzero_, then $integral_a^oo f(x) dd(x)$ diverges.

= Random Variables and Probability Density Functions
/ Probability Density Function (PDF): A function describing distribution of probabilities.

Some important properties of PDFs:
- The integral of a PDF is always 1.
- Any point of a PDF _cannot_ be negative.
- But any point of a PDF can be greater than 1.

== Expected Value
/ Expected value: Also called expectation, is the sum of all possible values with their possibility.
  $ EE(X) = sum x dot "Pr"(X = x). $

Given a _continuous_ random variable $X$,
$
  EE(X) = integral_(-oo)^oo x dot f(x) dd(x)
$ where $f(x)$ is the PDF.

A quick sanity check for such expectation is to see the area of PDF as an uniform object, and try finding a point where the object can balance on.

== Variance and Standard Deviation
/ Variance: The expected value of the squared deviation from the mean of $X$
  $
    "Var"(X) &= E[(X - E(X))^2] \
    &= E(X^2) - E(X)^2,
  $
  usually represented by $sigma^2$.
/ Standard deviation: The square root of variance, usually represented by $sigma$.

How do we do $E(X^2)$?

=== Law of the Unconscious Statistician
$
  E[g(X)] integral_(-oo)^oo g(x) f_X (x) dd(x)
$ where $f_X$ is the PDF of $X$.

= Sequence and Series
/ Sequence: An enumerated collection of objects in which repetitions are allowed and order matters.
  It looks like ${a_0, a_1, a_2, ...}$.
/ Series: An addition of infinitely many terms, one after the other.
  Or defined as a limit of partial sums, $lim_(N -> oo) sum_(n = 0)^N S_N$.

A sequence can take in values of a function, ${f(x_i)}_a^b = {f(x_a), f(x_(a + 1)), ... f(x_b)}$.
And just like functions, a sequence can diverge or converge.
However, a sequence of a function converges does not imply that the function also converges.

#block(stroke: red, inset: 0.65em)[
  The order of summation in series is important!
]

We may add or subtract series with each other by adding or subtracting their results, but cannot do so with multiplication or division.

== Divergence Test
Given the sequence ${a_n}_1^oo$, if $lim_(n -> oo) a_n eq.not 0$, then $sum_(n = 1)^oo a_n$ diverges.
If it does apply, then the other way around is also true.

#block(stroke: red, inset: 0.65em)[
  The divergence test does not tell us anything about convergence.
  In other words, if $lim_(n -> oo) a_n = 0$, it is useless.
]

== Integral Test
For a series $s = lim_(N -> oo) sum_(n = 1)^N f(n)$, if $lim_(N -> oo) integral_1^(N + 1) f(x) dd(x) < s$ and diverges, $s$ also diverges.
Take note of the $N + 1$ integral upper bound, that means our series is actually a Left Riemann Sum of the function!

Similarly, if we instead use $N$ for the upper bound, we get a Right Riemann Sum.

Use them on $1 / n$ and $1 / n^2$ from $1$ to see for yourself!

Well, $N + 1$ or $N$, when $N -> oo$ they are all infinity.
Hence, if $integral_(N_0)^oo f(x) dd(x)$ diverges/converges, $sum {f(x) | x in ZZ and x >= N_0}$ also diverges/converges.

#termlist
