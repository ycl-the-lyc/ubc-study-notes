#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    MATH 152 Study Notes \
    #underline[Linear Systems]
  ],
  author: "Yecheng Liang",
)
#import "@preview/physica:0.9.4": *
#show: super-T-as-transpose // Render "..^T" as transposed matrix
#import "@preview/equate:0.2.1": equate
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")
#import "@preview/metro:0.3.0": *
#import units: *
#import prefixes: *

#import "@preview/cetz:0.3.1"
#import "@preview/cetz-plot:0.1.0"
#let style-vec = (
  mark: (
    end: "stealth",
  ),
)

#set math.vec(delim: "[")
#let vecb(body) = $vectorbold(body)$
#let veca(body) = $vectorarrow(body)$
#let vecl(body) = $||vecb(body)||$
#let vecu(body) = $vectorunit(body)$
// #let vec(..body) = $(body.pos().join(", "))$
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
  veca(x) "is a vector."
$

In printed media, vectors are often written in boldface.
$
  vecb(x) "is a vector."
$

== Vector Dimensions
The number of scalars in a vector is called the dimension of the vector.
For example,
$
  vecb(a) = vec(1, 2) "is a" RR^2 \
  vecb(b) = vec(1, 2, 3, 4) "is a" RR^4
$

== Linear Combinations
A linear combination of vectors is the sum of the vectors multiplied by scalars. Each vector is a orthogonal basis vector.

For example, $vecb(a) in RR^3$ can be written as
$
  vecb(a) = x vecb(i) + y vecb(j) + z vecb(k)
$ where $vecb(i)$, $vecb(j)$, $vecb(k)$ are the orthogonal basis vectors for a 3 dimensional space.

== Vector Operations

=== Vector & Scalar
Yeah just do it.

== Addition & Subtraction

For addition and subtraction, simply add or subtract the corresponding scalars.
Commutate, associate and distribute them.

#cetz.canvas({
  import cetz: *
  import cetz-plot: *

  plot.plot(
    size: (4, 4),
    axis-style: "left",
    x-tick-step: 1,
    y-tick-step: 1,
    x-max: 6,
    y-max: 6,
    {
      let add-vec = plot.add.with(style: style-vec)
      add-vec(((0, 0), (1, 3)), label: $vecb(a)$)
      add-vec(((0, 0), (3, 1)), label: $vecb(b)$)
      add-vec(((1, 3), (5, 5)), label: $vecb(c)$)
      add-vec(((3, 1), (5, 5)), label: $vecb(d)$)

      add-vec(((0, 0), (5, 5)), label: $vecb(e)$)
    },
  )
})

$
  vecb(a) + vecb(b) &= vecb(c) + vecb(d) = vecb(e) \
  vecb(e) - vecb(a) &= vecb(b) \
  vecb(e) - vecb(c) &= vecb(d)
$

By subtracting vectors, we can find the vector that connects the two vectors.
The length of the connecting vector is the distance between the two vectors.

=== Dot Product
The two vectors must have the same size/dimension.
The dot product of two vectors is the sum of the products of the corresponding scalars.

$
  vecb(a) dot vecb(b) = a_1 b_1 + a_2 b_2 + a_3 b_3.
$

Note that the result is a scalar.

Dot product is commutative (even with scalars) and distributive.

=== Angle Between Vectors
The angle between two vectors can be found using the dot product.
$
  cos(theta) = (vecb(a) dot vecb(b)) / (vecl(a) vecl(b))
$ where $theta$ is the smallest angle between the two vectors. \
(This can be proven using Pythagorean theorem.)

If neither of the vectors is the zero vector, and the dot product is 0, then the vectors are orthogonal (perpendicular) to each other.

Given $vecb(a) = vec(1, 1, 1) "and" vecb(b) = vec(1, -1, 1)$, the angle between them is
$
  cos(theta) &= (1 times 1 + 1 times -1 + 1 times 1) / (sqrt(1^2 + 1^2 + 1^2) times sqrt(1^2 + -1^2 + 1^2)) = 1 / 3 \
  theta &approx qty(1.23, rad) = 70.53 degree.
