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
          style: (stroke: white.transparentize(80%)+2pt, fill: gray.transparentize(80%)),
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
  "TRS"(a, b, n) &= sum_(i=1)^n (f(x_(i-1)) + f(x_i)) Delta x / 2,
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
$
  integral 1/x dd(x) &= ln(abs(x)) + c \
  integral e^x dd(x) &= e^x + c \
  integral ln(x) dd(x) &= x ln(x) - x + c \
  integral tan(x) dd(x) &= -ln(abs(cos(x))) + c.
$
//TODO anti-derivative table

Also, there are functions we can't find the anti-derivative for, like $e^(-x^2)$.

== Part 2
The second part of the Fundamental Theorem of Calculus states that the integral of a function can be calculated by finding an anti-derivative of the function.
For a definite integral, such operation will cancel out the constant $c$:
$
  integral_a^b f(x) dd(x) &= F(b) - c - F(a) - (-c) \
  &= F(b) - F(a).
$

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
