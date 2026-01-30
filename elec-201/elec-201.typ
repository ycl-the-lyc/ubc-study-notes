#import "@preview/zap:0.5.0"
#let circuit = zap.circuit.with(variant: "ieee")

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
    sum p_"absorbed" = sum p_"delivered".
  $

/ KVL: $
    sum_"loop" v = 0
  $
  where loop can follow wires or not.
/ KCL: $
    sum_"Gauß" i_"in" = sum_"Gauß" i_"out".
  $

= Eletric Properties of Matter and Circuit Elements
We use four basic, ideal elements to describe a circuit:
- resistor
- inductor
- capacitor
- source
which do not correspond to real components.

In real life, a "resistor" is a resistor and an inductor in series, paralelled with a capacitor; a "battery" is a voltage source and a resistor.
But we say "resistor" as if it is a resistor, and we say "source" instead of "battery".

We call elements that absorb power all the time "passive", and those absorb then release power "reactive".
Sources are called "active" elements.

== Eletric Properties of Matter
/ Ohm's Law: Matter opposes current flowing through it, even to that called a "conductor".
  $
    v & = R i \
    p & = R i^2 = v^2 / R.
  $
  where $R$ is resistance, measured in $vpera()$ which is $ohm()$.
/ Faraday's Law: Matter opposes _changes_ of current already flowing through it.
  $
      v & = L dv(i, t) \
      p & = L i dv(i, t) \
    E_L & = integral p dd(t) = 1/2 L i^2.
  $
  where $L$ is inductance, measured in $vspera()$ which is $henry()$.
/ Ampere's Law: Matter opposes _changes_ of voltage already applied to it.
  $
      i & = C dv(v, t) \
      v & = 1/C integral i dd(t) \
      p & = C v dv(v, t) \
    E_C & = integral p dd(t) = 1/2 C v^2.
  $
  where $C$ is capacitance, measured in $asperv()$ which is $farad()$.

It is convention to draw an arrow for current flow and a pair of $+, -$ for voltage drop.

== Ideal Sources
/ Voltage Sources: Sources that keep a voltage difference.
/ Current Source: Sources that keep a current flow.

The current through a voltage source, and the voltage drop across a current source, depends on what they are connected to.

/ Independent Sources: Sources that maintain its own output, shaped round.
/ Dependent Sources: Sources whose output depend on others, shaped square.

= Topology of Circuits
If we remove all elements, the wires and joints of wires are left.
That is the topology of a circuit.

/ Branch: An line between true (non-binary) nodes.
/ Node: A joint of branches, of at least three terminals.
/ Binary Node: A joint of two parts of one branch.
/ Atomic Branch: A branch with one element.

#important-box[
  A node includes all connecting wires, until the elements.
  This means that wires drawn to have multiple juctions form only one node, so long as the junctions are not separated by elements.
]

Two elements are in series if they are on the same branch.
Two elements are in paralell if they are on two different atomic branches, which branches share a common node.

We can enclose part of a circuit with a Gauß surface, which becomes a super-node.

== KCL
A node, or a super-node is often more convinient than dealing with elements and wires directly.

#theorem[
  At any Gauß surface, the current input is the same as the current output.
]

Consequently, elements on a branch can be enclosed in many different Gauß surfaces, and their current input and output are the same.

#theorem[
  The current in all elements on a branch is the same.
]

== KVL
/ Loop: A closed trajectory that does not cross a node more than once.
/ Window Pane (Mesh) Loop: A loop that does not contain any loops.

#theorem[
  The voltage drop in a loop is zero.
]

== Branches
Here, V, I means their corresponding sources.
C, L are ignored here, since the syllabus does not cover AC; in DC, they become open circuit and wire.

In an R branch,
$
  i = (v_"orig" - v_"dest") / R.
$

In an RV branch, since there is a voltage source,
$
  i = (v_"orig" - v_"dest" + v_"src") / R.
$

In a V (evil) branch,
$
  v_"dest" & = v_"orig" + v_"src" \
         i & "is unknown".
$

In an I or RI branch,
$
  i = i_"source".
$

== Modified Nodal Analysis
Basically a combination of KVL, KCL and nodal analysis.

/ Controlling Variable: A variable depended by dependent sources.
/ Control Equation: An expression of a dependent source.

+ Choose a reference.
+ Assume current directions in R and RV branches.
+ Label the true nodes; do KCL at each.
+ Label the currents in V branches; do KVL with each.
+ Locate the controling variables.

V branches can be combined with paralell branches to be a super-node.
Choosing either end of a V branch makes its voltage drop known.

#note-box[
  Learn about Y-Δ transform, so you don't have to do this.
]

== Power and Relative Polarity
Current from higher voltage to lower voltage is absorbing power.
Otherwise, it is delivering power.

#definition(title: [Bipolar Junction Transistor])[
  A NPN or PNP transistor that amplifies current.
  It has a controlling _base,_ an input _collector,_ and an output _emitter._

  The PNP transistor has current direction in each port inverted (to its name).
]

== Thevenin and Norton Equivalents
#definition(title: [Linear Circuit])[
  A circuit whose voltages and currents are linear combinations of all independent sources.
]

#definition(title: [Port])[
  Two nodes make one port.
  Given $n$ nodes, there would be
  $
    nck(n, 2) = n! / (2 (n - 2)!)
  $
  ports.
]

#definition[
  / Thevenin Equivalent: A voltage source and a resistor in series.
  / Norton Equivalent: A current source and a resistor in parallel.
]

To get a Thevenin Equivalent of a circuit:
+ Choose a port.
+ Measure the voltage across the port to get $V_"th"$.
+ - Short-circuit the port, measure the current to compute $R_"th"$.
  - In case shorting it is undesirable, add an external resistance $R_x$ to the port and use voltage divider for $R_"th"$.

In computation, take the limit of $R_x -> 0$ and $R_x -> oo$ to solve for $I_"sc", V_"th"$ respectively.

