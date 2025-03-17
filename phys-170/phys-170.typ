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

#import "@preview/unify:0.7.1": unit, qty, qtyrange, num, numrange

#import "@preview/equate:0.2.1": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#let ft = $"ft"$
#let lb = $"lb"$

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
    [meter \ $unit("m")$], [kilogram \ $unit("kg")$], [second \ $unit("s")$], [force \ $unit("kg m / s^2")$],
    [foot \ $unit("ft")$], [slug \ $unit("lb s^2 / ft")$], [second \ $unit("s")$], [pound \ $unit("lb")$],
  ),
)

== Gravity
$
  F &= G (m_1 m_2) / r^2 \
  F &= m a
$

In this course, we will use $ g = qty("9.81", "m/s^2") = qty("32.2", "ft/s^2") $ which happens to be true for Vancouver.

== Vector Notation
In this course, vectors are upright bold, and vector magnitudes are italicized, while unit vectors are bold italics with an hat over.

$ vb(A) "has a magnitude of" A "in direction" vu(A). $

In manuscript, of course we cannot strike bold, so we use overhead arrow for vectors instead.

== Angle Unit
In this course, angles are in degrees.

== Drawing Diagrams
- Draw it _big_.
- Draw axis.
- Draw forces and couple moments.
- Do _not_ draw moments due to forces.

= Force Vectors
Force, having both magnitude and direction, is a vector.
Intuitively, we can apply all kinds of vector operations to forces, as you would learn in MATH 152.

== Addition
Use #quote[tip to tail] for triangular method of addition: draw the vectors head to tail, and the resultant vector is the vector from the tail of the first vector to the head of the last vector.

== Force Components
$
  vb(F) = x vu(i) + y vu(j)
$ where $x, y$ are magnitudes of the force in the $vu(i), vu(j)$ directions.


#grid(
  columns: (25%, 75%),
  cetz.canvas(
    length: 40%,
    {
      import cetz.draw: *

      set-style(mark: (end: ">", fill: black))

      line((0, 0), (2, 3), name: "f")
      content("f.mid", (rel: (-0.2, 0.2)), $vb(F)$)

      line((0, 0), (2, 0), name: "fx", stroke: (paint: blue))
      content("fx.mid", (rel: (0, 0.3)), $vb(F)_x$)

      line((2, 0), (2, 3), name: "fy", stroke: (paint: red))
      content("fy.mid", (rel: (-0.35, 0)), $vb(F)_y$)

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
    Force $vb(F)$ can be represented as a combination of $vb(F)_x$ and $vb(F)_y$
    $ vb(F) = vb(F)_x + vb(F)_y $
    or as a polar coordinate of angle $theta = arctan(F_y / F_x)$ and magnitude $F$
    $ vb(F) = F (cos(theta) + sin(theta)). $

    To generalize it, we can write it as
    $
      vb(F) &= F_x vu(i) + F_y vu(j) \
      &= F (cos(theta) vu(i) + sin(theta) vu(j))
    $
    where $vu(i), vu(j)$ are unit vectors in the $x, y$ directions.
    This is the Cartesian form of a vector.
  ],
)

For a force with 2 dimensions, we call it a coplanar force.

Sometimes, non-linear equations arise from problems involving forces. Gladly use math solvers for those.

== Unit Vector
To disregard magnitude and only focus on direction, we use unit vector, which we divide a vector by its magnitude, $vu(u) = vb(A) / A$.

== 3D Forces
Forces in 3D are $vb(F) = F_x vu(i) + F_y vu(j) + F_z vu(k)$, with their magnitudes being $F = sqrt(F_x^2 + F_y^2 + F_z^2)$.

To determine orientation of the axis, we use the right-hand rule: make a thumb up using your right hand, the side of the curling fingers is $x$, the arm is $y$, and the thumb is $z$.

=== Direction of Cartesian Vector
The direction of a Cartesian vector is the angles between the vector and the *positive* axis.
$alpha, beta, gamma$ each corresponds to the angle from the positive $x, y, z$ axis.
$
  cos(alpha) &= F_x / F \
  cos(beta) &= F_y / F \
  cos(gamma) &= F_z / F
