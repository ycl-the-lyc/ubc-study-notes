#import "@preview/circuiteria:0.2.0" as ca
#import "@preview/cetz:0.4.1"
#import ca: circuit
#let defelem(..args) = arguments(x: 0, y: 0, w: 1.5, h: 1.5) + args
#let gatemap = {
  import ca.gates: *
  (
    "buf": gate-buf,
    "not": gate-not,
    "or": gate-or,
    "and": gate-and,
    "xor": gate-xor,
    "nand": gate-nand,
    "xnor": gate-xnor,
  )
}

#let cmpl = math.overline

#let nf(id, delim: ".", ..nums) = $upright(#id)#nums.pos().join(delim)$

// disable OpenType ligature for sv code
#show raw.where(lang: "sv"): set text(features: (calt: 0))

#import "../lib.typ": *
#show: setup.with(
  title: [CPEN 211 \ _Digital Design & Computer Architecture_],
  author: "Yecheng Liang",
)

= Number Systems
#figure(caption: [Commonly used values], table(
  columns: 3,
  table.header([Binary], [Decimal], [Hexidecimal]),
  [0100], [4], [4],
  [1010], [10], [A],
  [1111], [15], [F],
))

== Conversion

=== To Decimal
+ Compute each digit's value in decimal;
+ sum them up.

=== From Decimal
+ Divide by $n$;
+ take remainder as digit;
+ take quotient as the next digit;
+ repeat until quotient is 0.

#example(title: [Decimal to binary and hexadecimal])[
  #let div = math.div
  + $11 div 2 = 5 ... 1$
  + $5 div 2 = 2 ... 1$
  + $2 div 2 = 1 ... 0$
  + $1 div 2 = 0 ... 1$
  $11_10 = 1011_2$

  + $111 div 16 = 6 ... 15$
  + $6 div 16 = 0 ... 6$
  $111_10 = 6"F"_16$
]

=== Between Hexidecimal and Binary
Each hex digit is four binary digits.

#example(title: [Hexadecimal-binary conversion])[
  #grid(
    columns: 5,
    inset: .65em,
    [Hexadecimal], [F], [A], [2], [C],
    [Binary], [1111], [1010], [0010], [1100],
  )
  #grid(
    columns: 3,
    inset: .65em,
    [Binary], [0101], [1010],
    [Hexadecimal], [5], [A],
  )
]

#definition(title: [Bit, byte and nibble])[
  A bit is a binary digit.
  A byte is 8 bits.
  A nibble is 4 bits.
]

A nibble has 16 possible combinations, hence it can represent a hexadecimal number.

=== Large Number Units
#figure({
  table(
    columns: 3,
    table.header([Name], [Computer], [Conventional]),
    ..([kilo], [mega], [giga], [tera], [peta], [exa])
      .zip(
        range(1, 7).map(p => {
          let pb = p * 10
          let pd = p * 3
          ($2^#pb = #calc.pow(2, pb)$, $10^#pd$)
        }),
      )
      .flatten(),
  )
})

== Addition and Subtraction
Just add 'em.
For subtraction, convert it to addition of negative numbers.

#example(title: [Adding unsigned or two's complement binary numbers])[
  #ladd(
    numeral: 2,
    1010,
    0010,
  )
]

== Sign/Magnitude Numbers
The most significant bit indicates the sign: 0 means positive, 1 means negative.

Since one bit is occupied with the sign, the number is actually $n - 1$ bit.
The range an $n$ bit int can repreent is $[-2^(n - 1) + 1, 2^(n - 1) - 1]$.
There are two bit combinations for 0 --- each for a sign bit.

To add, replace the sign bit with an actual sign, then operate.

#example(title: [Adding sign/magnitude numbers])[
  $
    (-6)_10 + 6_10 & = 0 \
       1110 + 0110 & => -110 + 110 \
                   & = 0
  $
]

== Two's Complement Numbers
There is no sign bit.
The first half, $[000...000, 011...111]$, represents non-negative numbers, caps at $2^(n - 1) - 1$.
The second half, $[100...000, 111...111]$, represents negative numbers, from the _most negative_ to $-1$

Since there are no duplicate 0 representations, the representation range is $[-2^(n - 1), 2^(n - 1) - 1]$.

To invert the sign, invert all bits, then $+1$, there being one more number in the negative space.

To add, simply add, then remove overflow.

