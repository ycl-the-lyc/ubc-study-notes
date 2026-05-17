#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    MATH 152 Study Notes \
    #underline[Linear Systems]
  ],
  author: "Yecheng Liang",
)
#import "@preview/physica:0.9.5": *
#show: super-T-as-transpose // Render "..^T" as transposed matrix
#let conj = math.overline
#let kern = math.cal([N])

#import "@preview/equate:0.2.1": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")

#import "@preview/unify:0.7.1": unit, qty, qtyrange, num, numrange

#import "@preview/cetz:0.3.1": canvas, draw
#import "@preview/cetz-plot:0.1.0"
#let style-vec = (
  mark: (
    end: "stealth",
  ),
)
#let add-vec = cetz-plot.plot.add.with(style: style-vec)

#set math.vec(delim: "[")
#let det = "det"
#set math.mat(delim: "[")
#let imat = identitymatrix.with(delim: "[", fill: 0)
#let ones(order) = identitymatrix(order, delim: "[", fill: 1)

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

= Scalars
A scalar $x$ has
$
  x in RR.
$

In this course,
$
  x in CC space ("complex numbers")
$
is also a scalar.

You can also say a scalar is a 1x1 matrix.

= Vectors
A vector is 2 or more scalars arranged in a predetermined order.

When written, an arrow is placed above the variable to indicate that it is a vector.
$
  x "is a normal variable," \
  va(x) "is a vector."
$

In printed media, vectors are often written in boldface.
$
  vb(x) "is a vector."
$

== Vector Dimensions
The number of scalars in a vector is called the dimension of the vector.
For example,
$
  vb(a) = vec(1, 2) "is a" RR^2 \
  vb(b) = vec(1, 2, 3, 4) "is a" RR^4
$

== Linear Combinations
A linear combination of vectors is the sum of the vectors multiplied by scalars. Each vector is a orthogonal basis vector.

For example, $vb(a) in RR^3$ can be written as
$
  vb(a) = x vb(i) + y vb(j) + z vb(k)
$ where $vb(i)$, $vb(j)$, $vb(k)$ are the orthogonal basis vectors for a 3 dimensional space.

== Vector Operations

=== Vector & Scalar
Yeah just do it.

== Addition & Subtraction

For addition and subtraction, simply add or subtract the corresponding scalars.
Commutate, associate and distribute them.

// #canvas({
//   import cetz-plot: *
//
//   plot.plot(
//     size: (4, 4),
//     axis-style: "left",
//     x-tick-step: 1,
//     y-tick-step: 1,
//     x-max: 6,
//     y-max: 6,
//     {
//       add-vec(((0, 0), (1, 3)), label: $vb(a)$)
//       add-vec(((0, 0), (3, 1)), label: $vb(b)$)
//       add-vec(((1, 3), (5, 5)), label: $vb(c)$)
//       add-vec(((3, 1), (5, 5)), label: $vb(d)$)
//
//       add-vec(((0, 0), (5, 5)), label: $vb(e)$)
//     },
//   )
// })

$
  vb(a) + vb(b) &= vb(c) + vb(d) = vb(e) \
  vb(e) - vb(a) &= vb(b) \
  vb(e) - vb(c) &= vb(d)
$

By subtracting vectors, we can find the vector that connects the two vectors.
The length of the connecting vector is the distance between the two vectors.

=== Dot Product
The two vectors must have the same size/dimension.
The dot product of two vectors is the sum of the products of the corresponding scalars.

$
  vb(a) dot vb(b) = a_1 b_1 + a_2 b_2 + a_3 b_3.
$

Note that the result is a scalar.

Dot product is commutative (even with scalars) and distributive.

=== Angle Between Vectors
The angle between two vectors can be found using the dot product.
$
  cos(theta) = (vb(a) dot vb(b)) / (norm(a) norm(b))
$ where $theta$ is the smallest angle between the two vectors. \
(This can be proven using Pythagorean theorem.)

If neither of the vectors is the zero vector, and the dot product is 0, then the vectors are orthogonal (perpendicular) to each other.

Given $vb(a) = vec(1, 1, 1) "and" vb(b) = vec(1, -1, 1)$, the angle between them is
$
  cos(theta) &= (1 times 1 + 1 times -1 + 1 times 1) / (sqrt(1^2 + 1^2 + 1^2) times sqrt(1^2 + -1^2 + 1^2)) = 1 / 3 \
  theta &approx qty("1.23", "rad") = 70.53 degree.
$

Note: if the dot product of two vectors $vb(a) dot vb(b) = 0$, then vectors $vb(a)$ and $vb(b)$ are *perpendicular*.

=== Vector Length
The length of a vector is the square root of the sum of the squares of the scalars in the vector, which is also the square root of the dot product of the vector with itself.
It can be notated as $||vb(a)||$.

$
  norm(a) = sqrt(vb(a) dot vb(a)) = sqrt(a_1^2 + a_2^2 + a_3^2).
$

For example, $||vb(x) - vb(c)|| = 1$ means all points which are 1 unit away from $vb(c)$, a circle.

=== Projection
The projection of $vb(a)$ onto $vb(b)$ is the vector that is parallel to $vb(b)$ and has the same length as the projection of $vb(a)$ onto $vb(b)$.
$
  "proj"_vb(b) vb(a) &= "'shadow' length of" vb(a) "on" vb(b) times "direction of" vb(b) \
  &= (vb(a) dot vb(b)) vb(b) / norm(b)^2 \
  &= (vb(a) dot vu(b)) vu(b)
$

Here's a proof:

The projection of $vb(a)$ onto $vb(b)$ can be represented as a scalar multipled by $vb(b)$, where $vb(b) != 0$.
$ "proj"_vb(b) vb(a) = s vb(b) $ <eq:projection>

We know that the perpendicular vector, connecting point on $vb(b)$ to the end of $vb(a)$, can be denoted as $vb(a) - s vb(b)$.

Hence, we know that
$ (vb(a) - s vb(b)) dot vb(b) = 0 $
$ vb(a) dot vb(b) - s (vb(b) dot vb(b)) = 0 $
$ s = (vb(a) dot vb(b)) / (vb(b) dot vb(b)) $
Plugging back into @eq:projection, we hence get:
$ "proj"_vb(b) vb(a) = (vb(a) dot vb(b)) / norm(b)^2 vb(b) $

Further, a vector $vb(a)$ has $vb(a) / norm(a) = vu(a)$, so
$
  (vb(a) dot vb(b)) / norm(b)^2 vb(b) &= (vb(a) dot vu(b)) vu(b).
$

=== Parallelogram
A parallelogram is a quadrilateral with opposite sides parallel.
Given two vectors $vb(a)$ and $vb(b)$, the area of the parallelogram formed by them is
$
  A &= "base" times "height" \
  &= norm(a) norm(b) sin(theta) \
  &= norm(a) norm(b) cos(pi / 2 - theta) \
  &= vb(a_perp) dot vb(b)
$
where $vb(a_perp)$ is the vector perpendicular to $vb(a)$.

== Matrices
A matrix is a rectangular array of scalars.
It can also be thought of as rows of vectors.
$
  mat(a, b; c, d).
$

=== Determinant of 2x2 Matrix
Given a matrix $vb(a) = mat(a, b; c, d)$, the determinant of a 2x2 matrix is
$
  det vb(a) equiv mdet(a, b; c, d) &= a d - b c.
$

=== Determinant of 3x3 Matrix

Let a matrix be defined as:
$
  mat(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3)
$

The minor matrix for an element is the 2x2 matrix obtained from deleting the row and column that element is in.
\ e.g. $ "minor matrix of" f = mat(a_1,a_2;c_1,c_2) $


One way to find the determinant is by row expansion, which is taking each of the elements in a row OR column and multiplying it by the determinant of the minor matrix. Take note of the alternating signs. (This is knkown as "Laplace Expansion" for anyone curious).\

The signs for computing the sum of each element x its minor is:
$ mat(+,-,+;-,+,-;+,-,+) $

If you pick row 1:
$
  mdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &= a_1 mdet(b_2, b_3; c_2, c_3) - a_2 mdet(b_1, b_3; c_1, c_3) + a_3 mdet(b_1, b_2; c_1, c_2). #<eq:det-3x3>
