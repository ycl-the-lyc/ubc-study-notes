#import "../lib.typ": *
#show: setup.with(
  title: [MATH 253 _Multivariable Calculus_],
  author: "Yecheng Liang",
)

#set math.vec(delim: "[")
#set math.mat(delim: "[")

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
    vb(u) times vb(v) = vb(0) iff vb(u) parallel vb(v)
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
      "distance" & = vn(u dot n) / vn(n) \
                 & = norm([-2, 0, 0] dot [1, 1, -2]) / norm([1, 1, -2]) \
                 & = abs(-2) / sqrt(1 + 1 + 4) \
                 & = 2 / sqrt(6) \
                 & = sqrt(2/3)
    $
  ]
]

== Parametric Curves
In parametric form, an arc can be described using $[a cos(t), b sin(t)]$ with constraints to $t$.
Extending the logic to all curves, their generic form is
$
  F(t) = Set(p, p = [x(t), y(t)], t ...)
$

== Quadric Surfaces
#definition[
  In 2D, a quadric line is a relationship using ${x^2, y^2, x y, x, y, "const"}$, like a circle, ellipse or hyperbola.

  In 3D, a quadric surface is a relationship using ${x^2, y^2, z^2, x y, x z, y z, x, y, z, "const"}$, like a sphere or ellipsoid.
]

#definition[
  In 3D, a cylinder is a quadric relationship with one variable unrestricted.
]

And there are way more weird quadric shapes.

#definition[
  In 3D, a trace curve is the intersection of a surface and parallel planes.
]

It is often hard to visualize quadric surfaces, but trace curves can help.
Restrict one variable by intersection the surface with a plane, we then solve the 3D quadric equation to 2D relationships, thus being able to plot and visualize the surface on that specific plane.

Yes, it makes a contour map.

= Function of Multiple Variables
We already know that a function is a mapping.
$f(x) = 2x$ maps $x$ to $2x$.

In 2D space,
$
  z & = f(x, y) \
  f & : RR^2 -> RR
$

== Domain
Just as functions with one variable, multi-variable functions have their own domain.

#example[
  $g(x, y) = ln(x + y)$,
  $
    x + y & > 0 \
        D & : Set((x, y), x + y > 0)
  $
]

= Limits and Continuity
#definition(title: [Limits])[
  We say that $lim_((x, y) -> (a, b)) f(x, y)$ exists and equals $L$ iff for any continuous path $gamma: (x, y) = (x(t), y(t))$ with $x(T) = a, y(T) = b$, that $lim_(t -> T) f(x(t), y(t)) = L$.
]

#definition(title: [Continuity])[
  Function $f(x, y)$ is continuous at $(a, b)$ if
  $
    lim_((x, y) -> (a, b)) f(x, y) = f(a, b)
  $
]

#example[
  Consider approachinhg $f(x, y) = (x y) / (x^2 + y^2)$ along $y = m x$.
  $
    (x y) / (x^2 + y^2) & = (x (m x)) / (x^2 + (m x)^2) \
                        & = (m x^2) / (x^2 + m^2 x^2) \
                        & = (m x^2) / ((1 + m^2) x^2) \
                        & = m / (1 + m^2) "if" x eq.not 0
  $
  Hence, it depends on $m$.
  The value of the limit would vary as $m$ changes, while $m$ can be arbitrary values.
  Thus, the limit does not exist.
]

In the example above, we approached the point along a straight line, which is not quite ideal in a 3D space.
If we can have a 2D domain for the function, then restrict the domain, the limit would be easier to work with.

#example[
  Since we are approaching a point, restrict the domain to a small disk of radius $epsilon$.
  $
                   x & = r cos(theta) \
                   y & = r sin(theta) \
    D_epsilon (0, 0) & = Set((x, y), x^2 + y^2 <= epsilon) \
                     & = Set((r, theta), 0 <= r <= epsilon, 0 <= theta <= 2pi)
  $
  In polar coordinate form,
  $
         (x y) / (x^2 + y^2) & = ((r cos(theta)) (r sin(theta))) /(r^2 cos^2(theta) + r^2 sin^2(theta)) \
                             & = cos(theta) sin(theta) \
    lim_(r -> 0) f(r, theta) & = cos(theta) sin(theta)
  $
  The limit would be a function of $theta$, thus it does not exist.
]