#example(title: [Adding two's complements])[
  $
                   (-6)_10 + 6_10 & = 0 \
    #ladd(numeral: 2, 1010, 0110) & => 0000 \
                                  & = 0
  $
]

== Extension

=== Sign Extension for Two's Complement
To extend and keep value, left-pad the most significant digit.
#example[
  $
    0110 & = 00000110 \
    1110 & = 11111110
  $
]

=== Extension for Unsigned
Left-pad 0's.

= Logic Gates
The base gate representations are: AND, NOT, OR.
Then "N" or "X" can be appended for an additional NOT or exclusivity.

#let drgate(name) = circuit({
  import ca: *
  import wire: *
  gatemap.at(name)(id: "g", ..defelem())
  stub("g-port-in0", "west")
  if name not in ("buf", "not") { stub("g-port-in1", "west") }
  stub("g-port-out", "east")
})

#figure(caption: [Common logic gates], table(
  columns: gatemap.len(),
  ..gatemap.keys().map(drgate),
  ..gatemap.keys().map(upper),
))

Each gate is at least a buffer, which delays DC transfer.

== DC Transfer
Always make sure the voltage to a chip is not too low or too high for triggering HIGH and LOW.
Different chips have voltage specifications different.

#definition(title: [CMOS])[
  Complementary metal oxide semiconductor.
]

Logic gates are built from transistors.
Due to the imperfectness of real world, the voltages for LOW and HIGH are not exactly 0 and 5V or something.
If a gate with multiple input has unknown input, it might blow up!

== Silicon to Transistor
Transistors are made from silicon and additives.

Pure silicon crystal is a poor conductor if electricity, but doped silicon, for example, with As and B, allows the additive to produce mobile electrons.
The part with electrons, the negative, is called the "n type"; otherwise it is the "p type".
Either can be both the source and the drain.

Polysilicon, which is a good conductor, is be placed above the plate, seperated by a layer of insulating but thin silicon dioxide.
That forms a capacitor.

Now, depending on which type are connected by the channel, and which other type is used as substrate, there are two types of MOS:
- nMOS: n type as source and drain, p type as substrate.
  When input is LOW, it has low resistance, a bad resistor.
  When input is HIGH, it has high resistance, like an open circuit.
- pMOS: p type as source and drain, n type as substrate
  When input is LOW, it has medium resistance, a good resistor.
  When input is HIGH, it has negligible resistance, like a wire.

== Transistor to Gate
Since nMOS is good at blocking current, and pMOS is good at allowing current, nMOS is used to "pull down" the current --- block it from ground; pMOS is used to "pull up" the current --- lead it to appliances.
The pull-up block is connected to $V_"DD"$, the power, the pull-down block is connected to ground.

For an "and" logic, the transistors are connected in series: only when all are not consuming voltage or connecting ground, current flows in that direction.
For an "or" logic, the transistors are connected in parallel: if any one is consuming voltage or connecting ground, current flows in that direction.

= Combinational Logic

== System Verilog
A hardware description language actually has two parts: synthesis and simulation.
Synthesis is the structure of hardware, simulation is running logics.

SystemVerilog (SV) has two types of modules:
- structural: describing components;
- behavioral: declaring procedures.

== Optimization
Say, logic ```sv a & ~b & c | a & ~b & ~c ``` can be optimized to ```sv a & ~b``` as ```sv (c | ~c)``` is always `1`.

== Boolean Arithmetic

#definition(title: [Complement])[
  Let $A$ be a literal, $neg A$ is the complement of $A$, written $cmpl(A)$.
]

#definition(title: [Implicant])[
  Let $A, B, C, ...$ be literals, a product of them or their complements is their implicant.
]

#definition(title: [Minterm & Maxterm])[
  Let $A, B, C, ...$ be input literals, a product containing all the literals is a minterm, a sum containing all the literals is a maxterm.
]

=== Sum of Products
Take a full adder as example, $neg a neg b c_"in" = s$ is one case where $s$ is 1.
We take all cases where $s$ is 1.
$
  s = neg a neg b or neg a b neg c_"in" or a neg b neg c_"in" or a b c_"in" = 1
$
Similarly for $c_"out"$,
$
  c_"out" = neg a b c_"in" or a neg b c_"in" or a b neg c_"in" or a b c_"in" = 1
$

For each output, they are all 0 on all other cases.
Once we ensured the 1 outputs (true), others are automatically 0 (false).