$

Therefore,
$
  vu(u) &= cos(alpha) vu(i) + cos(beta) vu(j) + cos(gamma) vu(k)
$ and $
  vb(F) &= F vu(u) \
  &= F (cos(alpha) vu(i) + cos(beta) vu(j) + cos(gamma) vu(k))
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

With magnitude $F$ and angles from the positive z-axis $phi$ and from the positive x-axis $theta$, we can determine the force components by first solving for $F_z$, then $F_(x y)$ followed by $F_x$ and $F_y$.
$
  F_z &= F cos(phi) \
  F_(x y) &= F sin(phi) \
  F_x &= F_(x y) cos(theta) \
  F_y &= F_(x y) sin(theta)
$

Or instead, given 2 ($beta, gamma$) of the 3 Cartesian angles, we can determine the force by
$
  cos(alpha) = sqrt(1 - cos^2(beta) - cos^2(gamma)) \
  vb(F) = F (cos(alpha) vu(i) + cos(beta) vu(j) + cos(gamma) vu(k)).
$

== Position Vectors
Position vectors are vectors that describe the position of a point in space relative to a reference point.

As obvious, we need 3 coordinates to locate a point in 3D space.
Point $P(x, y, z)$ has position vector $vb(r) = x vu(i) + y vu(j) + z vu(k)$ relative to the origin.

Note that the position vector does not always come from the origin, it can be relative to arbitrary points.
Given $A(x_A, y_A, z_A)$ and $B(x_B, y_B, z_B)$, the position vector of $B$ relative to $A$ is
$
  vb(r) = (x_B - x_A) vu(i) + (y_B - y_A) vu(j) + (z_B - z_A) vu(k).
$

Connecting to unit vectors, $vb(u) = vb(F) / F$,
$
  vb(F) = F vb(u) = F vb(r) / r.
$

To simplify calculation, let $X = F / r$,
$
  vb(F) &= X vb(r) \
  F &= X r.
$

== Vector Operations
Mostly taught in MATH 152, but here again anyways.

=== Dot Product & Angle Between Vectors
$
  vb(A) dot vb(B) &= A B cos(theta) \
  &= A_x B_x + A_y B_y + A_z B_z
$

=== Parallel & Perpendicular Components
Two vectors are parallel if their cross product is a zero vector, and perpendicular if their dot product is zero.

Given a vector $vb(A)$, its parallel component is
$
  vb(A)_(parallel) = (vb(A) dot vu(u)) vu(u)
$
and its perpendicular component is
$
  vb(A)_(perp) = vb(A) - vb(A)_(parallel).
$

=== Projection
The projection of $vb(A)$ onto $vb(B)$ is
$
  vb(A)_"proj on B" = (vb(A) dot vu(u_B)) vu(u_B).
$
Note the similarity to the parallel component formula.

= Equilibrium of a Particle
This section only concerns static equilibrium, where the particle is at rest.
In other words, $ sum vb(F) = 0. $

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
  sum vb(F)_x &= 0 \
  sum vb(F)_y &= 0.
$

== 3D Force Systems
Forces in 3D can be resolved into $x, y, z$ components.
$
  sum vb(F)_x &= 0 \
  sum vb(F)_y &= 0 \
  sum vb(F)_z &= 0.
$

Be very careful with the signs of the forces.

== Solving Equilibrium Problems
With multiple forces and their direction vectors (_not unit vectors_) $vb(r)$, $ F = vb(r) X "or" Y "or" Z ... $ where $X, Y, Z... = F / r$.
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
Intuitively, magnitude of the moment of a force $vb(F)$ about point $O$ is
$
  M_O = F d
$ where $d$ is the perpendicular distance from $O$ to the line of action of $vb(F)$.

Multiple moments? Just sum them up.

By convention (curl of fingers in the Right Hand Rule), positive moments point to the positive z axis, counterclockwise.

To understand rotation in a simple way, think of (or actually do) opening a door at different points in different directions.

Now, be reminded that the cross product of two vectors produces a vector perpendicular to the plane of the two vectors.