$

Note: if the dot product of two vectors $vecb(a) dot vecb(b) = 0$, then vectors $vecb(a)$ and $vecb(b)$ are *perbendicular*.

=== Vector Length
The length of a vector is the square root of the sum of the squares of the scalars in the vector, which is also the square root of the dot product of the vector with itself.
It can be notated as $||vecb(a)||$.

$
  vecl(a) = sqrt(vecb(a) dot vecb(a)) = sqrt(a_1^2 + a_2^2 + a_3^2).
$

For example, $||vecb(x) - vecb(c)|| = 1$ means all points which are 1 unit away from $vecb(c)$, a circle.

=== Projection
The projection of $vecb(a)$ onto $vecb(b)$ is the vector that is parallel to $vecb(b)$ and has the same length as the projection of $vecb(a)$ onto $vecb(b)$.
$
  "proj"_vecb(b) vecb(a) &= "'shadow' length of" vecb(a) "on" vecb(b) times "direction of" vecb(b) \
  &= (vecb(a) dot vecb(b)) vecb(b) / vecl(b)^2 \
  &= (vecb(a) dot hat(b)) hat(b)
$

Here's a proof:

The projection of $vecb(a)$ onto $vecb(b)$ can be represented as a scalar multipled by $vecb(b)$, where $vecb(b) != 0$.
$ "proj"_vecb(b) vecb(a) = s vecb(b) $ <eq:projection>

We know that the perpendicular vector, connecting point on $vecb(b)$ to the end of $vecb(a)$, can be denoted as $vecb(a) - s vecb(b)$.

Hence, we know that
$ (vecb(a) - s vecb(b)) dot vecb(b) = 0 $
$ vecb(a) dot vecb(b) - s (vecb(b) dot vecb(b)) = 0 $
$ s = (vecb(a) dot vecb(b)) / (vecb(b) dot vecb(b)) $
Plugging back into @eq:projection, we hence get:
$ "proj"_vecb(b) vecb(a) = (vecb(a) dot vecb(b)) / vecl(b)^2 vecb(b) $

Further, a vector $vecb(a)$ has $vecb(a) / vecl(a) = hat(a)$, so
$
  (vecb(a) dot vecb(b)) / vecl(b)^2 vecb(b) &= (vecb(a) dot hat(b)) hat(b).
$

=== Parallelogram
A parallelogram is a quadrilateral with opposite sides parallel.
Given two vectors $vecb(a)$ and $vecb(b)$, the area of the parallelogram formed by them is
$
  A &= "base" times "height" \
  &= vecl(a) vecl(b) sin(theta) \
  &= vecl(a) vecl(b) cos(pi / 2 - theta) \
  &= vecb(a_perp) dot vecb(b)
$
where $vecb(a_perp)$ is the vector perpendicular to $vecb(a)$.

== Matrices
A matrix is a rectangular array of scalars.
It can also be thought of as rows of vectors.
$
  mat(a, b; c, d).
$

=== Determinant of 2x2 Matrix
Given a matrix $vecb(a) = mat(a, b; c, d)$, the determinant of a 2x2 matrix is
$
  det vecb(a) equiv matrixdet(a, b; c, d) &= a d - b c.
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
  matrixdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &= a_1 matrixdet(b_2, b_3; c_2, c_3) - a_2 matrixdet(b_1, b_3; c_1, c_3) + a_3 matrixdet(b_1, b_2; c_1, c_2).
$

If you pick row 2:
$
  matrixdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &=
  - b_1 matrixdet(a_2, a_3; c_2, c_3) + b_2 matrixdet(a_1, a_3; c_1, c_3) - b_3 matrixdet(a_1, a_2; c_1, c_2).
$

If you pick column 2:
$
  matrixdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &=
  -a_2 matrixdet(b_1, b_3; c_1, c_3) + b_2 matrixdet(a_1, a_3; c_1, c_3) - c_2 matrixdet(a_1, a_3; b_1, b_3).
$

*Tip*: pick any row / column with the *most zeroes*.