=== Product of Sums
To ensure all 0 values (false), instead of having at least one true in a group of OR's, we have at least a false in a group of AND's.
$
  v = (a + b + c) and (a + neg b + neg c) = 0
$

#tip-box[
  Depending on how many and where the 0's and 1's are, we can choose between SoP and PoS forms for simpler logic.
]

=== Duality
In boolean arithmetic, we can replace all 0 with 1, and all + with #math.times.
#example[
  $
    A dot 1 & = A \
      A + 0 & = A
  $
]

#theorem(title: [Idempotency])[
  Let $A$ be a literal,
  $
    A = A + A
  $
]

#theorem(title: [De Morgan's])[
  $
    cmpl(A dot B dot C dot ...) & = cmpl(A) + cmpl(B) + cmpl(C) + ... \
          cmpl(A + B + C + ...) & = cmpl(A) dot cmpl(B) dot cmpl(C) dot ...
  $
  #align(center, grid(
    align: center + horizon,
    columns: 3 * (1.8cm,),
    rows: 1.6cm,
    circuit({ (gatemap.nand)(..defelem()) }),
    [equals to],
    circuit({
      (gatemap.or)(..defelem(), inverted: ("in0", "in1"))
    }),

    circuit({ (gatemap.or)(..defelem(), inverted: "out") }),
    [equals to],
    circuit({
      (gatemap.and)(..defelem(), inverted: ("in0", "in1"))
    }),
  ))
]

=== Simplification
To simplify a boolean equation, we reduce it to an SoP form, such that
- it has the fewest implicants;
- each implicant has the fewest literals.

Sometimes, we need to use idempotency to simplify equations.

#theorem(title: [Simplification])[
  $
    A + cmpl(A) P & = A + P \
    cmpl(A) + A P & = cmpl(A) + P
  $
  // #proof[
  //   $
  //     A + cmpl(A) P &= A + (A P + cmpl(A) P) ""
  //   $
  // ]
]

#theorem(title: [Consensus])[
  $
    (B dot C) + (cmpl(B) dot D) + (C dot D) = (B dot C) + (cmpl(B) dot D)
  $
]

#note-box[
  More reading on the axioms and theorems of boolean arithmetic, not detailed here.
]

== Boolean Logic to Gates
We already know about the complement (NOT), product (AND) and sum (OR).

In SoP form, each implicant is an AND, and their output all connect to an OR as they are summed together.
You might want to branch a complement immediately for each literal, for consistency and convenience.

== Special Bit Values

#definition(title: [Contention])[
  A contention, $X$, occurs when a circuit tries to drive 0 and 1 at the same output.
  The value is somewhere between 0 and 1.

  A contention usually indicates a bug, but can also mean intentionally uninitialized value.
]

#definition(title: [Floating])[
  Floating, $Z$, occurs when an output has high impedance, or is open.
  A floating can still have a value between 0 and 1, at random.

  It cannot be checked with a voltmeter.
]

== Karnaugh Maps
A Karnaugh Map (K-Map) is an I/O table, with the row and column header being values of evenly-as-possible divided bits, and each body cell being the output for its header combination.

#important-box[
  Make sure only one bit is changed from any neighboring header cell.
  This is known as "greycode".
]

After mapping out the table, we box groups of 1's.
Each box must
- only contain 1's;
- have side length being powers of 2 (1, 2, 4, 8, ...);
- be as large as possible, wrapping around edges if necessary.
Boxes can overlap.

#definition(title: [Prime Implicant])[
  The product of cells in the largest box in a K-Map.
]

For any box larger than 1, we will be able to drop at least one literal from the SoP equation for the output.

#figure(
  caption: [K-Map Example],
  stack(
    dir: ltr,
    {
      place(
        rect(
          width: .8cm,
          height: 1.8cm,
          stroke: red.transparentize(33%),
          radius: .2cm,
        ),
        dx: 2.1cm,
        dy: 2.1cm,
      )
      place(
        rect(
          width: 1.8cm,
          height: .8cm,
          stroke: blue.transparentize(33%),
          radius: .2cm,
        ),
        dx: 2.1cm,
        dy: 3.1cm,
      )
      table(
        columns: 6 * (1cm,),
        rows: 1cm,
        align: center + horizon,
        table.cell(colspan: 2, rowspan: 2, stroke: none, $Y$), table.cell(colspan: 4, $A B$),
        $00$, $01$, $11$, $10$,
        table.cell(rowspan: 2, rotate(-90deg, reflow: true, $C$)),
        $0$, $1$, $0$, $0$, $0$,
        $1$, $1$, $1$, $0$, $0$,
      )
    },
  ),
)

