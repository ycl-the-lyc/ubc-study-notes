#import "../lib.typ": *
#show: setup.with(
  title: [MATH 253 _Multivariable Calculus_],
  author: "Yecheng Liang",
)

#set math.vec(delim: "[")

= Cartesian Coordinate System
For a 3D space, $RR^3$, there are sets of points.
Knowing one point does not tell you a line, like so in a 2D space, but rather gives you a surface.

#example[
  $ z = 0 ==> Set((x, y, z) : z = 0, -oo < x < oo, -oo, < y < oo) $
]

== Euclidean Distance
#theorem(title: [Pythagoras])[
  For points A and B in $RR^3$,
  $ "dist"(A, B) = sqrt((x_1 - x_2)^2 + (y_1 - y_2)^2 + (z_1 - z_2)^2). $
]

== Vector
#definition[
  A vector $vb(v)$ is with both magnitude $vn(v)$ and direction $vu(v)$.
]

A vector can be multiplied or divided by a scalar, which acts on its magnitude only.

A vector can be added or subtracted with a vector, which acts component-by-component.

#definition[
  $
    vu(i) & = [1, 0, 0] \
    vu(j) & = [0, 1, 0] \
    vu(k) & = [0, 0, 1] \
  $
]

It would help to derive some scalar value from vectors, as we often need to know about length, distances, etc.

#definition[
  For vectors $vb(u) = [u_1, u_2, u_3], vb(v) = [v_1, v_2, v_3]$,
  $
    vb(u) dot vb(v) & = u_1 v_1 + u_2 v_2 + u_3 v_3 \
                    & = vn(u) vn(v) cos(theta)
  $
  where $theta$ is the angle between $vb(u), vb(v)$.

]

#theorem(title: [Angle Between Two Vectors])[
  Obviously,
  $ cos(theta) = (vb(u) dot vb(v)) / (vn(u) vn(v)) $
]

#theorem(title: [Perpendicular Test])[
  Obviously,
  $ vb(a) dot vb(b) = 0 iff vb(a) perp vb(b) $
]

#theorem(title: [Vector Projection])[
  The projection of $vb(b)$ onto $vb(a)$,
  $
    "proj"_vb(a) vb(b) & = (vb(a) dot vb(b)) / vn(a)^2 vb(a) \
                       & = (vu(a) dot vb(b)) vu(a)
  $
  in which $(vu(a) dot vb(b))$ is called the "scalar projection".

  #proof[
    To project one vector $vb(b)$ onto another $vb(a)$ with angle $theta$, we should ensure that the result is directed in $vu(a) = vb(a) / vn(a)$, and has a length of $vn(b) cos(theta)$ since trigonometry.
    $
      "proj"_vb(a) vb(b) & = "dir" times "len" \
                         & = vb(a) / vn(a) vn(b) cos(theta) \
                         & = vb(a) / vn(a) vn(b) (vb(a) dot vb(b)) / (vn(a) vn(b)) \
                         & = (vb(a) dot vb(b)) / vn(a)^2 vb(a) \
                         & = (vu(a) dot vb(b)) vu(a)
    $
  ]
]

Now, it would be nice to know about area spanned by two vectors, too.

#definition[
  For vector $vb(u) = [u_1, u_2, u_3], vb(v) = [v_1, v_2, v_3]$,
  $
    norm(vb(u) times vb(v)) & = vn(u) vn(v) sin(theta)
  $
  which is the area of the parallelogram created by $vb(u)$ and $vb(v)$.

  The direction of the cross produce in $RR^3$ would use the right-hand rule: from $vb(u)$ to $vb(v)$, perpendicular to both.

  $
    vb(u) times vb(v) & = vec(
                          u_2 v_3 - u_3 v_2,
                          u_3 v_1 - u_1 v_3,
                          u_1 v_2 - u_2 v_1
                        ) \
                      & = matrixdet(vu(i), vu(j), vu(k); u_1, u_2, u_3; v_1, v_2, v_3)
  $
  (The second algebraic definition requires matrix knowledge.)
]

From the algebraic definition we can see that the cross product is anti-commutative.
#theorem[
  $ vb(u) times vb(v) = -vb(v) times vb(u) $
]

Recall that we can use dot product to test for perpendicular vectors.
$
  (vb(u) times vb(v)) dot vb(u) & = 0 \
  (vb(u) times vb(v)) dot vb(v) & = 0 \
$

#theorem(title: [Parallel Test])[
  $
    vb(u) times vb(v) iff vb(u) parallel vb(v)
  $
]


Similar to how we get area of a parallelogram via cross product, the volume of a parallelepiped formed by three vectors $vb(u), vb(v), vb(w)$ can be obtained with
$ V & = vb(u) dot (vb(v) times vb(w)) \
  & = vn(u) vn(v times w) cos(beta) $ where $beta$ is the angle between $vb(u) "and" vb(v) times vb(w)$.

To get the angle between two faces, we can
+ obtain normal of each face;
+ calculate angle between the two normals;
+ that is the angle between the two faces.

Make sure the two normals point the same way, or take the supplementary angle.

== Planes
For points $vb(r), vb(r)_0$ on plane $P$, and $vb(n)$ normal to $P$ at $vb(r)_0$, we use the dot product perpendicular test
$
              vb(n) dot (vb(r) - vb(r)_0) & = 0 \
  a (x - x_0) + b (y - y_0) + c (z - z_0) & = 0 \
                      a x + b y + c z + d & = 0
$
to define the plane.

With this definition, we can quickly find a normal of the plane and a point on the plane, which enable us for more arithmetics, like computing the distance from a point to the plane.

#problem(title: [Distance between planes])[
  Find the distance between planes $x + y - 2z = 2$, $x + y - 2z = 4$.

  #solution[
    A normal $vb(n)$ to both planes (since they must be parallel to have a non-zero distance) is $[1, 1, -2]$.
    Pick an arbitrary point on each plane.
    $ P: (4, 0, 0) quad Q: (2, 0, 0) $
    Let $vb(u) := vb(P Q) = [-2, 0, 0]$.
    $
      "distance" &= vn(u dot n) / vn(n) \
      &= norm([-2, 0, 0] dot [1, 1, -2]) / norm([1, 1, -2]) \
      &= abs(-2) / sqrt(1 + 1 + 4) \
      &= 2 / sqrt(6) \
      &= sqrt(2/3)
    $
  ]
]

== Parametric Curves
In parametric form, an arc can be described using $[a cos(t), b sin(t)]$ with constraints to $t$.
Extending the logic to all curves, their generic form is
$
  F(t) = Set(p, p = [x(t), y(t)], t ...)
$
