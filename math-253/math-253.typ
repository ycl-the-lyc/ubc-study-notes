#import "../lib.typ": *
#show: setup.with(
  title: [MATH 253 _Multivariable Calculus_],
  author: "Yecheng Liang"
)

#set math.vec(delim: "[")

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

== Vector
#definition[Vector][
  A vector $vb(v)$ is with both magnitude $vn(v)$ and direction $vu(v)$.
]

A vector can be multiplied or divided by a scalar, which acts on its magnitude only.

A vector can be added or subtracted with a vector, which acts component-by-component.

#example[Vector addition and subtraction in 2D space][
  $
    vb(u) &= vu(i) + 2 vu(j) \
    vb(v) &= 3 vu(i) + 4 vu(j) \
    vb(u) + vb(v) &= 4 vu(i) + 6 vu(j) \
    3 vb(v) &= 9 vu(i) + 12 vu(j)
  $
]

#definition[Vector dot product][
  For vectors $vb(u) = [u_1, u_2, u_3], vb(v) = [v_1, v_2, v_3]$,
  $
    vb(u) dot vb(v) &= u_1 v_1 + u_2 v_2 + u_3 v_3 \
    &= vn(u) vn(v) cos(theta)
  $
  where $theta$ is the angle between $vb(u), vb(v)$.

  #theorem[Angle between two vectors][
    Obviously,
    $ cos(theta) = (vb(u) dot vb(v)) / (vn(u) vn(v)) $
  ]
]
