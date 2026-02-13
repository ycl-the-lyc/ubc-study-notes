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
+ Locate the controlling variables.

V branches can be combined with parallel branches to be a super-node.
Choosing either end of a V branch makes its voltage drop known.

#note-box[
  Learn about Y-Δ transform, so you don't have to do this.
]

== Power and Relative Polarity
Current from higher voltage to lower voltage is absorbing power.
Otherwise, it is delivering power.

#definition(title: [Bipolar Junction Transistor])[
  An NPN or PNP transistor that amplifies current.
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

= Capacitor and Inductor
#definition(title: [Steady State])[
  A circuit is in a steady state if
  - all independent sources are in DC;
  - all switches have not operated for _a long time_.

  We call such state "DC steady state" (DCSS).
]

Recall from PHYS 158 that the functions of voltage or current in capacitors and inductors are exponential.
$
  f(t) = & (f_0 - f_f) e^(-t / tau) + f_f.
$

We see $5 tau$ as _a long time._

#example[
  Given
  $
    i(t) = 7 e^(-t / 5),
  $
  the current has an amplitude of $ampere(7)$ and $tau$ of $second(5)$.
  When $t >= second(25)$, the current is considered steadily $ampere(0)$.
]

Using KCL or KVL, we can write a first-order ordinary differential equation about the circuit.

== Capacitor
$
  i(t) = & C dv(v, t) \
  E(t) = & C integral_0^t v(t) dd(v) \
       = & 1 / 2 C v^2 quad ("DCSS")
$

#note-box[
  Capacitors maintain voltage, but not current.
  $
         v(t^-) = & v(t^+) \
    i(t^-) eq.not & i(t^+).
  $
]

In DCSS, a capacitor is like an open circuit.

== Inductor
$
  v(t) = & L dv(i, t) \
  E(t) = & L integral_(0)^(t) i(t) dd(i) \
       = & 1 / 2 L i^2 quad ("DCSS")
$

#note-box[
  Inductors maintain current, but not voltage.
  $
         i(t^-) = & i(t^+) \
    v(t^-) eq.not & v(t^+).
  $
]

In DCSS, an inductor is like a short circuit.

== RC Circuit
Given a voltage source, a resistor and a capacitor in series, they are an RC circuit.
$
  R C dv(v_C, t) + v_C = & v_s \
                   tau = & R C.
$

== RL Circuit
Given a voltage source, a resistor and an inductor in series, they are an RL circuit.
$
  L dv(i, t) + R i = & v_s \
               tau = & L / R.
$

= Amplifiers
#definition(title: [Signal])[
  A function of time that carries information.

  An electric signal is a signal of voltage or current.
  Other signals can be transduced into electric signals.
]

== Simple Amplifier
A typical amplifier is a two-port network, with one for input and one for output.
$
   p_"in" = & i_"in" v_"in" \
  p_"out" = & i_"out" v_"out".
$

#note-box[
  Ports have a seemingly different idea of series and parallel connection.
]

The boost ratio of $v, i, p$ are called "gain".
$
        A = & "out" / "in" \
  A^bel() = & lg (A) \
   A^db() = & 10 lg (A).
$

Gains can be cascaded multiplicatively.
When in logarithm (#bel(), #db()) forms, take their sum instead of product.

#figure(
  caption: [Decibel Ratio Approximations],
  table(
    columns: 2,
    table.header[#db()][Amplification],
    $3$, $2$,
    $6$, $4$,
  ),
)

When comparing two resistors, we can compute their power gain in Decibel using currents or voltages.
$
  A_i = & 20 lg (i_"out" / i_"in") \
  A_v = & 20 lg (v_"out" / v_"in").
$

We may see Decibel values representing one quantity by setting a certain input value, usually $1$.
For instance, #dbmw() is #db() with one milliwatt as the denominator.

== Operational Amplifier
An operational amplifier has
- an input port with $v_p$, the non-inverting input terminal;
- an input port with $v_n$, the inverting input terminal;
- an output port with $v_o$;
where the ports are defined with a common reference.

The gain is applied to the difference between $v_p$ and $v_n$: $A (v_p - v_n)$, the open-loop voltage gain.

Given the three wires ($v_p, v_n, "ref"$) defining the two input ports, there is a resistance between every two, so three in total.
They are equivalent to one resistor between $v_p$ and $v_n$.

#figure(
  caption: [Equivalent Circuit of an Operational Amplifier],
  image("assets/op-amp-internal.svg", width: 33%),
)

$R_"in"$ is made as large as possible, with an ideal one being infinity, such that it does not suck current from source.
$R_"out"$ is made as small as possible, ideally zero.
Thus, $A$ will be as large as possible, ideally infinity.
Additionally, its output voltage is limited by $V_(S+), V_(S-)$, or $V_"cc", - V_"cc"$ since it is the power supply for this operational amplifier.
Reaching this limit is called "saturation".

In reality, $R_"in" in [ohm("100k"), ohm("10T")]$, $R_"out" in [ohm(10), ohm(100)]$, $A in [num("100k"), num("100M")]$.
There is also a voltage inset to $V_S$, so saturation can be reached easier than ideal.

=== Negative Feedback
To limit the ideally infinite voltage gain, we take some amplified voltage to the inverting input terminal.
This is called negative feedback.

With a resistor from voltage source to $v_n$, and another resistor from $v_"out"$ to $v_n$ (the negative feedback), we can solve the circuit to find that
$
  lim_(A -> oo) v_n = & v_p
$
when there is no saturation.

This equality is useful in MNA.
However, we need to check for saturation after the fact, since we cannot check it before solving the circuit.

#note-box[
  Look up inverting amplifier and non-inverting amplifier configurations using resistors and operational amplifiers.
  And, summing and subtracting amplifiers that use variable resistor to control contribution of each signal.
  And, calculus amplifiers that does magic.

  They all use the convenient property that $v_n = v_p$.
]

=== Offset Balance
In reality, the $v_p$ and $v_n$ inputs are not perfectly balanced to produce $volt(0)$ when equal.
Hence, two extra pins ($1, 5$) are left for the offset balance:
The user adds a resistance between the two pins so the operational amplifier outputs $volt(0)$ when balanced.

When the voltage output is precisely zero, the operational amplifier becomes a current source.

