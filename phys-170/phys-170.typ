#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    PHYS 170 Study Notes \
    #underline[Mechanics]
  ],
  author: "Yecheng Liang",
)

#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"

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
#let vecu(body) = $vectorunit(body)$

#let all-terms = state("terms", ())
#show terms.item: it => context { let loc = here(); all-terms.update(c => c + ((it, loc),)); it }
#let termlist = [
  #pagebreak(weak: true)
  #heading(level: 1, numbering: none)[Definitions]
  #context terms(..all-terms.final().map(el => {
    terms.item(link(el.at(1), el.at(0).term), el.at(0).description)
  }), tight:false)
]

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

$ vecb(A) "has a magnitude of" vecl(A) "in direction" vecu(A). $

In manuscript, of course we cannot strike bold, so we use overhead arrow for vectors instead.

== Angle Unit
In this course, angles are in degrees.

= Force Vectors
Force, having both magnitude and direction, is a vector.
Intuitively, we can apply all kinds of vector operations to forces, as you would learn in MATH 152.

== Addition
Use #quote[tip to tail] for triangular method of addition: draw the vectors head to tail, and the resultant vector is the vector from the tail of the first vector to the head of the last vector.

== Force Components
$
  vecb(F) = vecl(x) vecu(i) + vecl(y) vecu(j)
$ where $x, y$ are magnitudes of the force in the $vecu(i), vecu(j)$ directions.


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
      vecb(F) &= vecl(F)_x vecu(i) + vecl(F)_y vecu(j) \
      &= vecl(F) (cos(theta) vecu(i) + sin(theta) vecu(j))
    $
    where $vecu(i), vecu(j)$ are unit vectors in the $x, y$ directions.
    This is the Cartesian form of a vector.
  ],
)

For a force with 2 dimensions, we call it a coplanar force.

Sometimes, non-linear equations arise from problems involving forces. Gladly use math solvers for those.

== Unit Vector
To disregard magnitude and only focus on direction, we use unit vector, which we divide a vector by its magnitude, $vecu(u) = vecb(A) / vecl(A)$.

== 3D Forces
Forces in 3D are $vecb(F) = vecl(F)_x vecu(i) + vecl(F)_y vecu(j) + vecl(F)_z vecu(k)$, with their magnitudes being $vecl(F) = sqrt(vecl(F)_x^2 + vecl(F)_y^2 + vecl(F)_z^2)$.

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
  vecu(u) &= cos(alpha) vecu(i) + cos(beta) vecu(j) + cos(gamma) vecu(k)
$ and $
  vecb(F) &= vecl(F) vecu(u) \
  &= vecl(F) (cos(alpha) vecu(i) + cos(beta) vecu(j) + cos(gamma) vecu(k))
$

#block(stroke: red, inset: 0.8em)[
  The directions satisfy $-180 degree < alpha, beta, gamma < 180 degree$ and have identity
  $
    cos^2(alpha) + cos^2(beta) + cos^2(gamma) = 1.
  $
]

=== Determining 3D Force Components

#figure(
  caption: [A Cartesian Vector],
  image("assets/cart-force.png", width: 50%),
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
  vecb(F) = vecl(F) (cos(alpha) vecu(i) + cos(beta) vecu(j) + cos(gamma) vecu(k)).
$

== Position Vectors
Position vectors are vectors that describe the position of a point in space relative to a reference point.

As obvious, we need 3 coordinates to locate a point in 3D space.
Point $P(x, y, z)$ has position vector $vecb(r) = x vecu(i) + y vecu(j) + z vecu(k)$ relative to the origin.

Note that the position vector does not always come from the origin, it can be relative to arbitrary points.
Given $A(x_A, y_A, z_A)$ and $B(x_B, y_B, z_B)$, the position vector of $B$ relative to $A$ is
$
  vecb(r) = (x_B - x_A) vecu(i) + (y_B - y_A) vecu(j) + (z_B - z_A) vecu(k).
$

Connecting to unit vectors, $vecb(u) = vecb(F) / vecl(F)$,
$
  vecb(F) = vecl(F) vecb(u) = vecl(F) vecb(r) / vecl(r).
$

To simplify calculation, let $X = vecl(F) / vecl(r)$,
$
  vecb(F) &= X vecb(r) \
  vecl(F) &= X vecl(r).
$

== Vector Operations
Mostly taught in MATH 152, but here again anyways.

