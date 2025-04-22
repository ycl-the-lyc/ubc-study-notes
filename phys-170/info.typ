#import "@preview/physica:0.9.5": *
#import "@preview/unify:0.7.1": *
#let lb = $"lb"$
#let vu = math.hat
#import table: *

#set page(margin: 0pt)

#set text(size: 1em, font: "MonaspiceRn NFP", weight: "light")
#set heading(numbering: none, outlined: false)
#set par(justify: false, leading: 0.5em)
#set math.equation(numbering: none)
#show math.equation: set text(font: "DejaVu Math TeX Gyre")

#set cell(inset: 1.3em)

#table(
  stroke: .1pt + gray,
  columns: (5%,) * 20,
  rows: (5%,) * 20,
  cell(colspan: 10, rowspan: 2)[
    #underline[*Support*] \
    Hinges that prevents translation in the same direction does NOT produce couple moment, but force in that direction.
  ],
  cell(colspan: 10, rowspan: 2)[
    #underline[*Friction*] \
    $F_s = mu_s "(impending motion)", F_k = mu_k N$. \
    Use moment equilibrium to determine point of normal force.
  ],
  cell(colspan: 8, rowspan: 6)[
    #underline[*Tangential Coord.*] \
    $
      rho =& [1 + (dv(x, y))^2]^(3 / 2) / dv(y, x, 2) \
      va(v) =& v va(u)_t
    $
    $
      dot(theta) =& v / rho \
      va(a) =& dot(v) va(u)_t + v dot(va(u)_t) \
      =& dot(v) va(u)_t + v^2 / rho va(u)_n
    $
  ],
  cell(colspan: 4, rowspan: 4)[
    #underline[*Cylindrical Coord.*] \
    Polar but with an additional axis, $z$.
    $
      va(u)_z = va(u)_theta times va(u)_r
    $
  ],
  cell(colspan: 8, rowspan: 4)[
    #underline[*Linear Momentum and Impulse*] \
    $
      va(L) =& m va(v) \
      va(I) =& integral_(t_1)^(t_2) va(F)(t) dd(t)
    $
    $
      m vb(v)_1 + sum integral_(t_1)^(t_2) vb(F) dd(t) =& m vb(v)_2
    $
    Can be conserved.
  ],
  cell(colspan: 12, rowspan: 2)[
    #underline[*Vector Components*]
    $
      va(v)_parallel = (va(v) dot vu(u)) vu(u)
      quad&
      va(v)_perp = va(v) - va(v)_parallel \
      va(v)_1 dot va(v)_2 = v_1 v_2 cos(theta)
      quad&
      va(v)_1 times va(v)_2 = v_1 v_2 sin(theta) va(n) "(right-hand)"
    $
  ],
  cell(colspan: 12, rowspan: 4)[
    #underline[*Tangential-Polar*] \
    Let $psi$ be the angle between $va(r)$ and $va(u)_t$, $eta$ be the angle between the tangential and the polar axis.
    $
      tan(psi) &= (r dot(theta)) / dot(r) = r / dv(r, theta) \
      eta =& 90 degree - psi \
      va(u)_r =& va(u)_n cos(eta)
    $
  ],
  cell(colspan: 8, rowspan: 4)[
    #underline[*Polar Coord.*] \
    $
      va(v) =& dot(va(r)) \
      =& v_r va(u)_r + v_theta va(u)_theta \
      =& dot(r) va(u)_r + r dot(theta) va(u)_theta \
      va(a) =& (dot.double(r) - r dot(theta)^2) va(u)_r + (r dot.double(theta) + 2 dot(r) dot(theta)) va(u)_theta
    $
  ],
  cell(colspan: 12, rowspan: 4)[
    #grid(
      columns: (1fr,) * 2,
      column-gutter: 0.65em,
      [
        #underline[*Energetics*] \
        $
          U_"const" =& F cos(theta) (b - a) \
          U_"var" =& integral_a^b F cos(theta) dd(s) \
          U_"spring" =& 1 / 2 k (s_b^2 - s_a^2) \
        $
      ],
      [
        #v(1.3em)
        $
          T =& 1 / 2 m v^2 \
          V_g =& W h = m g h \
          V_s =& plus 1 / 2 k s^2
        $
        Can be conserved.
        $
          T_1 + V_1 = T_2 + V_2
        $
      ],
    )
  ],
  cell(colspan: 8, rowspan: 4)[
    #underline[*SI-Imperial*]

    Constants:
    $
      g =& qty("9.81", "m/s^2") = qty("32.2", "m/s^2")
    $
    Units:
    $
      "mass":& unit("kg"), unit("s^2/ft") \
      "force":& unit("kg m/s^2"), unit("lb")
    $
  ],
  cell(colspan: 10, rowspan: 4)[
    #underline[*Moment*]
    $
      va(M) =& va(r) times va(F) \
      M =& r F sin(theta) = F d
    $
    Vector moments of the same point add up like forces.

    Couple moments can move to anywhere.
    To move a force, add a pair of force on the target point, then make a couple moment.
  ],
  cell(colspan: 10, rowspan: 4)[
    #underline[*Reduction to a Wrench*]
    + Get a resultant force;
    + get a resultant moment to a point;
    + split the moment into parallel and perpendicular components to the force;
    + remove the perpendicular components by moving the force ($M = F d$);
    + move the parallel moment to the force.
  ]
)