The determinant of a 3x3 matrix is
$
  matrixdet(a, b, c; d, e, f; g, h, i) = a e i + b f g + c d h - c e g - b d i - a f h \
  "(try find a pattern here!)"
$

This can be visualised as putting copying the first two columns onto the right, then for each 3 number diagonal in the shape of a backslash, take the product of the three numbers and sum them, and for each 3 number diagonal in the shape, subtract the each product from the previous sum.


// may add smth here //


For a parallelogram formed by two vectors $vecb(a) "and" vecb(b)$, the area is the absolute value of the determinant of the matrix formed by the vectors:
$
  A_"parallelogram" = matrixdet(a_1, a_2; b_1, b_2).
$

For example, for $vecb(a) = vec(1, -2) "and" vecb(b) = vec(3, 5)$, the area of the parallelogram is
$
  A_"parallelogram" = matrixdet(1, 3; -2, 5) = 11.
$


//ADD 4X4 MATRIX DETERMINANT //


=== Linear Dependence
//TODO

=== Cross Product
The cross product of two vectors is a vector that is orthogonal to the two vectors, \
a.k.a. the normal vector of the plane formed by the two vectors, \
a.k.a. the vector that is perpendicular to the two vectors.

Given $vecb(a) = vec(a_1, a_2, a_3) "and" vecb(b) = vec(b_1, b_2, b_3)$, the cross product is
$
  vecb(a) times vecb(b) &= matrixdet(vecu(i), vecu(j), vecu(k); a_1, a_2, a_3; b_1, b_2, b_3) \
  &= vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1).
$

In a Right Hand (RH) coordinate system, the cross product is the vector that points in the direction of the thumb when the fingers of the right hand curl from $vecb(a)$ to $vecb(b)$.
In other words, the cross product is the vector that is orthogonal/perpendicular to the two vectors.
$ vecb(a) dot (vecb(a) times vecb(b)) = 0 $

=== Volume of Parallelepiped
The volume of a parallelepiped formed by three vectors $vecb(a)$, $vecb(b)$, and $vecb(c)$ is the absolute value of the determinant of the matrix formed by the vectors.
$
  V_"parallelepiped" &= "base area" times "height" \
  &= A_"parallelogram" times cos(theta) vecl(c) \
  &= matrixdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) \
  &= abs(vecb(a) dot (vecb(b) times vecb(c))).
$

= Lines, Curves and Planes in Vector Form

== Lines in 2D Space
There is a line $L$.
Take a point on the line, $vecb(p) = vec(x_0, y_0)$, then take a vector that is parallel to the line, $vecb(l) = vec(i, j)$.
The line can be represented as
$
  vecb(x) = vecb(p) + t vecb(l)
$
where $t in RR$.

Alternatively,
$
  cases(
  x = i t + x_0,
  y = j t + y_0
)
$

The directional vector $vecb(l)$ is can be compared to other vectors to determine if they are parallel or perpendicular, or neither.
- If $vecb(l)_1 dot vecb(l)_2 = 0$, then the two vectors are perpendicular.
- Else, if $vecb(l)_1 = c vecb(l)_2$ where $c$ is a scalar constant, then the two vectors are parallel.

Where there is a line, there is a normal vector to the line, $vecb(n)$.
Thus the line can also be represented as
$
  vecb(n) dot (vecb(x) - vecb(p)) &= 0 \
  vecb(n) dot vecb(x) &= vecb(n) dot vecb(p).
$

If we have a line $x - 2y + 3z = 0$, we know that the LHS is not 0, while the RHS $vecb(n) dot vecb(p) = 0$, $vecb(p) = vec(0, 0, 0)$, so the line must pass through the origin.
Additionally, the normal vector is $vec(1, -2, 3)$.

== Planes in 3D Space
There is a plane $S "in" RR^3$.
Take a point on the plane, $vecb(p) = vec(x_0, y_0, z_0)$.
If $vecb(x)$ is a point on the plane, $vecb(x) - vecb(p)$ must be perpendicular to the normal vector of the plane from origin, $vecb(n)$.
Thus the plane can be represented as
$
  vecb(n) dot (vecb(x) - vecb(p)) = 0 " or " vecb(n) dot vecb(x) = vecb(n) dot vecb(p).