= Partial Derivative
It is hard to totally derive with multiple variable at the same time.
Instead, we fix all but one variable, and derive against that variable.
In this setup, it is as if we are deriving a normal one-variable function.

#example[
  Consider $z = f(x, y)$.
  - Fixing $y$,
    $
      f_x = pdv(f, x) & = lim_(h -> 0) (f(x + h, y) - f(x, y)) / h.
    $
  - Fixing $x$,
    $
      f_y = pdv(f, y) & = lim_(k -> 0) (f(x, y + k) - f(x, y)) / k.
    $
]
This creates two derivatives of trace curves on planes $y = b$ and $x = a$ where $(a, b)$ is the point being approached.
The tangent lines of these two slopes form a plane.
As expected, the derivative of a curved surface is a plane!

#example(title: [Another example])[
  Consider $f(x, y) = x^4 + 2 x^2 y^2 + e^(x y) + y$.
  $
       pdv(f, x) & = 4 x^3 + 4 x y^2 + y e^(x y) \
       pdv(f, y) & = 4 x^2 y + c e^(x y) + 1 \
    pdv(f, x, y) & = 8 x y + x y e^(x y)
  $
]

#note-box[
  It it not always true that
  $
    f_(x y) (x, y) = f_(y x) (x, y)
  $
]

The calculus rules for full derivative also apply to partial derivative.

#example(title: [Implicit Differentiation in partial derivative])[
  $
            z & = sqrt(1 - x^2 - y^2) \
              & =(1 - x^2 - y^2)^(1/2) \
    pdv(z, x) & = 1/2 (1 - x^2 - y^2)^(-1/2) dot (-2x) \
              & = - x / sqrt(1 - x^2 - y^2) \
              & = - x / z
  $
]

#example(title: [Fundamental Theorem of Calculus with partial derivative])[
  $
      f(x, y) & = integral_x^y g(t) dd(t) \
              & = evaluated(G(t))^y_x \
         g(x) & = pdv(, x) [G(y) - G(x)] \
    pdv(g, x) & = -g(x)
  $
]

== Tangent Plane
We have established that, if a point on a plane is differentiable, all paths through it have the same slope.
We can thus choose two different paths and make a plane out of those, which will be the tangent plane of that point on that plane.

We already know one point on the tangent plane, so its equation form can be
$ A (x - x_0) + B (y - y_0) + C (z - z_0) = 0 $ where $A, B, C$ are some constants.
From the two tangent lines we know two expressions of one of the unknowns by the other two.
Using three equations, we can solve for $A, B, C$.

== Linear Approximation
Similar to how we linearly approximate 2D curves, 3D surfaces can be approximated by
$
  L(x, y) = pdv(z, x)(a, b) (x - a) + pdv(z, y)(a, b) (y - b).
$

And, when we let the difference between $x$ and $a$, $y$ and $b$, infinitesimally small, we get...

== Total Differential
#definition(title: [Total Differential])[
  Let $z = f(x, y)$.
  $
    Delta x & = dd(x) \
    Delta y & = dd(y) \
    Delta z & = f(x + dd(x), y + dd(y)) - f(x, y) \
      dd(z) & = L(x + dd(x), y + dd(y)) - L(x, y) \
            & = pdv(z, x) dd(x) + pdv(z, y) dd(y).
  $
]

If there exists a total differential, we say $f(x, y)$ is differentiable.

#example[
  Given a hollow cylinder with 4 diameter, 10 height, 0.1 top and bottom thickness, 0.05 side thickness.
  Its solid volume is
  $
        V & = pi r^h \
    dd(V) & = underbrace(pdv(V, r) dd(r), #[side]) + underbrace(pdv(V, h) dd(h), #[top & bottom]) \
          & = 2 pi r h dd(r) + pi r^2 dd(h) \
          & = 2 pi dot 2 dot 10 dot 0.05 + pi dot 2^2 dot (0.1 + 0.1) \
          & = 8.8.
  $
]

=== Chain Rule
We use a dependency tree to resolve chained differentials.
This is especially useful for differentials with multiple variables.

