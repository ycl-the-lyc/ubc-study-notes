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
#let veca(body) = $vectorarrow(italic(body))$
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
In this course, vectors are upright bold, and vector magnitudes are italicized bold, while unit vectors are italics with an hat over.

$ vecb(A) "has a magnitude of" vecl(A) "in direction" hat(A). $

== Angle Unit
In this course, angles are in degrees.

= Force Vectors
Force, having both magnitude and direction, is a vector.
Intuitively, we can apply all kinds of vector operations to forces, as you would learn in MATH 152.

== Addition
Use #quote[tip to tail] for triangular method of addition: draw the vectors head to tail, and the resultant vector is the vector from the tail of the first vector to the head of the last vector.

== Force Components
$
  vecb(F) = vecl(x) vecb(i) + vecl(y) vecb(j)
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
    where $vecb(i), vecb(j)$ are unit vectors in the $x, y$ directions.
    This is the Cartesian form of a vector.
  ],
)

For a force with 2 dimensions, we call it a coplanar force.

Sometimes, non-linear equations arise from problems involving forces. Gladly use math solvers for those.

== Unit Vector
To disregard magnitude and only focus on direction, we use unit vector, which we divide a vector by its magnitude, $hat(u) = vecb(A) / vecl(A)$.

== 3D Forces
Forces in 3D are $vecb(F) = vecl(F)_x vecb(i) + vecl(F)_y vecb(j) + vecl(F)_z vecb(k)$, with their magnitudes being $vecl(F) = sqrt(vecl(F)_x^2 + vecl(F)_y^2 + vecl(F)_z^2)$.

To determine orientation of the axis, we use the right-hand rule: make a thumb up using your right hand, the side of the curling fingers is $x$, the arm is $y$, and the thumb is $z$.

=== Direction of Cartesian Vector
The direction of a Cartesian vector is the angles between the vector and the *positive* axis.
$alpha, beta, gamma$ each corresponds to the angle from the positive $x, y, z$ axis.
$
  cos(alpha) &= vecl(F)_x / vecl(F) \
  cos(beta) &= vecl(F)_y / vecl(F) \
  cos(gamma) &= vecl(F)_z / vecl(F)
$

Therefore,
$
  hat(u) &= cos(alpha) vecb(i) + cos(beta) vecb(j) + cos(gamma) vecb(k)
$ and $
  vecb(F) &= vecl(F) hat(u) \
  &= vecl(F) (cos(alpha) vecb(i) + cos(beta) vecb(j) + cos(gamma) vecb(k))
$

The directions satisfy $-180 degree < alpha, beta, gamma < 180 degree$ and have identity
$
  cos^2(alpha) + cos^2(beta) + cos^2(gamma) = 1.
$

=== Determining 3D Force Components

#figure(
  caption: [A Cartesian Vector],
  image("assets/cart-force.png", width: 50%)
  //REF Engineering Mechanics: Statics, 15th Edition, Hibbeler
)

With magnitude $vecl(F)$ and angles from the positive z-axis $phi$ and from the positive x-axis $theta$, we can determine the force components by first solving for $vecl(F)_z$, then $vecl(F)_(x y)$ followed by $vecl(F)_x$ and $vecl(F)_y$.
$
  vecl(F)_z &= vecl(F) cos(phi) \
  vecl(F)_(x y) &= vecl(F) sin(phi) \
  vecl(F)_x &= vecl(F)_(x y) cos(theta) \
  vecl(F)_y &= vecl(F)_(x y) sin(theta)
$

Or instead, given 2 ($beta, gamma$) of the 3 Cartesian angles, we can determine the force by
$
  cos(alpha) = sqrt(1 - cos^2(beta) - cos^2(gamma)) \
  vecb(F) = vecl(F) (cos(alpha) vecb(i) + cos(beta) vecb(j) + cos(gamma) vecb(k)).
$

== Position Vectors
Position vectors are vectors that describe the position of a point in space relative to a reference point.

As obvious, we need 3 coordinates to locate a point in 3D space.
Point $P(x, y, z)$ has position vector $vecb(r) = x vecb(i) + y vecb(j) + z vecb(k)$ relative to the origin.

Note that the position vector does not always come from the origin, it can be relative to arbitrary points.
Given $A(x_A, y_A, z_A)$ and $B(x_B, y_B, z_B)$, the position vector of $B$ relative to $A$ is
$
  vecb(r) = (x_B - x_A) vecb(i) + (y_B - y_A) vecb(j) + (z_B - z_A) vecb(k).
$

= Equilibrium of a Particle

= Force System Resultants

= Equilibrium of a Rigid Body

= Friction

= Kinematics of a Particle

= Kinetics of a Particle: Force and Acceleration

= Kinetics of a Particle: Work and Energy

= Kinetics of a Particle: Impulse and Momentum