$

If you pick row 2:
$
  mdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &=
  - b_1 mdet(a_2, a_3; c_2, c_3) + b_2 mdet(a_1, a_3; c_1, c_3) - b_3 mdet(a_1, a_2; c_1, c_2).
$

If you pick column 2:
$
  mdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &=
  -a_2 mdet(b_1, b_3; c_1, c_3) + b_2 mdet(a_1, a_3; c_1, c_3) - c_2 mdet(a_1, a_3; b_1, b_3).
$

*Tip*: pick any row / column with the *most zeroes*.


The determinant of a 3x3 matrix is
$
  mdet(a, b, c; d, e, f; g, h, i) = a e i + b f g + c d h - c e g - b d i - a f h \
  "(try find a pattern here!)"
$

This can be visualised as putting copying the first two columns onto the right, then for each 3 number diagonal in the shape of a backslash, take the product of the three numbers and sum them, and for each 3 number diagonal in the shape, subtract the each product from the previous sum.


// may add smth here //


For a parallelogram formed by two vectors $vb(a) "and" vb(b)$, the area is the absolute value of the determinant of the matrix formed by the vectors:
$
  A_"parallelogram" = mdet(a_1, a_2; b_1, b_2).
$

For example, for $vb(a) = vec(1, -2) "and" vb(b) = vec(3, 5)$, the area of the parallelogram is
$
  A_"parallelogram" = mdet(1, 3; -2, 5) = 11.
$


//ADD 4X4 MATRIX DETERMINANT //


=== Linear Dependence
//TODO

=== Cross Product
The cross product of two vectors is a vector that is orthogonal to the two vectors, \
a.k.a. the normal vector of the plane formed by the two vectors, \
a.k.a. the vector that is perpendicular to the two vectors.

Given $vb(a) = vec(a_1, a_2, a_3) "and" vb(b) = vec(b_1, b_2, b_3)$, the cross product is
$
  vb(a) times vb(b) &= mdet(vu(i), vu(j), vu(k); a_1, a_2, a_3; b_1, b_2, b_3) \
  &= vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1).
$

In a Right Hand (RH) coordinate system, the cross product is the vector that points in the direction of the thumb when the fingers of the right hand curl from $vb(a)$ to $vb(b)$.
In other words, the cross product is the vector that is orthogonal/perpendicular to the two vectors.
$ vb(a) dot (vb(a) times vb(b)) = 0 $

=== Volume of Parallelepiped
The volume of a parallelepiped formed by three vectors $vb(a)$, $vb(b)$, and $vb(c)$ is the absolute value of the determinant of the matrix formed by the vectors.
$
  V_"parallelepiped" &= "base area" times "height" \
  &= A_"parallelogram" times cos(theta) norm(c) \
  &= mdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) \
  &= abs(vb(a) dot (vb(b) times vb(c))).
$

= Lines, Curves and Planes in Vector Form

== Lines in 2D Space
There is a line $L$.
Take a point on the line, $vb(p) = vec(x_0, y_0)$, then take a vector that is parallel to the line, $vb(l) = vec(i, j)$.
The line can be represented as
$
  vb(x) = vb(p) + t vb(l)
$
where $t in RR$.

Alternatively,
$
  cases(
  x = i t + x_0,
  y = j t + y_0
)
$

The directional vector $vb(l)$ is can be compared to other vectors to determine if they are parallel or perpendicular, or neither.
- If $vb(l)_1 dot vb(l)_2 = 0$, then the two vectors are perpendicular.
- Else, if $vb(l)_1 = c vb(l)_2$ where $c$ is a scalar constant, then the two vectors are parallel.

Where there is a line, there is a normal vector to the line, $vb(n)$.
Thus the line can also be represented as
$
  vb(n) dot (vb(x) - vb(p)) &= 0 \
  vb(n) dot vb(x) &= vb(n) dot vb(p).
$

If we have a line $x - 2y + 3z = 0$, we know that the LHS is not 0, while the RHS $vb(n) dot vb(p) = 0$, $vb(p) = vec(0, 0, 0)$, so the line must pass through the origin.
Additionally, the normal vector is $vec(1, -2, 3)$.

== Planes in 3D Space
There is a plane $S "in" RR^3$.
Take a point on the plane, $vb(p) = vec(x_0, y_0, z_0)$.
If $vb(x)$ is a point on the plane, $vb(x) - vb(p)$ must be perpendicular to the normal vector of the plane from origin, $vb(n)$.
Thus the plane can be represented as
$
  vb(n) dot (vb(x) - vb(p)) = 0 " or " vb(n) dot vb(x) = vb(n) dot vb(p).
$
Similarly, if we have a plane $x - 2y + 3z = 0$, we know that the LHS is not 0, while the RHS $vb(n) dot vb(p) = 0$, $vb(p) = vec(0, 0, 0)$, so the plane must pass through the origin.
Additionally, the normal vector is $vec(1, -2, 3)$.

The plane can also be seen as:
$
  a x + b y + c z = d.
$
where $vec(a, b, c) = vb(n)$ and $d = vb(n) dot vb(p)$.
We can see that this is an expansion of the $vb(n) dot vb(x) = vb(n) dot vb(p)$ form.

Alternatively, we can use the parametric form:
$
  vb(x) - vb(p) = s vb(u) + t vb(v)
$
where $vb(u)$ and $vb(v)$ are two vectors on the plane and $s, t in RR$.

For example, a plane $S$ has parametric form
$
  vb(x) = vec(1, 2, 1) + s vec(1, 0, 1) + t vec(1, 1, 0).
$
To find the normal representation, we can do a cross product of the two vectors on the plane to get the normal vector.
$
  vb(n) &= vec(1, 0, 1) times vec(1, 1, 0) \
  &= mdet(vu(i), vu(j), vu(k); 1, 0, 1; 1, 1, 0) \
  &= vec(1, -1, -1).
$

Another example, given plane $S$'s equation $x + 2y + 3z = 6$, we can find its parametric form by locating three points on the plane, then finding two vectors connecting the dots.

However, a better way is to restrict two of the variables to 0 and the third to 1.
$
  x + 2y + 3z &= 6 \
  y &= s \
  z &= t \
  x &= 6 - 2y - 3z \
  &= 6 - 2s - 3t.
$ $
  vb(x) = vec(6, 0, 0) + s vec(-2, 1, 0) + t vec(-3, 0, 1).
$

=== Distance from Point to Plane
The distance from a point $P(x_0, y_0, z_0)$ to a plane $a x + b y + c z = d$ is
$
  d_"distance" = abs(a x_0 + b y_0 + c z_0 - d) / sqrt(a^2 + b^2 + c^2).
$
//TODO proof

== Lines in 3D Space
3D line $L$ can be written as
$
  vb(x) = vb(p) + t vb(l),
$ the same as in 2D space.

The line can also be represented as the intersection of two planes.
$
  cases(
    vb(n)_1 dot vb(x) = vb(n)_1 dot vb(p)_1,
    vb(n)_2 dot vb(x) = vb(n)_2 dot vb(p)_2
  ) \
  vb(l) = vb(n)_1 times vb(n)_2.
$

Example: given a line $L$ with
$
  cases(
    x + y + z = 3,
    x - y + 2z = -7
  )
$
Firstly, the planes' normals are obviously
$
  vb(n)_1 = vec(1, 1, 1) \
  vb(n)_2 = vec(1, -1, 2).
$
So we can have $vb(l)$
$
  vb(l) = vb(n)_1 times vb(n)_2 = mdet(vu(i), vu(j), vu(k); 1, 1, 1; 1, -1, 2) = vec(3, -1, -2).
$
Let $z = 0$,
$
  cases(
    x + y = 3,
    x - y = -7
  ) \
  cases(
    x = -2,
    y = 5
  ).
$
Thus, $vb(p) = vec(-2, 5, 0)$ is on $L$.
$
  vb(x) = vec(-2, 5, 0) + t vec(3, -1, -2).
$