Let $w = f(x(t), y(t), z(t))$.
#figure(
  caption: [A simple dependency tree],
  {
    import fletcher: *
    diagram(
      spacing: .5cm,
      $
                                       & x edge() & t \
        w edge("ru") edge("rd") edge() & y edge() & t \
                                       & z edge() & t
      $,
    )
  },
)
Then we can turn each branch into a term of the differential of $w$,
$
  dd(w) = pdv(w, x) dv(x, t) + pdv(w, y) dv(y, t) + pdv(w, z) dv(z, t).
$

For secondary dependencies that also depends on more than one variable, we could allow only one bottom-level variable to vary, then differentiate each, thus the top-level variable in regard to that bottom-level variable.

Let $z = f(x, y), x = g(s, t), y = h(s, t)$.
#figure(
  caption: [A slightly deeper dependency tree],
  {
    import fletcher: *
    diagram(
      spacing: .5cm,
      $
                                &                     & s \
                                & x edge("ru") edge() & t \
        z edge("ru") edge("rd") &                     & s \
                                & y edge("ru") edge() & t \
      $,
    )
  },
)
$
                  pdv(z, s) & = pdv(z, x) pdv(x, s) + pdv(z, y) pdv(y, s) \
                  pdv(z, t) & = pdv(z, x) pdv(x, t) + pdv(z, y) pdv(y, t) \
  vec(pdv(z, s), pdv(z, t)) & = mat(pdv(x, s), pdv(y, s); pdv(x, t), pdv(y, t)) vec(pdv(z, x), pdv(z, y)).
$

#theorem(title: [Implicit Function])[
  In a non-function relationship, there exist regions of that relationship which are functions.
]

#example[
  Let $F(x, y, z) = x^3 - y^4 z + e^(x z^2)$.
  It is impossible to explicitly solve $z$ for $F(x, y, z) = 0$.

  However, $z = f(x, y)$ may be true on some regions of this relationship.
  In that case, $ F(x, y, z) = F(x, y, f(x, y)) = 0 $ is solvable.
  #figure({
    import fletcher: *
    diagram(
      spacing: .5cm,
      $
                                       & x                   &   \
        F edge("ru") edge("rd") edge() & y                   & x \
                                       & z edge("ru") edge() & y \
      $,
    )
  })
  Differentiate regarding $x$,
  $
               pdv(, x) [F(x, y, z) & = 0] \
    pdv(F, x) + pdv(F, z) pdv(z, x) & = 0 \
                          pdv(z, x) & = - pdv(F, x) / pdv(F, z).
  $
  Differentiate regarding $y$,
  $
    pdv(z, y) & = - pdv(F, y) / pdv(F, z).
  $

  Given that at $(0, 1, 1)$, $pdv(z, x) = 1, pdv(z, y) = -4$, then
  $
    z - 1 & = 1 (x - 0) - 4 (y - 1) \
        z & = x - 4y + 5.
  $
  Thus, in that certain region, we can use this simple function of $z$.
]

== Directional Derivative and Gradient Vector
Since a point can be approached from many directions, derivatives can be directional.

Now imagine looking for the highest ($max(z)$) point of a curve on a surface.
+ Parameterize the line, so $x, y$ depend on one variable $t$;
+ compute $dv(z, t)$, using chain rule.
The rest is like single-variable calculus.

We say the rate of change of $x, y$ is the 'velocity' vector,
$
  vb(v) = vec(dv(x, t), dv(y, t))
$
and the rate of change of $z = f(x, y)$ is the gradient vector,
$
  grad f = vec(pdv(f, x), pdv(f, y))
$
This gradient is not the slope of the curve at the point, rather, it is the steepest slope alone the curve at the point.
$grad f(x_0, y_0)$ is always perpendicular to the contour line of $z = f(x, y)$ through $(x-), y_0$.
To prove this, parameterize a contour curve $r(t) = [x(t), y(t)]$, derive regarding $z$ along it, and the result can be written in the form of
$
  grad f(x(t), y(t)) dot r'(t) = 0.
$

And since $z = f(x, y), f(x, y) - z = 0$.
The normal becomes
$
  vb(n) = vec(-pdv(f, x), -pdv(f, y), 1)
$
as we define it to have a positive $z$ value.

