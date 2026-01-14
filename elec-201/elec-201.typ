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