In this example, #text(red)[$cmpl(A B C)$ and $cmpl(A B) C$], #text(blue)[$cmpl(A B) C$ and $cmpl(A) B C$] are boxed together.
We see that, #text(red)[$C$] and #text(blue)[$B$] can be dropped from the equation, $Y = cmpl(A B) + cmpl(A) C = cmpl(A) (cmpl(B) + C)$.

#note-box[
  $X$ can either be 0 or 1. In K-Maps, if it would help simplifying equations, $X$ can be assumed 1 and be boxed.
  Otherwise, $X$ can be assumed 0 and not boxed.
]

== Multiplexer
#definition(title: [Multiplexer])[
  A multiplexer (MUX) is a node that takes control inputs to choose _one_ input as the output.
]

#example[
  $Y = D_0 cmpl(S) + D_1 S$.
]

= Sequential Logic
When output of a circuit comes back as input, it becomes a sequential circuit.

#definition(title: [Sequential Logic])[
  A logic which its output depends on previous inputs.

  In other words, a sequential logic is stateful, it has memory of previous events.
]

== Latch
A latch is a circuit such that when control signal is set to a value, it allows input to pass to output.
Otherwise, it maintains the output regardless of input.

== Flip-flop
With two latches next to each other, using a signal $S$ and its complement $cmpl(S)$ for either latch, there is a short time frame created by the delay from $S$ to $cmpl(S)$ that allows for input.

That will be an edge-triggered flip-flop circuit.
The control input is called a clock, $"CLK"$.
Depending on the timing, the circuit triggers either on the rising or the falling edge.

There can also be a control input called the enable input, $"EN"$.
The flip can only flop when $"EN" = 1$.

Multiple flip-flops using one clock and a set of inputs is called a register.

== Timing
#definition(title: [Propagation Delay])[
  The maximum delay from input to output, $t_"pcq"$.
]

#definition(title: [Contamination Delay])[
  The minimum delay from input to output, $t_"ccq"$.
]

The reason for minimum delay being "contamination" is that it would cause rapid logic changes before signal stabilizes after maximum delay.

During a sample period, the signal being sampled must be stable sometime before the sampling trigger, and sometime after that trigger.

#definition[
  / Setup time: time before trigger data must be stable, $t_"setup"$.
  / Hold time: time after trigger data must be stable, $t_"hold"$.
  / Aperture time: time around trigger data must be stable, $t_"a"$.
]

The _dynamic discipline_ states that, in a sequential circuit, intput must be stable during $t_"a"$.
When it is violated, the final output is chosen random between 0 and 1.

=== Metastability
Like tossing a coin, only for it to land on the edge, a sequential circuit can land in metastable states, where pulses keep it in no stable state.
For example, a S-R latch can have two alternating pulses that activates each gate at a time.

A metastable state will finally fall to a stable state, but it takes more time.

A way to reduce metastability is to make a possibly metastable output an input, than capture that input in clock cycles.
For example, two flip-flops in series.
A clock cycle is _almost_ enough for output of the first flip-flop to stabilize.

== Finite State Machine
#definition(title: [Finite State Machine])[
  A finite state machine (FSM) is a circuit whose output depends on its current state and inputs.
]

A state machine should have
- state register;
- combinational logic.

The register is easily imagined by a flip-flop, where the input is the next state, and the output is the current state.

The current state is input for the combinational logic.
Optionally, an external signal can also be an combinational logic input.

To design an FSM,
+ Define clock cycle, how many bits and how many combinations are used?
+ Create state transition table: in which state, at which input, at what clock count, what is the next state?
  State assignment can be carefully planed to simplify the later boolean logic resolution, so each output has fewer and smaller implicants.
+ Make a truth table for current state, next state and output.
+ Draw Karnaugh maps to determine each boolean logic for each input for each state.
+ Draw the schematic.

#definition(title: [Moore FSM])[
  A Moore FSM is an FSM whose output does not depend on external inputs.
]

Each state in a Moore FSM represents an output that is not in memory; the state itself is the memory.

#definition(title: [Mealy FSM])[
  A Mealy FSM is an FSM whose output does depend on external inputs.
]