#definition(title: [Directional Derivative])[
  The directional at $(x_0, y_)$ is the rate of change of $f(x, y)$ at $(x_0, y_0)$ in direction of $vu(u)$ at constant speed of 1.
  Obtained via
  $
    Dif_vu(u) f(x_0, y_0) & = grad f(x_0, y_0) dot vu(u) \
                          & = abs(grad f(x_0, y_0)) cos(theta)
  $
  where $theta$ is the angle between $vu(u)$ and $grad f(x_0, y_0)$.
]

To obtain the highest value of the directional derivative, a.k.a the steepest ascent, we take $max(cos(theta)) = 1$, which means $theta = 0$, $vu(u)$ is in the same direction as $grad f$, which happens to be the gradient vector.

== 3D Gradient
#definition(title: [3D Gradoent and Directional Vector])[
  For $w = F(x, y, z)$, define
  $
         grad F & = [pdv(F, x), pdv(F, y), pdv(F, z)] \
    Dif_vu(u) F & = grad F dot vu(u).
  $
  It would be the gradient of a "3D" surface -- a $4-1$ dimensional hypersurface in a 4 dimensional space.
]

#definition(title: [Level Surface])[
  We say $F$ is a level surface iff $F(x, y, z) = k$ where $k$ is some constant.
]

The tangent plane at a certain point $(x_0, y_0, z_0)$ would be
$
  grad F(x_0, y_0, z_0) dot [x - x_0, y - y_0, z - z_0] = 0,
$
The gradient vector being its normal.

== Maximum and Minimum of Multivariable Functions
Just like single-variable functions, we can differentiate the function and differentiate the derivative to find out minimum and maximum points.
We should also worry about saddle (instead of inflection) and singularity.

#definition(title: [Critical Point])[
  A critical point is either a maximum, a minimum or a saddle point.
  It has
  $
    pdv(f, x) (a, b) = pdv(f, y) (a, b) = 0.
  $
]

To distinguish between the kinds of critical points, we take the second derivative.
To compute the second derivative (discriminant), we use a suprising method involving determinant.
$
  D(x, y) & = matrixdet(pdv(f, x, 2), pdv(f, x, y); pdv(f, y, x), pdv(f, y, 2)) \
          & = pdv(f, x, 2) pdv(f, y, 2) - pdv(f, x, y) pdv(f, y, x).
$
Many times, $pdv(f, x, y) = pdv(f, y, x)$ so the equation can be further simplified.

The matrix used above is a Hession Matrix, not covered in this course, which is used for discriminants of functions of arbitrary dimensions.
It involves using the sum and product of eigenvalues, which results in the rules we see below:

#definition(title: [Classification of Critical Points])[
  A critical point $(a, b)$ is
  - a local minimum if $D(x, y) (a, b) > 0, pdv(f, x, 2) (a, b) > 0$;
  - a local maximum if $D(x, y) (a, b) > 0, pdv(f, x, 2) (a, b) < 0$;
  - a saddle point if $D(x, y) (a, b) < 0$.

  If $D(x, y) (a, b) = 0$, the test yield no result.
]

=== At Boarders of Domain
If no local minimum or maximum are found, but the domain is indeed bounded, we would compute the boundary of the surface.

Given a restricted surface $S$, we say $diff S$ is its boundary,
$
  diff S & = #[the set of points on the boundary].
$

If the functions of edges are nice enough (some variables restricted), we find minimum/maximum of the dges.

== Extreme Values Under Constraints

#definition(title: [Lagrange Multiplier Method])[
  Given function $f(x, y)$ with a  constraint $g(x, y) = 0$.
  To find extreme values, solve for
  $
    x, y, lambda suchthat cases(grad f = lambda grad g, g(x, y) = 0)
  $
  where $lambda in RR$ is called the Lagrange Multiplier.

  It extends to high dimensions and more constraints.

  #proof[
    For 2D functions only, let $vb(r)(t) = [x(t), y(t)]$ be the contour of $g(x, y) = 0$.
    If $f(vb(r)(t))$ is extremal, we have
    $
      0 = dv(, t) f(vb(r)(t)) & = pdv(f, x) dv(x, t) + pdv(f, y) dv(y, t) \
                              & = grad f dot vb(r)
    $
    Since, by definition of gradient, $grad f perp vb(r)', grad g perp vb(r)'$, we have $grad f = lambda grad g$ for some $lambda in RR$.
  ]

  For higher dimension functions, the proof is not valid as there are many orientations for $grad f$ to be perpendicular to $vb(r)'$.
]

