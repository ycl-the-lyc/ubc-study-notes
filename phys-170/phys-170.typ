#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    PHYS 170 Study Notes \
    #underline[Mechanics]
  ],
  author: "Yecheng Liang",
)

#import "@preview/cetz:0.3.1"
#import "@preview/physica:0.9.4": *
#import "@preview/metro:0.3.0": *
#import units: *
#import prefixes: *
#let ui = unit
#import "@preview/equate:0.2.1": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#let ft = $"ft"$
#let lb = $"lb"$

#let vecb(body) = $vectorbold(upright(body))$
#let vecl(body) = $vectorbold(italic(body))$

= General Principles

== The Four Horseman of Mechanics
- Length
- Mass
- Time
- Force

So you basically take three of them and solve the 1 left.

== US Customary Units

#figure(
  caption: [SI and US Customary (FPS) Units for Mechanics],
  table(
    columns: 4,
    align: center + horizon,
    inset: (x, y) => if y == 0 { (x: 2em, y: 0.65em) } else { 1.3em },
    [Length], [Mass], [Time], [Force],
    [meter \ $ui(m)$], [kilogram \ $ui(kg)$], [second \ $ui(s)$], [force \ $ui(kg m / s^2)$],
    [foot \ $ui(ft)$], [slug \ $ui(lb s^2 / ft)$], [second \ $ui(s)$], [pound \ $ui(lb)$],
  ),
)

== Gravity
$
  F &= G (m_1 m_2) / r^2 \
  F &= m a
$

In this course, we will use $ g = qty(9.81, m/s^2) $ which happens to be true for Vancouver.

== Vector Notation
In this course, vectors are upright bold, and vector magnitudes are italicized bold.

$ vecb(A) "has a magnitude of" vecl(A). $

== Angle Unit
In this course, angles are in degrees.

= Force Vectors
Force, having both magnitude and direction, is a vector.
Intuitively, we can apply all kinds of vector operations to forces, as you would learn in MATH 152.

== Addition
Use #quote[Tip to tail] for triangular method of addition: draw the vectors head to tail, and the resultant vector is the vector from the tail of the first vector to the head of the last vector.

== Force Components
$
  vecb(F) = x vecb(i) + y vecb(j)
$ where $x, y$ are magnitudes of the force in the $vecb(i), vecb(j)$ directions.


#grid(
  columns: (25%, 75%),
  cetz.canvas(
    length: 40%,
    {
      import cetz.draw: *

      set-style(mark: (end: ">", fill: black))

      line((0, 0), (2, 3), name: "f")
      content("f.mid", (rel: (-0.2, 0.2)), $vecb(F)$)

      line((0, 0), (2, 0), name: "fx", stroke: (paint: blue))
      content("fx.mid", (rel: (0, 0.3)), $vecb(F)_x$)

      line((2, 0), (2, 3), name: "fy", stroke: (paint: red))
      content("fy.mid", (rel: (-0.35, 0)), $vecb(F)_y$)

      cetz.angle.angle(
        (0, 0),
        "fx.end",
        "fy.end",
        radius: 0.5,
        fill: green.transparentize(80%),
        mark: none,
        label: $theta$,
        label-radius: 65%,
      )
    },
  ),
  align(horizon)[
    Force $vecb(F)$ can be represented as a combination of $vecb(F)_x$ and $vecb(F)_y$
    $ vecb(F) = vecb(F)_x + vecb(F)_y $
    or as a polar coordinate of angle $theta = arctan(vecl(F)_y / vecl(F)_x)$ and magnitude $vecl(F)$
    $ vecb(F) = vecl(F) (cos(theta) + sin(theta)). $

    To generalize it, we can write it as
    $
      vecb(F) &= vecl(F)_x vecb(i) + vecl(F)_y vecb(j) \
      &= vecl(F) (cos(theta) vecb(i) + sin(theta) vecb(j))
    $
    where $vecb(i), vecb(j)$ are unit vectors in the $x, y$, or any orthogonal directions.
    This is the Cartesian form of a vector.
  ],
)

For a force with 2 dimensions, we call it a coplanar force.

= Equilibrium of a Particle

= Force System Resultants

= Equilibrium of a Rigid Body

= Friction

= Kinematics of a Particle

= Kinetics of a Particle: Force and Acceleration

= Kinetics of a Particle: Work and Energy

= Kinetics of a Particle: Impulse and Momentum