$
Similarly, if we have a plane $x - 2y + 3z = 0$, we know that the LHS is not 0, while the RHS $vecb(n) dot vecb(p) = 0$, $vecb(p) = vec(0, 0, 0)$, so the plane must pass through the origin.
Additionally, the normal vector is $vec(1, -2, 3)$.

The plane can also be seen as:
$
  a x + b y + c z = d.
$
where $vec(a, b, c) = vecb(n)$ and $d = vecb(n) dot vecb(p)$.
We can see that this is an expansion of the $vecb(n) dot vecb(x) = vecb(n) dot vecb(p)$ form.

Alternatively, we can use the parametric form:
$
  vecb(x) - vecb(p) = s vecb(u) + t vecb(v)
$
where $vecb(u)$ and $vecb(v)$ are two vectors on the plane and $s, t in RR$.

For example, a plane $S$ has parametric form
$
  vecb(x) = vec(1, 2, 1) + s vec(1, 0, 1) + t vec(1, 1, 0).
$
To find the normal representation, we can do a cross product of the two vectors on the plane to get the normal vector.
$
  vecb(n) &= vec(1, 0, 1) times vec(1, 1, 0) \
  &= matrixdet(vecu(i), vecu(j), vecu(k); 1, 0, 1; 1, 1, 0) \
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
  vecb(x) = vec(6, 0, 0) + s vec(-2, 1, 0) + t vec(-3, 0, 1).
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
  vecb(x) = vecb(p) + t vecb(l),
$ the same as in 2D space.

The line can also be represented as the intersection of two planes.
$
  cases(
    vecb(n)_1 dot vecb(x) = vecb(n)_1 dot vecb(p)_1,
    vecb(n)_2 dot vecb(x) = vecb(n)_2 dot vecb(p)_2
  ) \
  vecb(l) = vecb(n)_1 times vecb(n)_2.
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
  vecb(n)_1 = vec(1, 1, 1) \
  vecb(n)_2 = vec(1, -1, 2).
$
So we can have $vecb(l)$
$
  vecb(l) = vecb(n)_1 times vecb(n)_2 = matrixdet(vecu(i), vecu(j), vecu(k); 1, 1, 1; 1, -1, 2) = vec(3, -1, -2).
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
Thus, $vecb(p) = vec(-2, 5, 0)$ is on $L$.
$
  vecb(x) = vec(-2, 5, 0) + t vec(3, -1, -2).
$

Inversely, given a line $L$ with
$
  vecb(x) = vec(1, 2, 1) + t vec(1, 1, 2),
$
we can find two planes that intersect at the line.
Look for two combinations of $t = x, y, z$ that when plugged in, will remove $t$ from the equation.
That will give us two planes.

=== Projection of a Line onto A Plane
Let $vecb(a)$ be a line and $S$ be a plane in 3D space.

In case that $S$ is one of the coordinate planes, the projection is simple enough (taught in PHYS 170).
$
  vecb(a)_"proj on xy-plane" = vec(a_1, a_2, 0)
$ and so for the other two planes.

In general, the projection in 3D space resembles the projection in 2D space.
$
  vecb(a)_parallel &= vecb(a) - vecb(a)_perp \
  &= vecb(a)_"proj"
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
/ Linear Dependence (LD): Non-zero vectors which are parallel to each other, or can be expressed as a scalar multiple of each other, or most generally, $s_1 vecb(a)_1 + s_2 vecb(a)_2 + ... = vecb(0)$ can be true when _not all_ $s$'s are 0. \
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
  matrixdet(1, 0, 1; 1, -1, 2; 1, 1, 1) = 1 eq.not 0,
$ so $vec(1, 0, 1), vec(1, -1, 2) "and" vec(1, 1, 1)$ are LI.

For 3 3D vectors, the other way is to check the volume of the parallelepiped formed by the vectors, $abs(vecb(a) times (vecb(b) dot vecb(c)))$.
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

For example, given $L_1: vecb(x) = vec(1, 2, 3) + t vec(1, 0, 0)$ and $L_2: vecb(x) = s vec(1, 1, 1)$, one can first get the direction of the connecting vector by taking the cross product of the two directional vectors. Then find a point on each line and the connecting vector.

