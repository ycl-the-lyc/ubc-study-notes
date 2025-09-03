#import "../lib.typ": *
#show: setup.with(
  title: [MATH 253 _Multivariable Calculus_],
  author: "Yecheng Liang"
)

= Cartesian Coordinate System
For a 3D space, $RR^3$, there are sets of points.
Knowing one point does not tell you a line, like so in a 2D space, but rather gives you a surface.

#example[][
  $ z = 0 -> Set((x, y, z) : z = 0, -oo < x < oo, -oo, < y < oo) $
]

== Euclidean Distance
#theorem[Pythagoras][
  For points A and B in $RR^3$,
  $ "dist"(A, B) = sqrt((x_1 - x_2)^2 + (y_1 - y_2)^2 + (z_1 - z_2)^2). $
]