Inversely, given a line $L$ with
$
  vb(x) = vec(1, 2, 1) + t vec(1, 1, 2),
$
we can find two planes that intersect at the line.
Look for two combinations of $t = x, y, z$ that when plugged in, will remove $t$ from the equation.
That will give us two planes.

=== Projection of a Line onto A Plane
Let $vb(a)$ be a line and $S$ be a plane in 3D space.

In case that $S$ is one of the coordinate planes, the projection is simple enough (taught in PHYS 170).
$
  vb(a)_"proj on xy-plane" = vec(a_1, a_2, 0)
$ and so for the other two planes.

In general, the projection in 3D space resembles the projection in 2D space.
$
  vb(a)_parallel &= vb(a) - vb(a)_perp \
  &= vb(a)_"proj"
$

= Systems of Linear Equations
A system of linear equations is a set of equations that can be written in the parametric form
$
  cases(
    a_11 x + b_12 y + c_13 z = d_1,
    a_21 x + b_22 y + c_23 z = d_2,
    a_31 x + b_32 y + c_33 z = d_3
  )
$ where $a_(i j), b_i, (i, j in (1, 2, 3)) in RR$, which $i$ is for row and $j$ is for column.

Notice that each equation defines a plane in 3D space.
The planes can intersect at a point, form a line, or (have 2 or more of them) be parallel.

== Linear Dependence and Independence
/ Linear Dependence (LD): Non-zero vectors which are parallel to each other, or can be expressed as a scalar multiple of each other, or most generally, $s_1 vb(a)_1 + s_2 vb(a)_2 + ... = vb(0)$ can be true when _not all_ $s$'s are 0. \
  In 2D geometry, the parallelogram formed by two LD vectors would have 0 area.
/ Linear Independence (LI): Non-zero vectors which satisfy none of the LD requirements.
/ Linear Combination: A vector expressed as a sum of scalar multiples of other vectors.
/ Basis: A set of LI vectors that can be used to express any vector in the space.
  In an $RR^n$ space, the basis has $n$ vectors.
  Hence, a set of vectors are definitely LD if there are more than $n$ vectors in the set.

#block(stroke: red, inset: 0.65em)[
  If a set of vectors are LD, any subset of them _is possible to be_ LI.
]

For example,
$
  vec(1, -2, 3) "and" vec(-2, 4, -6) &"are LD" \
  vec(1, -2, 3) "and" vec(1, 1, 1) &"are LI".
$

To check if a set of vectors are LI, we can form a matrix with the vectors as _rows_ and find the determinant.
If the determinant is not 0, then the vectors are LI.

For example,
$
  mdet(1, 0, 1; 1, -1, 2; 1, 1, 1) = 1 eq.not 0,
$ so $vec(1, 0, 1), vec(1, -1, 2) "and" vec(1, 1, 1)$ are LI.

For 3 3D vectors, the other way is to check the volume of the parallelepiped formed by the vectors, $abs(vb(a) times (vb(b) dot vb(c)))$.
If the volume is not 0, then the vectors are LI.

== Solving Systems of Linear Equations
Previously, we solve systems of linear equations by substitution or elimination. (No way I'm explaining elimination here.)

Two equations and two unknowns are good, how about three for each? A hundred for each?
This is when matrices come in handy.

Using elimination, we are essentially multiplying the equations by a scalar and adding them together. Recall that this is a linear combination of the equations. If the system is solvable, we must be able to express one equation as a linear combination of the others.

To solve the system, look at the following example:
$
  cases(
    x_1 + x_2 + x_3 = 4,
    x_1 + 2x_2 + 3x_3 = 9,
    2x_1 + 3x_2 + x_3 = 7
  )
  \
  cases(
    (2) = (2) - (1),
    (3) = (3) - 2(1)
  )
  space.quad
  cases(
    x_1 + x_2 + x_3 = 4,
    x_2 + 2x_3 = 5,
    x_2 - x_3 = -1
  )
  \
  ...
$

How about we stop copying the $x$'s and write the coefficients and right-hand-side in a matrix?
Put coefficients in each row into rows to form a matrix, and the right-hand-side into an augmented column.
$
  mat(
    2, 1, 3, 1;
    4, 5, 7, 1;
    2, -5, 5, 7;
    augment: #3
  )
  stretch(->)^((2) = (2) - 2(1))_((3) = (3) - (1))&
  mat(
    2, 1, 3, 1;
    0, 3, 1, 5;
    0, -6, 2, -8;
    augment: #3
  )
  \
  stretch(->)^((3) = (3) + 2(2))_"\"row echelon form\""&
  mat(
    2, 1, 3, 1;
    0, 3, 1, 5;
    0, 0, 4, 2;
    augment: #3
  )
  \
  stretch(->)^((3) = (3) slash 4)&
  mat(
    2, 1, 3, 1;
    0, 3, 1, 5;
    0, 0, 1, 1/2;
    augment: #3
  )
  \
  stretch(->)^"substitute back"_(x_3 = 1 slash 2)&
  cases(
    x_1 = -1,
    x_2 = 3/2,
    x_3 = 1/2
  )
$
Voila!
This is very similar to the Gaussian elimination we learned probably in high school, but there are reasons why we do it this way.

Also, the matrix with the weird lines is called the augmented matrix.

/ Row Echelon Form (REF): A matrix where the leading element of each row is to the right of the leading element of the row above it.

To write a matrix in row echelon form, we need to make sure that:
- The all-zero rows are at the bottom.
- There are no identical LHS rows.
- There are increasing number of zeroes from upper to lower rows.

When the last row is all zeros, we cannot give a unique solution to the system.
Instead, we assign a parameter, like $t$, to the last variable and solve for the others.

For example,
$
  mat(
    1, 1, 1, 1;
    1, 2, 2, 2;
    2, 3, 3, 4;
    augment: #3
  )
  stretch(->)^((2) = (2) - (1))_((3) = (3) - 2(1))&
  mat(
    1, 1, 1, 1;
    0, 1, 1, 1;
    0, 1, 1, 2;
    augment: #3
  ) \
  stretch(->)^((3) = (3) - (2))&
  mat(
    1, 1, 1, 1;
    0, 1, 1, 1;
    0, 0, 0, 1;
    augment: #3
  ) \
  0x_1 + 0x_2 + 0x_3 =& 1 "(impossible)" \
  "No solution."
$

=== Checking for Linear Dependence by REF
To check if a set of vectors are LD, we can form a matrix with the vectors as *_columns_* and find the REF.

If there is a row of all zeros, then the vectors are LD.

== Distance from Line to Line
Given two lines $L_1$ and $L_2$ in 3D space.
The distance between the two lines is the length of the vector that connects the two lines and is perpendicular to both lines.

Thus, a cross product of the two directional vectors of the lines gives the direction of the connecting vector.

For example, given $L_1: vb(x) = vec(1, 2, 3) + t vec(1, 0, 0)$ and $L_2: vb(x) = s vec(1, 1, 1)$, one can first get the direction of the connecting vector by taking the cross product of the two directional vectors. Then find a point on each line and the connecting vector.

Alternatively, we can find two arbitrary points on each line, connect them, and find the projection of the connecting vector onto the direction of the perpendicular line from one of the points.

== Rank and Solution Structure
/ Rank: The number of LI (non-zero) rows in the REF of matrix, including augmentation.

- If $rank[A] = rank[A|vb(b)]$ and $rank[A] = n$, then the system has a unique solution.
- If $rank[A] < rank[A|vb(b)]$, then the system has no solution.
- If $rank[A] = rank[A|vb(b)] < n$, then the system has infinite solutions.

/ Homogeneous System: A system where the RHS is all zeros.
  0 is always a solution.

/ Reduced Row Echelon Form (RREF): A matrix where the leading element (pivot) of each row is 1 and is to the right of the pivot of the row above it.
  All elements above a pivot are 0.
  Any column without a pivot is a free variable.

To form a matrix in RREF, we can start from a REF matrix and divide each row by the pivot to make it 1, then eliminate the elements above the pivot.

Recall that LD vectors can be expressed as a linear combination of each other.
So to verify if a set of vectors are LD, we can form a matrix with the vectors as columns and find the RREF.
If all columns have pivots, then the vectors are LI.

=== Application in Resistor Networks
We know Ohm's Law, $V = I R$. (If you don't, you should.)