A Mealy FSM typically requires less states than a Moore FSM, since an external input will join the control signals.
However, there is a higher risk of input contamination, thus require longer buffer time for each clock cycle.

Each state transition in a Mealy FSM contains its output, which is a part of input for the next state.
This way, the output also becomes a memory.

Since the output depends on inputs, it needs a Karnaugh map, too.

== Sequential Logic in SystemVerilog
To listen for an event in parallel, use the following:
```sv
always @(sensitivity list) begin
  statement;
  statement;
end
```
The events are listed as the sensitivity list, for example, ```sv posedge clock```.

#warning-box[
  A signal can only be driving by one ```sv always``` block.
]

There is a special ```sv always``` block called ```sv always_ff```, for flip-flops.
To correctly synthesize the flip-flop circuit, use this ```sv always_ff``` instead of the generic one, not even the ```sv always_latch```, the reason being, they create latches implicitly when not all signal combinations are covered, the latch one has implied sensitivity list, too.

However, ```sv always_comb``` is okay because unwanted latches in a combinational logic is no disaster.

```sv
module flop(
  input logic clk,
  input logic [3:0] d,
  input logic [3:0] q,
)
  always_ff @(posedge clk)
    q <= d;
endmodule
```

The ```sv <=``` is an non-blocking get.
It does not wait for the clock.

#warning-box[
  Always use ```sv =``` in ```sv always_comb```.
  Always use ```sv <=``` in ```sv always_ff```.
]

The non-blocking assignment only take effect on leaving the block, since they are done in parallel.

= Digital Building Blocks

== Arithmetic Logic Units
A simple arithmetic logic unit can perform addition, subtraction, and, and or on two inputs.

== Shifters
#definition(title: [Logical Shifter])[
  Always inserts 0 to empty spaces.
]

For a signed number, given that the most significant bit does not change...
- a logical left-shift is to multiply by 2;
- a logical right-shift is to divide by 2, then floor.

#definition(title: [Arithmetic Shifter])[
  Insert the old most significant bit to empty spaces.
]

For a signed number, becase it preserves the sign of a two's complement number...
- an arithmetic left-shift is to multiply by 2;
- an arithmetic right-shift is to divide by 2, then floor.

#definition(title: [Rotator])[
  Instead of adding spaces, simply move bits on one end to the other end.
]

== Multipliers
To multiply a multiplier with a multiplicand,
+ multiply each bit of the multiplier with the whole multiplicand, obtaining partial products;
+ logically shift each partial product by their multiplier's place;
+ sum all the partial products.

#important-box[
  Due to the extensive use of adders, thus XOR gates in multipliers, it is power intensive and prone to glitches.
  Avoid when possible.
]

== Dividers
Recall how we do long division in decimal form.
From the highest possible digit, divide and take remainder.

For binary numbers, only 1 and then 0 are to be tried for each partial division.

```
// A / B = Q + R / B
R' = 0;
for i = N - 1 to 0
  R = {R' << 1, A_i} // shift partial R left, append next digit
  D = R - B
  if D < 0, Q_i = 0, R' = R // if B > D, Q_i should be 0, partial remainder remains
  else Q_i = 1, R' = D // else, Q_i should be 1, the difference is the new partial remainder
R = R' // use the last remainder
```

== Shift Registers
#definition(title: [Shift Register])[
  A register that, on each clock edge, shifts one bit in and one bit out.
]

There are shift registers with parallel load, meaning they can behave as either a shift register or a normal register, which loads in parallel.
They can convert serial input to parallel output, or parallel input to serial output.
This is useful when the speed of input and output are not matched.

```sv
module shiftreg #(parameter N=8) (
  input logic clk,
  input logic reset, load,
  input logic sin,
  input logic [N-1:0] d,
  output logic [N-1:0] q,
  output logic sout
);

  always_ff @(posedge clk, posedge reset)
  if (reset) q <= 0;
  else if (load) q <= d;
  else q <= {q[N-2:0], sin};

  assign sout = q[N-1];
end
```


== Fix-point Numbers
#definition(title: [Fix-point Number])[
  A binary number that has an implied binary point ('decimal point' for binary numbers) in the middle.
  Instead of going to $2^0$ at the right-most digit, it jumps from $2^1$ to $(2)^(-1)$ across the binary point.
]

Unlike integers, overflow in fix-point numbers are usually bad.
Hence we typically use the saturation arithmetic, where we take the largest value instead of overflowing.