=== Cross Product
Samely, more in MATH 152.
$
  vb(A) times vb(B) &= matrixdet(
    vu(i), vu(j), vu(k);
    A_x, A_y, A_z;
    B_x, B_y, B_z;
  ) \
  &= (A_y B_z - A_z B_y) vu(i) - (A_x B_z - A_z B_x) vu(j) + (A_x B_y - A_y B_x) vu(k)
$ which is perpendicular to both $vb(A)$ and $vb(B)$.

And it is non-commutative.
$
  vb(C) &= vb(A) times vb(B) \
  -vb(C) &= vb(B) times vb(A)
$

It is mandated that we show construction of the determinant in exams even if we use calculators.

== Vector Formulation of Moment
$
  vb(M)_O &= vb(r) times vb(F)
$ where $vb(r)$ is the position vector of the point of application of $vb(F)$ relative to $O$, in other words, _any_ vector from $O$ to the line of action of $vb(F)$.

The magnitude of $vb(M)_O$ is then
$
  M_O &= r F sin(theta) \
  &= F d \
  vb(M)_"axis" &= vb(u)_a_x times (vb(r) times vb(F)) \
  &= vb(u)_a_x times vb(M)_O "(this can commutate)".
$

Using our recent knowledge of Cartesian vectors and cross products, we can write the moment as
$
  vb(M)_O &= matrixdet(
    vu(i), vu(j), vu(k);
    r_x, r_y, r_z;
    F_x, F_y, F_z;
  )
$

== Moment of a Couple
/ Couple: A pair of forces of equal magnitude, opposite direction, and parallel lines of action.

$
  vb(M)_"couple" &= vb(r)_A times vb(-F) + vb(r)_B times vb(F) \
  M_"couple" &= F d
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
  vb(M)_"couple" &= vb(M)_A + vb(M)_B.
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
  vb(F)_R "and" vb(M)_O "at" O = vb(F)_R "with distance" M_O / F_R.
$

=== Reduction to a Wrench
Given arbitrary forces and moments, we can reduce them to a single force and a single moment.
+ Regard the resultant force as a baseline, moments parallel to the force can be eliminated by moving the force to a distance $d = M_perp slash F_R$.
+ Move the parallel moment to the resultant force.

When solving for the resultant force, first setup an imaginary point $P$ as our resultant force point, then solve for the resultant force and moment about $P$.
Make use of the fact that the resultant moment must be parallel to the resultant force.

= Equilibrium of a Rigid Body
/ Internal Forces: Forces that hold the particles of a body together.
/ External Forces: Forces that act on the body as a whole.

For equilibrium, we do not consider internal forces, because they always occur in pairs and cancel each other out.

In equilibrium, the sum of the forces and moments acting on a rigid body is zero, in other words, vanish.
$
  sum vb(F) = 0 \
  sum vb(M)_O = 0.
$
It does not matter where the point $O$ is.

When a body is in equilibrium, it is in both translational and rotational equilibrium.
Typically, it is supported by something, and the forces and moments include the reactions of the supports.
If a support restricts translation, it produces a reaction force, and if it restricts rotation, it produces a reaction moment.

== Types of Supports
- Roller: Restricts translation in one direction.
- Ball and socket: Restricts translation in all directions.
- Single journal bearing: Only allows translation in one direction and rotation about that direction.
- Double journal bearing: Only allows translation in two directions, _does not restrict rotation directly, but does through restricting translation, which means *no reactant moment*_. The same for other journal bearings.
- Single journal bearing with square shaft: Only allows translation in one direction.
- Single thrust bearing: Only allows rotation in one direction.
- Single smooth pin: Only allows rotation about the pin.
- Single hinge: Only allows rotation about the hinge.
- Fixed support: Restricts translation and rotation in all directions.

The translation and rotation restricted correspond to the reaction forces and moments produced by the support.

= Friction
/ Friction: Force of resistance acting on a body that prevents or retards slipping of body or surface with which it is in contact.
/ Fluid friction: Contacting surfaces separated by film of fluid (won’t consider here).
/ Dry friction: No lubricating fluid between surfaces of body in contact.
/ Coefficient of static friction ($mu_s$): the magnitude of friction per normal force when a body is static.