/ Independent loop: A loop with at least one edge that is not part of any other loop.

Each independent loop implies a variable.
Dependent loops are represented by the independent loops.

By Kirchhoff's Laws, the sum of the voltage drops in a loop is 0, and the current entering a node is equal to the current leaving the node.
Use these to form a system of linear equations.

This process can be troublesome for large networks, so below is another way:

*Loop only method*:
+ Identify a number of independent loops that is enough for all unknowns. \
  The loops can be arbitrary, current should conform to the direction of the loop.
+ For each loop, write the sum of the currents times the resistance of the edge as 0.
+ Form a system of linear equations.
+ Move the constants to the RHS and form a matrix.
+ Solve the system using RREF.

=== Application in Chemical Reactions
#[
  #show math.equation: it => {
    show math.equation: math.upright
    show "x": math.italic
    it
  }
  Consider chemical reaction $x_1 C_6 H_12 O_6 + x_2 O_2 => x_3 C O_2 + x_4 H_2 O$.
  Because atoms are conserved, we can form a system of linear equations.
  Then solve it using RREF.
]

=== Application in Traffic Flow
Consider four nodes connected by roads to form a rectangle.
Given incoming traffic for two nodes and out-coming traffic for two other nodes, we can form a system of linear equations to find the traffic flow between the nodes.

You may not find a unique solution out right, but take reality into account, e.g. solutions must be positive.

== Matrix Multiplication
Given two matrices $A$ and $B$ where $A$ has $m$ rows and $n$ columns and $B$ has $n$ rows and $p$ columns, the product $A B$ is a matrix with $m$ rows and $p$ columns.

In principle, the number of _columns_ (_size of row_) in the first matrix must equal the number of _rows_ (_size of column_) in the second matrix for the product to be defined.

For an element in the product matrix $C$,
$
  c_(i j) &= (i^"th" "row of" A) dot (j^"th" "column of" B) \
  &= sum_(k = 1)^(n) a_(i k) b_(k j).
$

For example,
$
  mat(a , b, c; d, e, f)_(2 times 3) mat(x; y; z)_(3 times 1) &= mat(a x + b y + c z; d x + e y + f z)_(2 times 1) \
  mat(x; y; z)_(3 times 1) mat(a , b, c; d, e, f)_(2 times 3) &= "undefined", 1 eq.not 2.
$

Even if $A_(n times n)$ and $B_(n times n)$, $A B eq.not B A$ in general.
Only in the special case of diagonal matrices:
$
  A &= mat(
    a, 0, dots.c, 0;
    0, b, dots.c, 0;
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots.c, c
  ) \
  A B &= B A.
$
There is a type of matrix called the identity matrix, $I$, where
$
  I_n &= mat(
    1, 0, dots.c, 0;
    0, 1, dots.c, 0;
    dots.v, dots.v, dots.down, dots.v;
    0, 0, dots.c, 1
  )_(n times n).
$
We would explore more wonders of the diagonal, identity and triangular matrices later.

Now, we can write linear systems in matrix multiplication form.
$
  cases(
    a_11 x_1 + a_12 x_2 + dots.c + a_13 x_3 = b_1,
    a_21 x_1 + a_22 x_2 + dots.c + a_23 x_3 = b_2,
    dots.v,
    a_31 x_1 + a_32 x_2 + dots.c + a_33 x_3 = b_3
  ) \
  "is equivilant to" \
  mat(
    a_11, a_12, dots.c, a_13;
    a_21, a_22, dots.c, a_23;
    dots.v, dots.v, dots.v, dots.v;
    a_31, a_32, dots.c, a_33
  ) mat(x_1; x_2; dots.v; x_3) = mat(b_1; b_2; dots.v; b_3).
$
Such form has a simple notation:
$
  A vb(x) = vb(b).
$ which $A$ is called the coefficient matrix.

=== Properties of Matrix Multiplication
- Associative: $A (B C) = (A B) C$.
- Distributive: $A (B + C) = A B + A C$.
- Not commutative: $A B eq.not B A$ in general.
- Identity: $I A = A I = A$ where $I$ is the identity matrix.
- Inverse: $A A^(-1) = A^(-1) A = I$ where $A^(-1)$ is the inverse of $A$.
- Transpose: $(A B)^T = B^T A^T$.

=== Powers of Matrices
One numb enough to calculate $M^999$ by $M times M times ...$ would be dumb, we have a smarter way.

We just learned that diagonal matrices behave like scalars in multiplication.
So, if we can make $M$ a diagonal matrix, then we can easily calculate $M^n$, even when $n$ is very large.

How? See @sc:mat-similarity.

== Linear Transformation
/ Linear transformation / map / function: a rule that assigns one output to each input.

For example, given $vb(x) in RR^n$
$
  A vb(x) = vb(y) in RR^m
$ indicates that $A$ is a transformation from $RR^n$ to $RR^m$:
$
  A: RR^n -> RR^m.
$

/ Linearity: A transformation $T: RR ^n -> RR^m$ is linear iff
  $
    T(alpha vb(x)_1 + beta vb(x)_2) = alpha T(vb(x)_1) + beta T(vb(x)_2) \
    "or" \
    T(vb(x)_1 + vb(x)_2) = T(vb(x)_1) + T(vb(x)_2) "and" T(alpha vb(x)) = alpha T(vb(x)).
  $

Thus, all matrix multiplications are linear.

For example,
$
  mat(0, -1; 1, 0) vec(3, 4).
$
In the case above, $vec(0, 1)$ transforms $3$, $vec(-1, 0)$ transforms $4$:
$
  mat(0, -1; 1, 0) vec(3, 4) &= vec(vec(0, 1) vec(-1, 0)) vec(3, 4) \
  &= 3 vec(0, 1) + 4 vec(-1, 0) \
  &= vec(-4, 3).
$
Looks like $vec(3, 4)$ was rotated by $90 degree$ in counterclockwise!

In the example above, we also notice that the transforming matrix was written in forms of vector columns.
=== Column Space of Matrix
Matrix can be expressed as columns space of vectors.
$
  mat(x_1, x_2; y_1, y_2) = mat(vec(x_1, y_1), vec(x_2, y_2)).
$
Matrix multiplication would be the same as individual "vector multiplication", provided that such operation is defined.

So, for an $M_(m times n)$, its column space will be a row of $n$ vectors.
Recall that matrix multiplication is only defined when the number of columns of the first matrix is the same as the number of rows of the second matrix!
$
  mat(vb(a)_1, vb(a)_2, dots.c vb(a)_n) mat(x_1; x_2; dots.v; x_n) = mat(vb(a)_1 x_1, vb(a)_2 x_2, dots.c, vb(a)_n a_n).
$
Write $vb(a)$ as a transformation, $T(e)$, each column of the result becomes an image/transformation of $x$.

#block(inset: 0.65em, stroke: red)[
  *Sanity check*: _projection_ is not a one-to-one operation, so the matrix you use must have a determinant of 0.

  Inverse of a reflection matrix is itself.
  $ A A = A A^(-1) = I. $
]