Alternatively, we can find two arbitrary points on each line, connect them, and find the projection of the connecting vector onto the direction of the perpendicular line from one of the points.

== Rank and Solution Structure
/ Rank: The number of LI (non-zero) rows in the REF of matrix, including augmentation.

- If $rank[A] = rank[A|vecb(b)]$ and $rank[A] = n$, then the system has a unique solution.
- If $rank[A] < rank[A|vecb(b)]$, then the system has no solution.
- If $rank[A] = rank[A|vecb(b)] < n$, then the system has infinite solutions.

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
  A vecb(x) = vecb(b).
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

//TODO

== Linear Transformation
/ Linear transformation / map / function: a rule that assigns one output to each input.

For example, given $vecb(x) in RR^n$
$
  A vecb(x) = vecb(y) in RR^m
$ indicates that $A$ is a transformation from $RR^n$ to $RR^m$:
$
 A: RR^n -> RR^m.
$

/ Linearity: A transformation $T: RR ^n -> RR^m$ is linear iff
  $
    T(alpha vecb(x)_1 + beta vecb(x)_2) = alpha T(vecb(x)_1) + beta T(vecb(x)_2) \
    "or" \
    T(vecb(x)_1 + vecb(x)_2) = T(vecb(x)_1) + T(vecb(x)_2) "and" T(alpha vecb(x)) = alpha T(vecb(x)).
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
  mat(vecb(a)_1, vecb(a)_2, dots.c vecb(a)_n) mat(x_1; x_2; dots.v; x_n) = mat(vecb(a)_1 x_1, vecb(a)_2 x_2, dots.c, vecb(a)_n a_n).
$
Write $vecb(a)$ as a transformation, $T(e)$, each column of the result becomes an image/transformation of $x$.

#block(inset: 0.65em, stroke: red)[
  *Sanity check*: _projection_ is not a one-to-one operation, so the matrix you use must have a determinant of 0.
]