=== Dot Product & Angle Between Vectors
$
  vecb(A) dot vecb(B) &= vecl(A) vecl(B) cos(theta) \
  &= A_x B_x + A_y B_y + A_z B_z
$

=== Parallel & Perpendicular Components
Two vectors are parallel if their cross product is a zero vector, and perpendicular if their dot product is zero.

Given a vector $vecb(A)$, its parallel component is
$
  vecb(A)_(parallel) = (vecb(A) dot vecu(u)) vecu(u)
$
and its perpendicular component is
$
  vecb(A)_(perp) = vecb(A) - vecb(A)_(parallel).
$

=== Projection
The projection of $vecb(A)$ onto $vecb(B)$ is
$
  vecb(A)_"proj on B" = (vecb(A) dot vecu(u_B)) vecu(u_B).
$
Note the similarity to the parallel component formula.

= Equilibrium of a Particle
This section only concerns static equilibrium, where the particle is at rest.
In other words, $ sum vecb(F) = 0. $

== Free-Body Diagram
To draw a free-body diagram,
+ Draw a labeled right-hand coordinate system.
+ Draw outlined shape.
+ Show all forces. \
  Since this is static equilibrium, account for _active_ and _reactive_ forces.
+ Identify and label each force.

== Coplanar Force Systems
On a 2D plane, forces can be resolved into $x, y$ components.
$
  sum vecb(F)_x &= 0 \
  sum vecb(F)_y &= 0.
$

== 3D Force Systems
Forces in 3D can be resolved into $x, y, z$ components.
$
  sum vecb(F)_x &= 0 \
  sum vecb(F)_y &= 0 \
  sum vecb(F)_z &= 0.
$

Be very careful with the signs of the forces.

== Solving Equilibrium Problems
With multiple forces and their direction vectors (_not unit vectors_) $vecb(r)$, $ F = vecb(r) X "or" Y "or" Z ... $ where $X, Y, Z... = vecl(F) / vecl(r)$.
Solving for $X, Y, Z$ gives the forces.
To solve a typical $X, Y, Z$ system, we can use the `rref` function on a matrix of the coefficients in the equations and their RHS. More in MATH 152.

Why don't we directly compute the values? Try and see for yourself, you will comeback to the $X, Y, Z$'s.

A sanity check would be to ensure that the forces are on the same magnitude as the original forces, and are in somewhat canceling directions.

#block(stroke: red, inset: 0.8em)[
  As always, check angles and signs. Forces project to the negative axis have $alpha, beta, gamma > 90 degree$.
]

= Force System Resultants
Forces can produce difference results.
/ Force: Causes translation of a body.
/ Moment/Torque: Causes rotation of a body.

Translation happens on the same plane as the forces, while rotation happens perpendicular to the plane.

In this course of statics, we study not the translations or rotations, but the _tendencies_ for the bodies to act so.

These results combined are called the force system resultants.

== Moment of a Force
Intuitively, magnitude of the moment of a force $vecb(F)$ about point $O$ is
$
  M_O = vecl(F) d
$ where $d$ is the perpendicular distance from $O$ to the line of action of $vecb(F)$.

Multiple moments? Just sum them up.

By convention (curl of fingers in the Right Hand Rule), positive moments point to the positive z axis, counterclockwise.

To understand rotation in a simple way, think of (or actually do) opening a door at different points in different directions.

Now, be reminded that the cross product of two vectors produces a vector perpendicular to the plane of the two vectors.

=== Cross Product
Samely, more in MATH 152.
$
  vecb(A) times vecb(B) &= matrixdet(
    vecu(i), vecu(j), vecu(k);
    A_x, A_y, A_z;
    B_x, B_y, B_z;
  ) \
  &= (A_y B_z - A_z B_y) vecu(i) - (A_x B_z - A_z B_x) vecu(j) + (A_x B_y - A_y B_x) vecu(k)
$ which is perpendicular to both $vecb(A)$ and $vecb(B)$.

And it is non-commutative.
$
  vecb(C) &= vecb(A) times vecb(B) \
  -vecb(C) &= vecb(B) times vecb(A)
$

It is mandated that we show construction of the determinant in exams even if we use calculators.

== Vector Formulation of Moment
$
  vecb(M)_O &= vecb(r) times vecb(F)
$ where $vecb(r)$ is the position vector of the point of application of $vecb(F)$ relative to $O$, in other words, _any_ vector from $O$ to the line of action of $vecb(F)$.

