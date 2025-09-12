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
+ take reminder as digit;
+ take quotient as the next digit;
+ repeat until quotient is 0.

#example[Decimal to binary and hexadecimal][
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

#example[Hexadecimal-binary conversion][
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

#definition[Bit, byte and nibble][
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
      .zip(range(1, 7).map(p => {
        let pb = p * 10
        let pd = p * 3
        ($2^#pb = #calc.pow(2, pb)$, $10^#pd$)
      }))
      .flatten(),
  )
})

== Addition and Subtraction
Just add 'em.
For subtraction, convert it to addition of negative numbers.

#example[Adding unsigned or two's complement binary numbers][
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

#example[Adding sign/magnitude numbers][
  $
    (-6)_10 + 6_10 & = 0           \
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

#example[Adding two's complements][
  $
                   (-6)_10 + 6_10 & = 0     \
    #ladd(numeral: 2, 1010, 0110) & => 0000 \
                                  & = 0
  $
]

== Extension

=== Sign Extension for Two's Complement
To extend and keep value, left-pad the most significant digit.
#example[][
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

#definition[CMOS][
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

= SystemVerilog
A hardware description language actually has two parts: synthesis and simulation.
Synthesis is the structure of hardware, simulation is running logics.

== Modules
SystemVerilog (SV) has two types of modules:
- structural: describing components;
- behavioral: declaring procedures.

== Optimization
Say, logic ```sv a & ~b & c | a & ~b & ~c ``` can be optimized to ```sv a & ~b``` as ```sv (c | ~c)``` is always `1`.