The cause of dry friction is the rough surfaces in contact.
There are little, microscopic bumps: 'teeth' and 'valleys', which they clutch into each other to hinder movement.
Since they have to 'clutch in', there is a component of the resultant force perpendicular to the contact surface, the normal force $vb(N)$.
Of course, then there is the friction $vb(F)$, tangent to the contact surface and opposite to the (intended) movement.

#figure(
  caption: [Dry friction],
  image("assets/friction.png", width: 33%),
)

Look at the example above. Assume the block is in equilibrium, we can determine where $vb(N)$ is acting, point $O$, by considering moments.
$
  W x &= P h \
  x &= (P h) / W.
$

#block(inset: 0.65em, stroke: red)[
  Other then slip or not slip, the body can also tip!
]

/ Impending motion: No motion but friction is at its maximum, any larger propelling force will cause the body to slip.
  Only when at impending motion, $ F_s = mu_s N. $
/ Angle of static friction: The angle between the resultant force by friction and the normal force and the normal force.

It is important to notice that, only when the body is _about_ to slip, the above formula is true.
In other cases, $F_s$ depends on the propelling force.

/ Kinetic friction: Friction when a body is in motion, typically _smaller_ than its static friction.
/ Coefficient of kinetic friction ($mu_k$): Similar to $mu_s$ but for kinetic friction.

#block(inset: 0.65em, stroke: red)[
  When there are multiple ways a body can slip, calculate the $P$ required for each case, then choose the one with the _smallest_ $P$.
]

#block(inset: 0.65em, stroke: red)[
  When using $F = mu N$, the direction drawn must be correct!
  Otherwise, no, it can be wrong and we correct it later according to the sign.
]

= Kinematics of a Particle
From now on, we need to consider motion of bodies, which would require a bit of calculus.

/ Velocity: Rate of change of position with respect to time.
  $ v = dv(s, t) $
/ Acceleration: Rate of change of velocity with respect to time.
  $ a = dv(v, t) = dv(s, t, 2) $

For their instantaneous values, take $lim_(Delta t -> 0)$.

Given the definition of acceleration and velocity, we can get that
$
  a dd(s) = dd(s) dv(v, t) = dv(s, t) dd(v) = v dd(v).
$

If acceleration is known as a function of time, the relationship above can help us determine the velocity.

A particle has position vector $vb(r) = (x vb(i), y vb(j), z vb(k))$, and its velocity is the first derivative of position regarding time, $vb(v) = dv(vb(r), t) = (dv(x, t), dv(y, t), dv(z, t))$.

These differentiation with respect to time are notated using overdot, $dot(x) = dv(x, t)$.

Acceleration is then the derivation of velocity, or the second degree derivation of position: $vb(a) = dv(vb(v), t) = dv(vb(r), t, 2) = (dv(v_x, t), dv(v_y, t), dv(v_z, t))$.

== Projectile Motion
Projectile or trajectory motion, is something being thrown into the air and affected by gravity.
We ignore air resistance for now.

Velocity on the x-axis will not change, as there is no force acting in that direction,
$
  a_x &= 0 \
  v_x &= (v_0)_x.
$
Velocity on the y-axis will change according to the gravitational acceleration, $g = qty("9.81", "m/s^2")$,
$
  a_y &= -g \
  v_y &= (v_0)_y - g t \
  y &= y_0 + (v_0)_y t - 1 / 2 g t^2, \
  v_y^2 &= (v_0)_y^2 - 2 g (y - y_0)
$

And generally,
$
  v^2 = v_0^2 + 2 a (s - s_0).
$

Now we can describe a trajectory motion as a function for $y$ of $x$:
$
  y(x) &= a (x - x_0)^2 + b (x - x_0) + y_0 \
  "where" a &= - g / (2 v_0^2 cos^2(theta_0)) \
  b &= tan(theta_0).
$

= Kinetics of a Particle: Force and Acceleration
A particle path can be seen comprising of differential arc of a circle with radius, $rho$, known as the radius of curvature, and a center $O'$, the center of curvature.

In limit of a straight path, $rho -> oo$.

In 2D space, for a particle with path $f(x)$, the radius of the fractional path curvature is
$
  rho = [1 + (dv(y, x))^2]^(3 / 2) / dv(y, x, 2).