=== Unsigned Fix-point Numbers
For unsigned fix-point numbers, every operation stays the same, just keep the implied binary point.

To specify number format, we use $nf(U, a, b)$ where #nf[U] is for "unsigned", $a$ is the integer bits, and $b$ is the fraction bits.

=== Signed Fix-point Numbers
To specify such number format, we use $nf(Q, a, b)$ where #nf[Q] is for "signed" (for some reason).

To negate a #nf[Q],
+ invert all bits;
+ add one to the least significant bit.

== Floating-point Numbers
#definition(title: [Floating-point Number])[
  A binary number that has a binary point after the most significant bit.
]

We write floating-point numbers using scientific notation,
$
  n = "M" times "B"^"E"
$
where $"M"$ is the mantissa, $"B"$ is the exponent and $"E"$ is the exponent.
Since we are using binary numbers, the base is 2.

According to the IEEE 754 floating-point standard, a 32-bit, single-precision floating-point number is represented by
#figure(
  grid(
    inset: .65em,
    columns: (auto, auto, 50%),
    stroke: (_, y) => if y == 0 { none } else { stroke-color },
    [1 bit], [8 bits], [23 bits],
    [sign], [biased exponent], [fraction/mantissa],
  ),
)
- Since the most significant bit of the mantissa is always 1, it is omitted.
- The bias for exponent is $127$, meaning the stored exponent is $"actual E" + 127$.

The bias is introduced because the standard wishes to represent exponent as a non-negative number.
Hence, half-minus-one of the number space is offset.

The standard has special cases:
$
      0 & = "X" quad & "all" 0 quad & "all" 0 \
     oo & = 0 quad   & "all" 1 quad & "all" 0 \
    -oo & = 1 quad   & "all" 1 quad & "all" 0 \
  "NaN" & = "X" quad & "all" 1 quad & "not all" 0.
$

The double precision floating-point number in the standard uses 11 exponent bits, 52 fraction bits and 1023 bias.

Floating-point numbers can handle overflow.
There is also the inverse of overflow -- underflow, where the number is too small to be represented.

== Memory
Think of memory as a table.
Each row is a set of data, and there is a address pointing to a row.
There would be $(2)^(N)$ rows (word) and $M$ columns (word size).

#definition(title: [Types of Memory])[
  - Dynamic random-access memory (DRAM)
  - Static random-access memory (SRAM)
  - Read-only memory (ROM)

  Data in dymanic memory are lost overtime or on reads, hence they need to be constantly rewritten, typically around $qty("10", "ms")$.
  Static memory sustains data, is faster, but costs more energy.

  The random access is for jumping to random words, instead of traversing through all words in between.
]

Each bit cell is crossed by two wires: a horiontal wordline and a vertical bitline.
Alternatively, there are two bitlines, for one is negated, for faster and more reliable reading.
Such array of bit cells make up a logic array.

To read a cell, the bitline is charged with half of $V_"dd"$.
The transistor at the cell will either drain or supply power to the bitline, creating a voltage different between the bitline and a comparer at the end of the bitline.

Transistors do ware out on writes.
A solid-state disk (SSD) typically has a standard called "Terabytes Written" (TBW), that explains the amount of data that can be written before the disk is considered unreliable.

=== DRAM
Data in DRAM is stored on capacitors.
The wordline controls a transistor, so the bitline can or cannot access the capacitor pass the transistor.

The capacitor leaks charge naturally, or discharges on access.
That is why idling or reading destroyes values, and why the bits should be constantly rewritten.
A larger capacitor would mediate the issue, but not prevent it.
For cost reason, it tends to be small -- it will just be the base of transistor built deeper into the sillicon to increase its capacitance.

=== SRAM
SRAM notably does not leak data.

For a cell, there is the bitline and the negated bitline accessing each other througha a transistor, with an inverter in each direction.

Reading accesses both the bitline and the negated bitline, taking the value of bitline.
Writing supplied both lines with corresponding data.
The transistors have higher driving power than the inverters, hence the data from the lines, through transistors, will overpower the inverters, thus being written.

The inverters will restore data after read -- recharging it after discharge.
Thus, it requires more space (around six times) and power.

=== ROM
The simpliest way is to build it like DRAM, but without the capacitors, and remove the transistor of a cell to achieve consistent high voltage.
The transistors drain voltage as usual, but those cells without them let the bitline keep its original voltage.