=== Finding Transformations in 2D Space
Say, we are projecting some vector to a vector with $vecb(u)$ at angle $phi$ to the $x$ axis, Of course, we can use the projection formula, but here we want to find the transformation matrix that does the job for us (and it's easier).
Let $vecb(e)_1$ and $vecb(e)_2$ be vectors on the $x$ and $y$ that projects to $vecb(u)$.
$
  M_"proj" &= mat(T(vecb(e)_1), T(vecb(e)_2)) \
  T(veca(e)_1) &= "Proj"_phi (vecb(e)_1) \
  &= cos(phi) vecb(u) \
  &= cos(phi) vec(cos(phi), sin(phi)) \
  &= vec(cos^2(phi), sin(phi) cos(phi)) \
  T(vecb(e)_2) &= "Proj"_phi (vecb(e)_2) \
  &= sin(phi) vecb(u) \
  &= sin(phi) vec(cos(phi), sin(phi)) \
  &= vec(sin(phi) cos(phi), sin^2(phi)) \
  M_"proj" &= mat(cos^2(phi), sin(phi) cos(phi); sin(phi) cos(phi), sin^2(phi)).
$
Then, to project any vector $vecb(a)$ to $vecb(u)$, we can simply put
$
  "Proj"_vecb(u) vecb(a) = M_"proj" vecb(a).
$

To find other transformations, similarly find transformation of each orthogonal vector/basis, then combine them to a column space.

Here is another example: rotation. Let's say we are to find a rotation matrix of $phi$ counterclockwise.
$
  T(vecb(e)_1) &= vec(cos(phi), sin(phi)) \
  T(vecb(e)_2) &= vec(-sin(phi), cos(phi)) \
  M_"rot" &= mat(cos(phi), -sin(phi); sin(phi), cos(phi)).
$

Yet another one, reflection by function $y = m x$.
$
  phi &= acos((vecb(x) dot vecb(y)) / (norm(x) norm(y))) \
  "Ref"_phi(vecb(x)) &= vecb(x)_parallel - vecb(x)_perp \
  &= vecb(x)_parallel - (vecb(x)_parallel - vecb(x)) \
  &= 2 vecb(x)_parallel - vecb(x) \
  &= 2 "Proj"_phi(vecb(x)) - vecb(x) \
  &= 2 M_"proj"_phi(vecb(x)) - I vecb(x) \
  &= (2 M_"proj"_phi - I) vecb(x) \
  M_"ref"_phi &= 2 M_"proj"_phi - I \
  &= 2 mat(cos^2(phi), sin(phi) cos(phi); sin(phi) cos(phi), sin^2(phi)) - imat(2) \
  &= mat(2 cos(2 phi) + 1, sin(2 phi); sin(2 phi), -cos(2 phi) + 1) - imat(2) \
  &= mat(cos(2 phi), sin(2 phi); sin(2 phi), -cos(2 phi)).
$

=== Finding Transformations in 3D Space
Firstly, reflection.
Given a plane $P: x + y + z = 0$ and a vector $vec(x)$, find the reflection of $vecb(x)$ about the plane.
$
  vecb(n) &= vec(1, 1, 1) \
  vecu(n) &= 1 / sqrt(3) vec(1, 1, 1) \
  "Ref"_P(vecb(x)) &= vecb(x)_parallel - vecb(x)_perp \
  &= (vecb(x) - vecb(x)_perp) - vecb(perp) \
  &= vecb(x) - 2 vecb(x)_perp \
  &= (I - 2 "Proj"_vecu(n)(x)) vecb(x) \
  M_"ref"_P &= I - 2 M_T_"proj"_vecu(n)(x) \
  "Proj"_vecu(n)(vecb(e)) &= (vecb(e) dot vecu(n)) vecu(n) \
  &= 1 / 3 vec(1, 1, 1) \
  M_"proj"_vecu(n) &= 1 / 3 ones(3) \
  M_"proj"_P &= I - M_"proj"_vecu(n) \
  &= 1 / 3 mat(2, -1, -1; -1, 2, -1; -1, 2, -1) \
  M_"ref"_P &= I - 2 M_"proj"_vecu(n) \
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
  vecb(x)_1 = vec(x, y) = c_1 vecb(e)_1 + c_2 vecb(e)_2 \
  vecb(x)_2 = vec(z, w) = c_3 vecb(e)_1 + c_4 vecb(e)_2.
$
We can first find out how to eliminate one of the $vecb(e)$ by solving
$
  alpha vecb(x)_1 + beta vecb(x)_2 = vec(1, 0) \
  gamma vecb(x)_1 + delta vecb(x)_2 = vec(0, 1)
$ then solve the resulting linear system.

== Transpose of Matrices
/ Transpose: For a matrix, turning its rows to columns, and columns to rows, notated as $A^T$. In other words, flipping the matrix along its diagonal axis.

For example,
$
  A &= mat(1, 2; 3, 4) \
  A^T &= mat(1, 3; 4, 2)
$

Some nice conclusions:
- $(A B)^T = B^T A^T$.
- If $vecb(x), vecb(y) in RR^n$ and are columns, then $vecb(x) dot vecb(y) = vecb(x)^T vecb(y) = vecb(y)^T vecb(x)$.
- If $vecb(x), vecb(y) in RR^n, A = A_(m times n)$, then $vecb(y) dot (A vecb(x)) = (A^T vecb(y)) dot vecb(x)$.

Remember again, matrices $A B eq.not B A$.

=== Probability Matrices
When we have a system with multiple states, each state being not so stable and has probabilities to switch to other states.
We can represent each state as a probability matrix, $P_(i j)$, for $i$ is the current state, and $j$ is the state that it can switch to.
//WIP

// == Eigenvalues and Eigenvectors
// If a matrix has $n$ rows and $n$ columns, we can get many interesting properties from it.
// $
//   mat(
//     a_(11), a_(12), dots.c, a_(1n);
//     a_(21), a_(22), dots.c, a_(2n);
//     dots.v, dots.v, dots.down, dots.v;
//     a_(n 1), a_(n 2), dots.c, a_(n n)
//   )_(n times n)
// $


#termlist
