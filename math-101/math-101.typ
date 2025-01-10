#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    MATH 101 Study Notes
    #underline[Integral Calculus with Applications]
  ],
  author: "Yecheng Liang",
)

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