=== Finding Transformations in 2D Space
Say, we are projecting some vector to a vector with $vb(u)$ at angle $phi$ to the $x$ axis, Of course, we can use the projection formula, but here we want to find the transformation matrix that does the job for us (and it's easier).
Let $vb(e)_1$ and $vb(e)_2$ be vectors on the $x$ and $y$ that projects to $vb(u)$.
$
  M_"proj" &= mat(T(vb(e)_1), T(vb(e)_2)) \
  T(vb(e)_1) &= "Proj"_phi (vb(e)_1) \
  &= cos(phi) vb(u) \
  &= cos(phi) vec(cos(phi), sin(phi)) \
  &= vec(cos^2(phi), sin(phi) cos(phi)) \
  T(vb(e)_2) &= "Proj"_phi (vb(e)_2) \
  &= sin(phi) vb(u) \
  &= sin(phi) vec(cos(phi), sin(phi)) \
  &= vec(sin(phi) cos(phi), sin^2(phi)) \
  M_"proj" &= mat(cos^2(phi), sin(phi) cos(phi); sin(phi) cos(phi), sin^2(phi)).
$
Then, to project any vector $vb(a)$ to $vb(u)$, we can simply put
$
  "Proj"_vb(u) vb(a) = M_"proj" vb(a).
$

To find other transformations, similarly find transformation of each orthogonal vector/basis, then combine them to a column space.

Here is another example: rotation. Let's say we are to find a rotation matrix of $phi$ counterclockwise.
$
  T(vb(e)_1) &= vec(cos(phi), sin(phi)) \
  T(vb(e)_2) &= vec(-sin(phi), cos(phi)) \
  M_"rot" &= mat(cos(phi), -sin(phi); sin(phi), cos(phi)).
$

Yet another one, reflection by function $y = m x$.
$
  phi &= acos((vb(x) dot vb(y)) / (norm(x) norm(y))) \
  "Ref"_phi(vb(x)) &= vb(x)_parallel - vb(x)_perp \
  &= vb(x)_parallel - (vb(x)_parallel - vb(x)) \
  &= 2 vb(x)_parallel - vb(x) \
  &= 2 "Proj"_phi(vb(x)) - vb(x) \
  &= 2 M_"proj"_phi(vb(x)) - I vb(x) \
  &= (2 M_"proj"_phi - I) vb(x) \
  M_"ref"_phi &= 2 M_"proj"_phi - I \
  &= 2 mat(cos^2(phi), sin(phi) cos(phi); sin(phi) cos(phi), sin^2(phi)) - imat(2) \
  &= mat(2 cos(2 phi) + 1, sin(2 phi); sin(2 phi), -cos(2 phi) + 1) - imat(2) \
  &= mat(cos(2 phi), sin(2 phi); sin(2 phi), -cos(2 phi)).
$

=== Finding Transformations in 3D Space
Firstly, reflection.
Given a plane $P: x + y + z = 0$ and a vector $vec(x)$, find the reflection of $vb(x)$ about the plane.
$
  vb(n) &= vec(1, 1, 1) \
  vu(n) &= 1 / sqrt(3) vec(1, 1, 1) \
  "Ref"_P(vb(x)) &= vb(x)_parallel - vb(x)_perp \
  &= (vb(x) - vb(x)_perp) - vb(perp) \
  &= vb(x) - 2 vb(x)_perp \
  &= (I - 2 "Proj"_vu(n)(x)) vb(x) \
  M_"ref"_P &= I - 2 M_T_"proj"_vu(n)(x) \
  "Proj"_vu(n)(vb(e)) &= (vb(e) dot vu(n)) vu(n) \
  &= 1 / 3 vec(1, 1, 1) \
  M_"proj"_vu(n) &= 1 / 3 ones(3) \
  M_"proj"_P &= I - M_"proj"_vu(n) \
  &= 1 / 3 mat(2, -1, -1; -1, 2, -1; -1, 2, -1) \
  M_"ref"_P &= I - 2 M_"proj"_vu(n) \
  &= 1 / 3 mat(1, -2, -2; -2, 1, -2; -2, -2, 1).
$

=== Checking for Linearity
To ensure a one-to-n-one relationship, a transformation matrix's determinant should _not_ be 0.
To be precise, the determinant must be 1 or -1:
when multiplying a matrix to a vector, the resultant vector will have its length be $det times "original length"$.

Given 2 linear transformations $S, T$, then their composition $S compose T$ is also linear.

=== Solving for Orthogonal Transformation
Given
$
  vb(x)_1 = vec(x, y) = c_1 vb(e)_1 + c_2 vb(e)_2 \
  vb(x)_2 = vec(z, w) = c_3 vb(e)_1 + c_4 vb(e)_2.
$
We can first find out how to eliminate one of the $vb(e)$ by solving
$
  alpha vb(x)_1 + beta vb(x)_2 = vec(1, 0) \
  gamma vb(x)_1 + delta vb(x)_2 = vec(0, 1)
$ then solve the resulting linear system.

== Transpose of Matrices
/ Transpose: For a matrix, turning its rows to columns, and columns to rows, notated as $A^T$. In other words, flipping the matrix along its diagonal axis.

For example,
$
  A &= mat(1, 2; 3, 4) \
  A^T &= mat(1, 3; 2, 4)
$

Some nice conclusions:
- $(A B)^T = B^T A^T$.
- If $vb(x), vb(y) in RR^n$ and are columns, then $vb(x) dot vb(y) = vb(x)^T vb(y) = vb(y)^T vb(x)$.
- If $vb(x), vb(y) in RR^n, A = A_(m times n)$, then $vb(y) dot (A vb(x)) = (A^T vb(y)) dot vb(x)$.

Remember again, matrices $A B eq.not B A$.

== Probability Matrices
When we have a system with multiple states, each state being not so stable and has probabilities to switch to other states.
We can represent each state as a probability matrix, $P_(i j)$, for $i$ is the current state, and $j$ is the state that it can switch to.

=== Markov process
Consider a particle that jumps among 3 distinct states at predetermined probabilities in discrete time steps.

Let $x_i(n)$ be the probability of being in state $i$ at time $n$ where $i in [1, 2, 3], n in ZZ$.

As time goes to $n + 1$, $x_i(n + 1) = P_(i 1) x_1(n) + P_(i 2) x_2(n) + P_(i 3) x_3(n)$.
Let $vb(x)(n) = vec(x_1(n), x_2(n), x_3(n))$, then
$
  vb(x)_(n + 1) &= vec(x_1(n + 1), x_2(n + 1), x_3(n + 1)) \
  &= vec(P_11 x_1(n) + P_12 x_2(n) + P_13 x_3(n), P_21 x_1(n) + P_22 x_2(n) + P_23 x_3(n), P_31 x_1(n) + P_32 x_2(n) + P_33 x_3(n)) \
  &= mat(P_11, P_12, P_13; P_21, P_22, P_23; P_31, P_32, P_33) vec(x_1(n), x_2(n), x_3(n)) \
  &= P vb(x)_n.
$
The $P$ is called a transition matrix.
The sum of each of its columns is 1.

This $"Probability" times "State"$ action can be iterated for as many times as pleased, but that is kind of inefficient...
We will talk about that later.

=== Stationary Probability
For a state $vb(x)$, if $P vb(x) = vb(x)$, the state is called a stationary probability, $vb(x)_s$.

To find out $vb(x)_s$ from $P$,
$
  P vb(x)_s &= vb(x)_s \
  I vb(x)_s - P vb(x)_s &= vb(0) \
  (I - P) vb(x)_s &= vb(0).
$
Then, form a linear system and solve.
The elements of $vb(x)_s$ solved are _unlikely to add up to 1_!
Hence, we should scale them to have a sum of 1.

== Matrix Inverse
/ One-to-one linear transformation: $T: RR^n -> RR^m "for" vb(x)_1, vb(x)_2 in RR^n$ is one-to-one if
  $
    T(vb(x)_1) = T(vb(x)_2) " iff " vb(x)_1 = vb(x)_2.
  $

It is not to be confused with many-to-one, which that is valid for functions.

/ Matrix inverse: Matrix $A$ is invertible if $det A eq.not 0$. Matrix $B$ is the inverse of $A$ iff $A B = B A  = I$, and $B$ is then notated as $A^(-1)$.

For a matrix to be invertible, its determinant has to _not be 0_.

A matrix's inverse $A^(-1)$ is the augmented part of the RREF of $[A|I]$,
$
  A: vb(x) -> vb(y) space.quad &<=> space.quad A^(-1): vb(y) -> vb(x) \
  A vb(x) = I vb(y) space.quad &<=> space.quad I vb(x) = A^(-1) vb(y). \
  "rref"[A|I] &= [I|A^(-1)].
$

For $2 times 2$ matrices, there is the other formula:
$
  A &= mat(a, b; c, d) \
  A^(-1) &= 1 / det(A) mat(d, -b; -c, a).
$

An invertible matrix $A_(n times n)$ implies that
- $A: RR^n -> RR^n$ is a one-to-one transformation.
- $vb(x) = vb(0)$ is the unique solution of $A vb(x) = vb(0)$.
- $rank[A] = n$.
- $"rref"[A] = I$.
- Columns or rows of $A$ are LI and forms a basis of $RR^n$.

== Determinant
We have used determinant for a long time, but what exactly is a determinant?

/ Determinant: The 'magnitude' or 'size' of _square_ matrices.

For an $n times n$ matrix, the determinant is the sum of all products of elements at $i j$ where $j$ is permutations of $j in (ZZ^+ <= n)$, meaning that there are $n!$ terms.
Keeping $i$ and permute $i$ also works.

For example,
$
  mdet(a_11, a_12; a_21, a_22) &= a_11 a_22 - a_12 a_21 \
  "has" 2! &= 2 "terms" \
  mdet(a_11, a_12, a_13; a_21, a_22, a_23; a_31, a_32, a_33) &= ... \
  "has" 3! &= 6 "terms".
$

/ Number of permutation: For each permutation $(j_1 j_2 ... j_n)$ of integers $(1, 2, ..., n)$, $sigma(j_1 j_2 ... j_n)$ is the minimal number of pairwise exchanges between the numbers to recover the order $(1 space.sixth 2 ... n)$.

/ Even/odd permutation: The permutations which their permutation number is even/odd.

An odd permutation number adds a negative sign to the term.

But it would be troublesome to calculate the permutation number of each arrangement...

Now recall the row expansion formula like @eq:det-3x3.
How do we know which term to add a minus sign to?
$
  det(A) =& a_(i 1) (-1)^(i + 1) mdet(A_(i 1)) \
  &+ a_(i 2) (-1)^(i + 2) mdet(A_(i 2)) \
  &dots.v \
  &+ a_(i j) (-1)^(i + j) mdet(A_(i j))
$ where $A_(i j)$ is the (i, j)th minor matrix of $A$.
The factor of $a_(i j)$ is called the (i, j)th cofactor.
$
  det(A) = sum_(j = 1)^n a_(i j) c_(i j).
$

/ Cofactor: A number that is obtained by multiplying the minor of the element of any given matrix with -1 raised to the power of the sum of the row and column number to which that element belongs.
  $ c_(i j) = (-1)^(i + j) mdet(A_(i j)) $

Fixing $j$ and progressing $i$ _also works_.
Using this formula, we can get determinants of square matrices of any size!
A reminder that picking the _row or column_ with the most 0s would make the computation easier.

...but, but what if there are not enough 0s in any row or column? I don't want to do math!

In that case, you can instead compute the determinant of an alternate matrix, which is the original matrix, but with a row $(a)$ being itself subtracted by a multiple of another row, $c (b)$, which gives you $(a) = (a) - c (b)$.
The determinant will stay the same.
Use this rule to construct a row with many 0s to your advantage.
_If you happen to time $(a)$ by a coefficient, all its terms should also multiplied with the same coefficient._

This is because determinant is linear in each row or column.

Important properties of determinants:
- $det(A) = det(A^T)$.
- $det(A_(k <-> l)) = - det(A)$ where $A_(k <-> l)$ is $A$ with the $k$th and the $l$th row/column swapped.
- $det(alpha A) = a^n det(A)$ where $A$ is $n times n$.
  $ mdet(c x_1, c x_2; c y_1, c y_2) &= c^2 mdet(x_1, x_2; y_1, y_2). $
- $det(A_(k = l)) = 0$ where $A_(k = l)$ is a matrix with the $k$th and the $l$th row/column identical.
  This can assist in proving the next property by
  $ mdet(x_1, x_2; y_1 + a, y_2 + b) = mdet(x_1, x_2; y_1, y_2) + mdet(x_1, x_2; a, b). $
- $det(A_(k = k + alpha l)) = det(A)$.
- $det(A B C D) = det(A) det(B) det(C) det(D)$.

Fun fact,
$
  mdet(c x_1, c x_2; y_1, y_2) &= c mdet(x_1, x_2; y_1, y_2) \
$

== Matrix Inverse With Determinant
Finally, the ultimate formula for any matrix inverse:
$
  A^(-1) = (1 / det(A)) C^T
$ where $C$ is the cofactor matrix of $A$.

= Complex Numbers
Starting with the infamous square root.
We know that
$
  sqrt(a) "has" cases(
    2 "real roots if" a > 0,
    1 "real root if" a = 0,
    "no real root if" a < 0
  ).
$

So, we define
$
  sqrt(-1) &equiv i \
  i^2 &= -1.
$
The $i$ is the "1" of _imaginary numbers_.
Every imaginary number is a real-valued multiple of $i$, and are usually represented by $z$.

// #figure(
//   caption: [Complex number],
//   canvas({
//     import draw: *
//     import cetz-plot: *
//     plot.plot(
//       name: "ri",
//       size: (4, 4),
//       axis-style: "school-book",
//       x-min: 0,
//       x-max: 2,
//       y-min: -2,
//       y-max: 2,
//       x-label: $Re{z}$,
//       y-label: $Im{z}$,
//       x-ticks: (),
//       x-tick-step: none,
//       y-ticks: (),
//       y-tick-step: none,
//       {
//         plot.add-anchor("a", (1, 1))
//         plot.add-anchor("b", (1, -1))
//       },
//     )
//     circle("ri.a", radius: 1pt)
//     content((rel: (.5, -.5)), $z_1 (1, 1)$)
//     content((rel: (0, .5)), $1 + i$)
//     circle("ri.b", radius: 1pt)
//     content((rel: (.5, -.5)), $z_2 (1, -1)$)
//     content((rel: (0, .5)), $1 - i$)
//   }),
// )
We call $z_2$ the complex conjugate of $z_1$, or $z_2 = conj(z)_1$.

== Complex Number Operations

=== With Scalars
Just do it as usual, with $i$, of course.

=== Multiplication
Same.

=== Length
For $z = a + b i$,
$
  abs(z) &= sqrt(a^2 + b^2) \
  &= sqrt(a^2 - (-1) b^2) \
  &= sqrt(a^2 - (b i)^2) \
  &= sqrt((a + b i)(a - b i)) \
  &= sqrt(z conj(z)).
$

=== Division
For $z_1 = a_1 + b_1 i, z_2 = a_2 + b_2 i$,
$
  z_1 / z_2 &= (a_1 + b_1 i) / (a_2 + b_2 i) \
  &= (z_1 conj(z)_2) / (z_2 conj(z)_2) \
  &= (z_1 conj(z)_2) / abs(z_2)^2 \
  &= ((a_1 b_1 + a_2 b_2) + (a_2 b_1 - a_1 b_2) i) / (a_2^2 + b_2^2).
$

== Euler's Formula
$
  e^(i t) = cos(t) + i sin(t).
$

Through this, we have a way of obtaining $sin$ and $cos$ values:
$
  e^(i t) &= cos(t) + i sin(t) \
  e^(-i t) &= cos(t) - i sin(t) \
  cos(t) &= (e^(i t) + e^(-i t)) / 2 \
  sin(t) &= (e^(i t) - e^(-i t)) / (2i).
$

Now, substitute $t = pi$:
$
  e^(i pi) + 1 = 0
$ because for some reason people love it.

== Polar Representation of Complex Numbers
Put an imaginary number into a $x-y$ coordinate system, let it be $z = x + i y$.

Thus, it has a polar representation
$
  z = rho e^(i theta)
$ where $rho$ is its length and $theta in [0, 2pi]$ is its angle to the positive x-axis.
Why? Use Euler's formula.

To rotate an imaginary number, simply manipulate $theta$, to change its length, modify $rho$.

More specifically, for rotation,
$
  e^(i phi) rho e^(i theta) = rho e^(i (theta + phi))
$

You should be able to convert between the two forms.
Hint: compute length using Pythagoras theorem, angle using $atan$, also, Euler's formula.

== Finding Imaginary Roots
Multiples of $2pi$ would round back to the original angle, hence a root can have multiple solutions.

For example,
$
  z &= root(3, 1) \
  &= e^(i theta) \
  z^3 &= 1 \
  &= (e^(i theta))^3 \
  theta &= 0 "or" plus.minus (2pi) / 3 "or" plus.minus (4pi) / 3.
$

= Eigenvalues and Eigenvectors
/ Eigenvalue and Eigenvector: For a matrix $A$ that defines $RR^n -> RR^n$, a scalar $lambda$ and a vector $vb(v)$ which
  $
    vb(v) &eq.not vb(0) \
    A vb(v) &= lambda vb(v)
  $ are called an eigen-pair, where $lambda$ is the eigenvalue, and $vb(v)$ is the eigenvector.

- An eigenvector is never $vb(0)$.
- The image of an eigenvector is to the same direction as itself, with length factored by $lambda$.
- $vb(v)$ can be replaced by $vu(v)$ and the equality still holds true.
- An $n times n$ matrix often has $n$ eigen-pairs.

== Solving for Eigen-pairs
$
  A vb(v) &= lambda vb(v) \
  A vb(v) - lambda vb(v) &= vb(0) \
  (A - lambda I) vb(v) &= vb(0)
$
$det(A - lambda I)$ must be $0$, else $vb(v)$ would be $vb(0)$, which is not an eigenvector.

$ det(A - lambda I) = vb(0) $ is called the characteristic equation.

/ Algebraic multiplicity (AM): The number of times the _same_ eigenvalue occurs as a root of the characteristic equation.
/ Geometric multiplicity (GM): The number of LI eigenvectors corresponding to an _repeated_ eigenvalue.

For an eigenvalue $lambda$, if $"AM"(lambda) = "GM"(lambda)$, then we found all its eigenvectors!
This also implies that the eigenvectors are LI, hence the basis of all possible eigenvectors.

=== 2D Matrices
$
  det(A - lambda I) &= vb(0) \
  &= mdet(mat(a_11, a_12; a_21, a_22) - imat(2)) \
  &= (a_11 - lambda) (a_22 - lambda) - a_12 a_21 \
  &= lambda^2 - Tr lambda + det(A)
$ where $Tr = trace(A) = a_11 + a_22$.

/ Trace: Only for $A_(n times n)$, the sum of all main diagonal entries, also the sum of all eigenvalues.

Also, determinant is the product of all eigenvalues.

Solving this equation gives us $lambda$.

Then, plug $lambda$ back in, $(A - lambda I) vb(v) = vb(0)$ to form a linear system,.
Solving this linear system (using $"rref"(mat(A - lambda I, vb(0), augment: #1)$) will give you $vb(v)$.
Note that your $lambda$ should depend on an unbounded variable, $t$, as there would be infinite number of solutions, i.e. would solve to a row of 0.
We take the simplest pair, which usually involves an 1.

#block(stroke: red, inset: 0.65em)[
  When solving a homogeneous system, the augmented $vb(0)$ can be omitted.
  Also, multiplying a row by a coefficient would not change the result, as the RHS is all 0.
]

=== 3D Matrices
$
  det(A - lambda I) &= vb(0) \
  &= lambda^3 - Tr lambda^2 + c_2 lambda - det(A)
$ where $c_2 = a_11 a_22 + a_22 a_33 + a_33 a_11 - a_12 a_21 - a_13 a_31 - a_23 a_32$.

== Complex-valued Eigen-pairs
Eigenvalue or eigenvector can contain imaginary numbers.

For example,
$
  A &= mat(1, 2; -1, 3) \
  trace(A) &= 4 \
  det(A) &= 5 \
  lambda^2 - 4 lambda + 1 &= 0 \
  (lambda - 2)^2 &= -1 \
  lambda &= 2 plus.minus i.
$

Thus, we have
$
  cases(
  lambda_+ = 2 + i,
  lambda_- = 2 - i
)
$

Solve the corresponding eigenvectors:
$
  (A - lambda_+ I) v_+ &= vb(0) \
  "rref"(A - lambda_+ I) &= mat(-1 - i, 2; 0, 0)
$
Let $v_+_2 = t$,
$
  (-1 - i) v_+_1 + 2t &= 0 \
  v_+_1 &= (2t) / (i + 1) \
  &= (1 - i) t \
  vb(v_+) &= vec((1 - i) t, t) \
  &= vec(1 - i, 1).
$

Since $lambda_- = conj(lambda_+)$,
$
  v_- = conj(v_+) = vec(1 + i, 1).
$

#block(stroke: red, inset: 0.65em)[
  For conjugate eigenvalues, their eigenvectors are also conjugate.
]

== Solving for Eigen-pairs by Linear Relations
/ Null space / kernel: For all matrix $A_(n times n)$, its kernel is the set of all vectors that are mapped to zero by $A$.
  $ ker(A) := kern(A) := {vb(x) in RR^n: A vb(x) = vb(0)} $

We are supposed to solve
$
  (A - lambda_i I) vb(v) = vb(0).
$
...which is
$
  ker(A - lambda_i I).
$

/ Linear relation (LR): Given a set of $n$ vectors ${vb(c)_1, vb(c)_2, vb(c)_3, ...}$, a linear relation is an _ordered_ set of scalars ${a_1, a_2, a_3, ...}$ that satisfies
  $ a_1 vb(c)_1 + a_2 vb(c)_2 + a_3 vb(c)_3 + ... = vb(0). $
  Thus, we define $vb(a) = mat(a_1, a_2, ..., a_n)^T$ as a LR of vectors above.
  If $vb(a) equiv vb(0)$, then the LR is trivial.

Now, look:

For all $A_(n times n)$,
$
  ker(A) := kern(A) := { "LRs of columns of" A }.
$

A non-trivial kernel is the eigenvector.
Just "notice" that you can cancel out the columns...
Can't notice? RREF, you may even spot the LR midway.

For example,
$
  mat(-1 - i, 2; -1, 1 - i) ->& (-1 - i) underline((1 - i)) = -2 \
  & (-1) underline((1 - i)) = i - 1 \
  ker mat(-1 - i, 2; -1, 1 - i) =& vec(1 - i, 1 - i).
$

== Special Eigen Cases
If the $j$th column of $A$ is $a vb(e)_j$, then ${a, vb(e)_j}$ is an eigen-pair.

Let $x$ be arbitrary values.
For
$
  A = mat(a, x, 0; 0, x, 0; 0, x, b),
$ ${a, vb(e)_1}, {b, vb(e)_3}$ are eigen-pairs.

For
$
  A = mat(a, 0, 0; 0, b, 0; 0, 0, c),
$ ${a, vb(e)_1}, {b, vb(e)_2}, {c, vb(e)_3}$ are eigen-pairs.

For
$
  A = mat(0, 0, a; 0, b, 0; c, 0, 0),
$ only ${b, vb(e)_2}$ is an eigen-pair.

For upper/lower triangular matrices, the head/tail of each row are eigenvalues, and the column of $a vb(e)_n$ makes ${a, vb(e)_n}$ an eigen-pair.

== Application: Probability
Using probability matrix to evaluate the probabilities after a few iteration, we would have to compute
$
  A^k vb(v)
$ where $A$ is the probability matrix.

If ${lambda, vb(v)}$ is an eigen-pair of $A$, then
$
  A^k vb(v) = lambda^k vb(v).
$
But this is kind of useless, as the coincidence can hardly happen.

Remember that, any $n$-length vector can be expressed as a linear combination of $n$ other vectors with the same length (refer to LI and LD).
Oh, if an $n times n$ matrix has $n$ eigenvectors...

If two eigenvalues are different, their eigenvectors are linearly independent, which means they can be used to construct any vector in the same space.

For example, $A in RR^2, vb(a) = vec(a_1, a_2), lambda_1 eq.not lambda_2$,
$
  vb(a) &= alpha vb(v)_1 + beta vb(v)_2 \
  A^k vb(a) &= A^k (alpha vb(v)_1 + beta vb(v)_2) \
  &= alpha A^k vb(v)_1 + beta A^k vb(v)_2 \
  &= alpha lambda_1^k vb(v)_1 + beta lambda_2^k vb(v)_2.
$

== Application: Differential Equation
For instance, $m dv(vb(x), t, 2)(t) + c dv(vb(x), t)(t) + k vb(x)(t) = 0$ describes a motion.

It can be written as two 1st-degree differentials:
$
  cases(
    x'(t) = v(t),
    v'(t) = -k / m x(t) - c / m v(t)
  ).
$

Let $vb(x) = vec(x(t), v(t))$,
$
  vb(x)' &= vec(x'_1, x'_2) \
  x'_1(t) &= c_11 x_1(t) + c_12 x_2(t) \
  x'_2(t) &= c_21 x_1(t) + c_22 x_2(t) \
  vec(x'_1, x'_2) &= mat(a_11, a_12; a_21, a_22) vec(x_1(t), x_2(t)).
$
Let $A$ be the matrix of $a$'s.
If $A$ has eigen pairs ${lambda_1, vb(v)_1}, {lambda_2, vb(v)_2}$ and $lambda_1 eq.not lambda_2$ or $(lambda_1 = lambda_2 = lambda) and ("AM"(lambda) = "GM"(lambda))$, there exists a general solution to the differential equations
$
  cases(
    x_1 = e^(lambda_1 t) vb(v)_1,
    x_2 = e^(lambda_2 t) vb(v)_2
  ) \
  vb(x)(t) = c_1 e^(lambda_1 t) vb(v)_1 + c_2 e^(lambda_2 t) vb(v)_2
$ where $c_1, c_2$ are arbitrary constants.

Given initial value $vb(x)(0)$, the constants can be solved.

If the $lambda$'s found are conjugates, then the solutions are real:
$
  vb(x)_1 &= Re{vb(z)_1 (t)} = (vb(z)_1 + vb(z)_2) / 2 \
  vb(x)_2 &= Im{vb(z)_1 (t)} = (vb(z)_1 - vb(z)_2) / (2i)
$ where $z$ are the imaginary numbers formed by $e^(lambda t) vb(v)$.
Note that the "imaginary" solution is _real_, no $i$!

In short, if $vb(x)' = A vb(x), lambda_(1, 2) = alpha plus.minus beta i, (alpha, beta in RR)$,
$
  vb(x)(t) &= c_1 e^(lambda_1 t) vb(v)_1 + c_2 conj(e^(lambda_2 t) vb(v)_2) \
  &= c_1 Re{e^(lambda_1 t) vb(v)_1} + c_2 Im{e^(lambda_1 t) vb(v)_1}.
$
Then, you will compute each value, distribute them to two vectors of the either the real or imaginary the part.

== Application: Vector Transformation
Let $A$ be a matrix that reflects vectors in $RR^2$ in the line at angle $pi / 3$.
This is not the easiest, but learn.
$
  phi =& pi / 3 \
  vb(u) =& vec(1, sqrt(3)) \
  vb(u)_perp =& vec(sqrt(3), -1).
$
Let $vb(v)_1 = vb(u), vb(v)_2 = vb(u)_perp$, notice that
$
  vb(e)_1 =& vec(1, 0) = 1 / 4 vec(1, sqrt(3)) + sqrt(3) / 4 vec(sqrt(3), -1) = 1 / 4 vb(v)_1 + sqrt(3) / 4 vb(v)_2
$
Notice the same for $vb(e)_2$.
Then compute $A vb(e)$:
$
  A vb(e)_1 =& A (1 / 4 vb(v)_1 + sqrt(3) / 4 vb(v)_2) \
  =& 1 / 4 lambda_1 vb(v)_1 + sqrt(3) / 4 lambda_2 vb(v)_2.
$
Same for $A vb(e)_2$.

== Application: Probability
For every probability matrix, it always has an eigenvalue $lambda = 1$.
The equilibrium is the eigenvector to the eigenvalue that is 1.

== Matrix Similarity and Diagonalization <sc:mat-similarity>
/ Similar matrices: Matrices $A, B$ are similar if there exists an invertible matrix $T$ that
  $ B = T A T^(-1). $
  Similar matrices have
  - $rank(A) = rank(B)$
  - $det(A) = det(B)$
  - $trace(A) = trace(B)$
  - Identical eigenvalues, but _not necessarily_ eigenvectors.

Using similarity, we can finally rewrite matrix powers as
$
  A^k =& (T D T^(-1))^k \
  =& T D T^(-1) \
  =& T mat(lambda_1^k, 0, dots.c, 0; 0, lambda_2^k, dots.c, 0; dots.v, dots.v, dots.down, dots.v; 0, 0, dots.c, lambda_n^k) T^(-1)
$ where $D$ is the diagonal matrix made of $A$'s eigenvalues, and $T$ is the matrix made of eigenvector columns, _in order_ of the eigenvalues in $D$.

/ Diagonalizable matrix: For an $n times n$ matrix, if there exist $n$ LI eigenvectors, i.e. when all eigenvalues ate unique or each repeated eigenvalue has $"AM"(lambda) = "GM"(lambda)$, then the matrix is diagonalizable.

== Matrix Exponential
So... what the heck is that?
$
  e^A
$

Recall our previous differential euqation:
$
  cases(
    x'(t) = a x(t),
    x(0) = x_0
  ) \
  x(t) = e^(a t) x_0
$
Instead of scalar $a$, we now give it a matrix "coefficient":
$
  cases(
    vb(x)'(t) = A vb(x)(t),
    vb(x)(0) = vb(x)_0
  ) \
  vb(x)(t) = e^(A t) vb(x)_0 = ?
$

/ Matrix exponential ($e^A$): For an $n times n$ matrix $A$,
  $
    e^(A t) =& sum_(k = 0)^oo (A t)^k / k! \
    =& I + A t + 1 / 2! A^2 t^2 + 1 / 3! A^3 t^3 + ...
  $
  The result is a matrix of the same size as $A$.
  Note that the same applies to $A$ replaced with a scalar $a$.

There are two cases:
- $A$ is diagonalizable,
- $A$ is not diagonalizable.
Regardless, we can get the exponential, but the approaches vary.

=== Diagonalizable Matrix as Power
Let $A$ be a diagonalizable $3 times 3$ matrix.
$
  A =& T D T^(-1) \
  T =& mat(vb(v)_1, vb(v)_2, vb(v)_3) \
  D =& mat(lambda_1, 0, 0; 0, lambda_2, 0; 0, 0, lambda_3) \
  e^(A t) =& sum_(k = 0)^oo ((T D T^(-1))^k t^k) / k! \
  =& I + (T D T^(-1)) t + 1 / 2! (T D T^(-1))^2 t^2 + 1 / 3! (T D T^(-1))^3 t^3 + ...
$

Notice that
$
  sum_(k = 0)^oo (D^k t^k) / k! =& sum_(k = 0)^oo mat((lambda_1 t)^k / k!, 0, 0; 0, (lambda_2 t)^k / k!, 0; 0, 0, (lambda_3 t)^k / k! ) \
  =& mat(sum_(k = 0)^oo (lambda_1 t)^k / k!, 0, 0; 0, sum_(k = 0)^oo (lambda_2 t)^k / k!, 0; 0, 0, sum_(k = 0)^oo (lambda_3 t)^k / k! ) \
  =& mat(e^(lambda_1 t), 0, 0; 0, e^(lambda_2 t), 0; 0, 0, e^(lambda_3 t)).
$

By the same token we used in prior power of matrices, all the in-between $T^(-1) T$ cancel out,
$
  e^(A t) =& T mat(e^(lambda_1 t), 0, 0; 0, e^(lambda_2 t), 0; 0, 0, e^(lambda_3 t)) T^(-1) \
  =& T e^(D t) T^(-1).
$

Now, given a linear system,
$
  cases(
    x'_1(x) = a_11 x_1(t) + a_12 x_2(t),
    x'_2(x) = a_21 x_1(t) + a_22 x_2(t),
  ),
$
we can write is as
$
  A =& mat(a_11, a_12; a_21, a_22) \
  vb(x')(t) =& A vb(x)(t) \
  vb(x)(t) =& e^(A t) vb(x)_0 \
  =& T e^(D t) T^(-1) vb(x)_0.
$
Elegantly solved.

=== Non-diagonalizable Matrix as Power
See textbook lol.

#termlist
