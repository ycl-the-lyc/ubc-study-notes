#import "../lib.typ": *
#show: setup.with(
  title: [ELEC 201 \ _Circuit Analysis_],
  author: "Yecheng Liang",
)

= Vocabulary of ECT

/ Charge: Eletric charge, denoted $q$, measured in coulombs, $coulomb()$.

  An electron carries $coulomb(-1.602e-19)$ of charge, which is the smallest amount of charge in our discussion.
  Its charge counterpart, a protone, carries that amount of positive charge.

/ Current: Eletric current, denoted $i$, measured in coulombs per second, $coulombpers()$, which is $ampere()$.

  The direction of current is defined as the direction of flow of positive charges, despite, it is usually the electrons.

  Measuring current is to be avoided, for obvious reasons.
  To represent non-constant current, we use
  $
    i(t) = dv(q(t), t).
  $

/ Voltage: Electric potential, denoted $v$, measured in $jpercoulomb()$, which is $volt()$.
  The zero potential reference is the Earth for circuits connected to the earth.
  Otherwise, the reference is arbitrary.

  Measuring voltage is non-intrusive, hence much more viable than measuring current.

/ Power: Rate of work being done, denoted $p$, measured in $jpers()$, whihc is $watt()$.
  $
    p = v i.
  $

/ Tellegen's Theorem: Total power in a circuit is zero.
  $
    sum P_"absorbed" = sum P_"delivered".
  $

= Eletric Properties of Matter and Circuit Elements
We use four basic, ideal elements to describe a circuit:
- resistor
- inductor
- capacitor
- source
which do not correspond to real components.

== Eletric Properties of Matter
- Matter opposes current flowing through it, even to that called a "comductor".
  $
    v = R i
  $
  where $R$ is resistance, measured in $vpera()$ which is $ohm()$.
- Matter opposes _changes_ of current already flowing through it.
  $
    v = L dv(i, t)
  $
  where $L$ is inductance, measured in $vspera()$ which is $henry()$.
- Matter opposes _changes_ of voltage already applied to it.
  $
    i & = C dv(v, t) \
    v & = 1/C integral i dd(t).
  $
  where $C$ is capacitance, measured in $asperv()$ which is $farad()$.

It is convention to draw an arrow for current flow and a pair of $+, -$ for voltage drop.