$

Velocity of the particle, in such cases, is
$
  v &= dd(s, t) = dot(s) \
  vb(v) &= v vb(u)_t.
$
There is no normal component to it.

Acceleration is then
$
  vb(a) &= dv(vb(v), t) \
  &= dv(,t) v vb(u)_t \
  &= dot(v) vb(u)_t + v dot(vb(u)_t) \
  dot(vb(u)_t) &= dv(,theta) vb(u)_n \
  &= dot(theta) vb(u)_n \
  dot(theta) &= v / rho \
  vb(a) &= dot(v) vb(u)_t + v^2 / rho vb(u)_n \
  a_n &= v^2 / rho \
  a_t &= dot(v) \
  a &= norm(vb(a)) \
$

In a straight-line motion, $rho -> oo$, $a_u = 0$.
In a constant-speed motion, $dot(v) = 0$, $a_t = 0$.
We can see that the tangential acceleration represents the change in magnitude of velocity, and the normal acceleration represents the change in direction of velocity.

== Polar and Cylindrical Coordinates
Instead of $x, y$, a polar coordinate system holds $r and theta$, which $r$ is the distance from the origin and $theta$ is the angle from the positive x-axis.
The position vector would be $vb(r) = r vb(u)_r$.

For an object which position is described by $vb(r)$,
$
  vb(v) &= dot(vb(r)) \
  &= dot((r vb(u)_r)) \
  &= dot(r) vb(u)_r + r dot(vb(u)_r),
  dot(vb(u)_r) &= dot(theta) vb(u)_theta, \
  vb(v) &= v_r vb(u)_r + v_theta vb(u)_theta.
$

Separating the velocity,
$
  v_r &= dot(r) \
  v_theta &= r dot(theta) \
  vb(v)_r &= dot(r) vb(u)_r \
  vb(v)_theta &= (r dot(theta)) vb(u)_theta.
$

And knowing that
$
  dot(vb(u)_theta) &= - dot(theta) vb(u)_r \
  dot(vb(u)_r) &= dot(theta) vb(u)_theta.
$
We have
$
  vb(a) &= (dot.double(r) - r dot(theta)^2) vb(u)_r + (r dot.double(theta) + r dot(r) dot(theta)) vb(u)_theta \
  a_r &= dot.double(r) - r dot(theta)^2 \
  a_theta &= r dot.double(theta) + 2 dot(r) dot(theta).
$

Note that usually $theta$ is a functions of time, so when deriving functions of $theta$, e.g. $r$, we should apply chain rule properly.

== Absolute Dependent Motion: Two Particles
/ Datum: A fixed location from where displacement is measured.

In a pulley system consists ropes and pulleys.
Note that the lengths of the ropes do not change, this can form equations in solving problems.

== Translating Axis
For observer A and B,
$
  vb(v)_(B slash A) &= vb(v)_B - vb(v)_A \
  vb(a)_(B slash A) &= vb(a)_B - vb(a)_A.
$

Hence, in perspective of A,
$
  vb(v)_B &= vb(v)_(B slash A) + vb(v)_A \
  vb(a)_B &= vb(a)_(B slash A) + vb(a)_A.
$

Knowing objects' angle velocity to their axis can help us triangulate their velocity to other observers.

== The Equation of Motion
A reminder that, in FPS system, the unit of mass is slug, in $unit("ft/s")$.

The Newton's Second Law, known as the equation of motion, is
$
  vb(F) = m vb(a).
$

Different from before, the equation is vectorized so to include the directions of force and acceleration.

For multiple accelerations, the resultant force is the vector sum of each force, like usual:
$
  sum vb(F) = m vb(a).
$

The forces include gravitational force, friction and others manually exerted.

== Pulley Systems
To analyse a pulley system, there are a few equalities we need to know:
- Tension in a rope is constant.
- Length of a rope is constant.
- Position of a fixed gear is constant.

These may seem too obvious, but recounting can really help in solving problems.

// = Kinetics of a Particle: Work and Energy


// = Kinetics of a Particle: Impulse and Momentum



#termlist