There are inverters at the end of the bitlines, if that makes manufacturing easier.

To create a programmable ROM (PROM), in case you do want to update its content...
- Make it electrically erasable (EEPROM) by adding a floating gate to the transistor controls.
  The floating gate is controlled not by normal wiring, but a floating wire that makes no contact with the gate.
  When a very high voltage, either positive or negative, is supplied to the floating wire, charges get added or removed from the floating gate.
  When the voltage is removed, the charges have no where to go but stays there, controling the transistor.
- Make it optically erasable (OEPROM) by installing transparent windows above the floating gates, so that ultraviolet light can add or remove charges on them.

There are more types of memory implementations not covered in this course.

#definition(title: [Look-up Table])[
  A look-up table (LUT) is a logic array connected to a decode table.
  The decoder enables a set of wordlines to retrieve a set of values from the bitlines.
]

== SV and Multiport Memory
#example[
  A $256 times 3$ RAM.
  ```sv
  module ram (
    input logic clk, we,
    input logic [7:0] a,
    input logic [2:0] wd,
    output logic [2:0] rd
  );

    logic [2:0] RAM[255:0]; // holds all 8-bit addresses

    assign rd = RAM[a]; // async reading

    always_ff @(posedge clk)
      if (we)
        RAM[a] <= wd;

  endmodule
  ```
  In SystemVerilog, we typically use synchronic assignment for writing.
  Reading can be synchronic or asynchronic.

  However, our FPGA board does not support synchronic reading.
]

For reading memory from files, there are ```sv $readmemh(filename, literal)``` and alike.
To make a ROM, never support writing.

== Multiport Memory
#definition(title: [Port])[
  A memory port is an address-data pair.
  The pair is either for reading or writing.
]

#example[
  A $32 times 32$ register file with two reading ports and one writing port.
  ```sv
  module regfile(
    input logic clk,
    input logic we3,
    input [4:0] ra1, ra2, wa3,
    input logic [31:0] wd3,
    output logic [31:0] rd1, rd2
  );

    logic [31:0] rf[31:0];

    always_ff @(posedge clk)
      if (we3) rf[wa3] <= wd3;

    assign rd1 = (ra1 === 5'b00000) ? 32'b0 : rf[ra1];
    assign rd2 = (ra2 === 5'b00000) ? 32'b0 : rf[ra2];

  endmodule
  ```
]

== PLA and FPGA Logic Array
#definition(title: [Programmable Logic Array])[
  A programmable logic array (PLA) consists of an array of AND gates and then an array of OR gates.
]

Since PLA is simply built, it can only perform sequential logic.
The AND array produces implicants, then the OR array produces their sum.

A PLA is limited by its literal terms (M), implicant terms (N) and sum terms (P).

#definition(title: [Field Programmable gate Array])[
  A field programmable gate array (FPGA) consists of
  - logical elements (LE);
    - LUT;
    - flip-flops;
    - multiplexers;
  - input/output elements (IOE);
  - programmable interconnections;
  - sometimes, multipliers and RAMs.
]

Each LE has an output and a number of inputs depending on the manufacturer.
Knowing the specifications can help us arrange the LEs, but CAD tools tend to do that for us.

= Microcomputer
#definition(title: [Computer Components])[
  / CPU: Central processing unit.
  / Microprocessor: CPU in one integrated circuit (IC) unit.
]

== Instruction Set Architecture
There are two major instruction ser architectures (ISA): complex instruction set computation (CISC) and reduced instruction set computation (RISC).
Pretty self-explanatory.

#definition[
  Micro-architecture is the hardware design of a ISA.
]

#definition[
  Architecture implementation is the actual hardware that facilitates a ISA.
]

== Programmable State Machine
If we make an FSM programmable so it can perform different functions, it becomes a programmable state machine.
#definition[
  A programmable state machine (PSM) is a SM that has additional input from memory to load to its state counter, so there are choices for the next state.
]

There would be an input select, which tells the SM whether it should load the next state from the counter or from the memory.
And there are the inputs from memory that will or will not be selected as the next state.
Those inputs are called "instruction words".

The output can be written to the instrction for the next round.

A simple CPU uses an ALU, then select its output to write to a register file, optionally, being displayed.
All kinds of input together select the ALU output, dictating what is written into the register.

The CPU can also read from or write to a memory, and let the memory help make ALU output selection.

