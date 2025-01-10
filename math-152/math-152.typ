#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    MATH 152 Study Notes \
    #underline[Linear Systems]
  ],
  author: "Yecheng Liang",
)
#import "@preview/physica:0.9.4": *
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

#let vecb(body) = $vectorbold(body)$
#let veca(body) = $vectorarrow(body)$
#let vecl(body) = $||vecb(body)||$
#let det = "det"

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
  cos(theta) &= (1 times 1 + 1 times -1 + 1 times 1) / (sqrt(1^2 + 1^2 + 1^2) times sqrt(1^2 + -1^2 + 1^2)) = 1/3 \
  theta &approx qty(1.23, rad) = 70.53 degree.
$

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
  "Proj"_vecb(b) vecb(a) &= "'shadow' length of" vecb(a) "on" vecb(b) times "direction of" vecb(b) \
  //TODO middle form
  &= (vecb(a) dot vecb(b)) vecb(b) / vecl(b)^2.
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

=== Determinant
Given a matrix $vecb(a) = mat(a, b; c, d)$, the determinant of a 2x2 matrix is
$
  det vecb(a) equiv matrixdet(a, b; c, d) &= a d - b c.
$

The determinant of a 3x3 matrix is
$
  matrixdet(a, b, c; d, e, f; g, h, i) = a e i + b f g + c d h - c e g - b d i - a f h \
  "(try find a pattern here!)"
$
Or, it can be computed by row expansion, which is taking each of the elements in a row and multiplying it by the determinant of the 2x2 matrix formed by the elements in the rows and columns the chosen element is not in. Take note of the alternating signs.
$
  matrixdet(a_1, a_2, a_3; b_1, b_2, b_3; c_1, c_2, c_3) &= a_1 matrixdet(b_2, b_3; c_2, c_3) - a_2 matrixdet(b_1, b_3; c_1, c_3) + a_3 matrixdet(b_1, b_2; c_1, c_2).
$

For a parallelogram formed by two vectors $vecb(a) "and" vecb(b)$, the area is the absolute value of the determinant of the matrix formed by the vectors:
$
  A_"parallelogram" = matrixdet(a_1, a_2; b_1, b_2).
$

For example, for $vecb(a) = vec(1, -2) "and" vecb(b) = vec(3, 5)$, the area of the parallelogram is
$
  A_"parallelogram" = matrixdet(1, 3; -2, 5) = 11.
$

=== Linear Dependence
//TODO

=== Cross Product
The cross product of two vectors is a vector that is orthogonal to the two vectors, \
a.k.a. the normal vector of the plane formed by the two vectors, \
a.k.a. the vector that is perpendicular to the two vectors.

Given $vecb(a) = vec(a_1, a_2, a_3) "and" vecb(b) = vec(b_1, b_2, b_3)$, the cross product is
$
  vecb(a) times vecb(b) &= matrixdet(i, j, k; a_1, a_2, a_3; b_1, b_2, b_3) \
  &= vec(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1).
$
