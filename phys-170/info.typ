#import "@preview/physica:0.9.5": *
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
  cell(colspan: 20, rowspan: 2)[
    #underline[*Support*] \
    Hinges that prevents translation in the same direction does NOT produce couple moment, but force in that direction.
  ],
  cell(colspan: 8, rowspan: 6)[
    #underline[*Cartesian*] \
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
  cell(colspan: 4, rowspan: 5)[
    #underline[*Cylindrical*] \
    Polar but with an additional axis, $z$.
    $
      va(u)_z = va(u)_theta times va(u)_r
    $
  ],
  cell(colspan: 8, rowspan: 5)[
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
  cell(colspan: 12, rowspan: 5)[
    #underline[*Tangential-Polar*] \
    Let $psi$ be the angle between $va(r)$ and $va(u)_t$, $eta$ be the angle between the tangential and the polar axis.
    $
      tan(psi) &= (r dot(theta)) / dot(r) = r / dv(r, theta) \
      eta =& 90 degree - psi \
      va(u)_N =& va(u)_r cos(eta)
    $
  ],
  cell(colspan: 8, rowspan: 4)[
    #underline[*Polar*] \
    $
      va(v) =& dot(va(r)) \
      =& v_r va(u)_r + v_theta va(u)_theta \
      =& dot(r) va(u)_r + r dot(theta) va(u)_theta \
      va(a) =& (dot.double(r) - r dot(theta)^2) va(u)_r + (r dot.double(theta) + 2 dot(r) dot(theta))
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
)