The magnitude of $vecb(M)_O$ is then
$
  vecl(M)_O &= vecl(r) vecl(F) sin(theta) \
  &= vecl(F) d \
  vecb(M)_"axis" &= vecb(u)_a_x times (vecb(r) times vecb(F)) \
  &= vecb(u)_a_x times vecb(M)_O "(this can commutate)".
$

Using our recent knowledge of Cartesian vectors and cross products, we can write the moment as
$
  vecb(M)_O &= matrixdet(
    vecu(i), vecu(j), vecu(k);
    r_x, r_y, r_z;
    F_x, F_y, F_z;
  )
$

== Moment of a Couple
/ Couple: A pair of forces of equal magnitude, opposite direction, and parallel lines of action.

$
  vecb(M)_"couple" &= vecb(r)_A times vecb(-F) + vecb(r)_B times vecb(F) \
  vecl(M)_"couple" &= vecl(F) d
$ where $d$ is the perpendicular distance between the lines of action of the forces.

The moment of a couple is independent of the point about which it is taken it is a _free vector_.

#block(stroke: red, inset: 0.8em)[
  The moment of a couple is the same about any point.
]

== Equivalent Systems
Two systems are equivalent if they produce the same external effects on a body.

To 'shift' a force, we can make it a couple by adding a pair of force of equal magnitude, of opposite direction, parallel to the original force at the desired location.
Then, add the couple moment somewhere and cancel the original force.

== Couple of Moments
$
  vecb(M)_"couple" &= vecb(M)_A + vecb(M)_B.
$

== Simplification of Force Systems
To simplify a force system, we can
+ Move forces to a common point.
+ Place the moments of couples at the common point.
+ Replace the forces with their resultant.

/ Concurrent Forces: Lines of forces that pass through a common point.
  They produce no moment about that point.
/ Coplanar Forces: Forces that lie in the same plane.
/ Parallel Forces: Forces that have parallel lines of action.

A parallel force system can be simplified by replacing the forces with a single resultant force and a single resultant moment.
It can then be further simplified by moving the resultant force to the point of application of the resultant moment.
$
  vecb(F)_R "and" vecb(M)_O "at" O = vecb(F)_R "with distance" vecl(M)_O / vecl(F)_R.
$

=== Reduction to a Wrench
Given arbitrary forces and moments, we can reduce them to a single force and a single moment.
+ Regard the resultant force as a baseline, moments parallel to the force can be eliminated by moving the force to a distance $d = vecl(M)_perp slash vecl(F)_R$.
+ Move the parallel moment to the resultant force.

When solving for the resultant force, first setup an imaginary point $P$ as our resultant force point, then solve for the resultant force and moment about $P$.
Make use of the fact that the resultant moment must be parallel to the resultant force.

= Equilibrium of a Rigid Body
/ Internal Forces: Forces that hold the particles of a body together.
/ External Forces: Forces that act on the body as a whole.

For equilibrium, we do not consider internal forces, because they always occur in pairs and cancel each other out.

In equilibrium, the sum of the forces and moments acting on a rigid body is zero, in other words, vanish.
$
  sum vecb(F) = 0 \
  sum vecb(M)_O = 0.
$
It does not matter where the point $O$ is.

When a body is in equilibrium, it is in both translational and rotational equilibrium.
Typically, it is supported by something, and the forces and moments include the reactions of the supports.
If a support restricts translation, it produces a reaction force, and if it restricts rotation, it produces a reaction moment.

== Types of Supports
- Roller: Restricts translation in one direction.
- Ball and socket: Restricts translation in all directions.
- Single journal bearing: Only allows translation in one direction and rotation about that direction.
- Double journal bearing: Only allows translation in two directions, *_does not restrict rotation directly, but does through restricting translation_*.
- Single journal bearing with square shaft: Only allows translation in one direction.
- Single thrust bearing: Only allows rotation in one direction.
- Single smooth pin: Only allows rotation about the pin.
- Single hinge: Only allows rotation about the hinge.
- Fixed support: Restricts translation and rotation in all directions.

The translation and rotation restricted correspond to the reaction forces and moments produced by the support.

// = Friction

// = Kinematics of a Particle

// = Kinetics of a Particle: Force and Acceleration

// = Kinetics of a Particle: Work and Energy

// = Kinetics of a Particle: Impulse and Momentum



#termlist
