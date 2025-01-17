#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    APSC 101 Study Notes \
    #underline[Intro to Engineering II]
  ],
  author: "",
)

#set terms(separator: [: ])

#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

#import "@preview/physica:0.9.4": *
#import "@preview/metro:0.3.0": *
#import units: *
#import prefixes: *

= Professional Skills

== Tuckerman's Stage of Development
/ 4 Stages: Forming, Storming, Norming, Performing

/* insert image */
#image("assets/tuckermanTeamDev.png", width: 60%, height: 200pt, fit: "contain")

#v(-5pt)

=== Important Notes
- relationships within members get BETTER over time
  - this includes storming, as team members are more willing to speak their minds
- conflict occurs at all stages

=== Good vs Bad Norming
- Good norming is healthy
- Bad norming --> team dysfunction
  - e.g. one team member routinely misses meetings and team does nothing

== Conflict Management

/* insert image of conflict management styles */

#image("assets/conflictManagementStyles.png", width: 60%, height: 200pt, fit: "contain")

/ Avoiding: Good when tensions high.
/ Accommodating: Good when the issue matters more to the other party.
/ Competing: Good when issue is self-critical and immediate.
/ Compromising: Good if time is short and relationships/problem must be balanced.
/ Collaborating: When you have time to work towards finding the ideal solution for everyone.

_Good teams change their style as situation demands._


= Risk Management

$"Risk" = "Severity" times "Likelihood"$

== Risk Sources

/ Preventable: Controllable. \
  General time management issues included, such as not anticipating delays.
/ Strategic: Taken for possibility of greater reward. \
  For example, rushing through decision making stages for earlier project completion, this is a strategic risk, not preventable.
/ External: Outside of control.

== Risk Tools

//TODO risk management process
#let rmp = (
  identify: (0, 0),
  analize: (0, 1),
  cc-acceptable: (0, 2),
  cc-reducible: (1, 2),
  reduce: (1, 1),
  monitor: (0, 3),
  discountinue: (1, 3),
)
#figure(
  caption: [Risk Management Process],
  diagram(
    node-stroke: black + 1pt,
    node-inset: 10pt,
    spacing: (5em,) * 2,
    {
      node(rmp.identify, [Identify risks])
      node(rmp.analize, [Conduct risk analysis])
      node(rmp.cc-acceptable, [Is the risk \ acceptable?], shape: diamond)
      node(rmp.cc-reducible, [Can risk be \ reduced?], shape: diamond)
      node(rmp.reduce, [Reduce the risk])
      node(rmp.monitor, [Monitor and manage risks])
      node(rmp.discountinue, [Discontinue])

      edge(rmp.identify, rmp.analize, "-|>")
      edge(rmp.analize, rmp.cc-acceptable, "-|>")
      edge(rmp.cc-acceptable, rmp.cc-reducible, [no], "-|>")
      edge(rmp.cc-acceptable, rmp.monitor, [yes], "-|>")
      edge(rmp.cc-reducible, rmp.reduce, [yes], "-|>")
      edge(rmp.cc-reducible, rmp.discountinue, [no], "-|>")
      edge(rmp.reduce, rmp.identify, "-|>", corner: left)
    },
  ),
)
#figure(
  caption: [Risk Classification Table],
  table(
    columns: 5,
    stroke: (x, y) => if (x < 2 and y < 2) { none } else { black + 0.5pt },
    table.header(
      table.cell(colspan: 2, rowspan: 2, none),
      table.cell(colspan: 3)[Risk Source],
      [Preventable],
      [Strategic],
      [External],
    ),
    table.cell(
      rowspan: 4,
      context {
        let c = rotate(-90deg, origin: right + bottom, smallcaps[Risk Category])
        let ds = measure(c)
        box(
          width: ds.width,
          height: ds.height,
          // clip: true,
          c
        )
      },
    ),
    [Safety], ..([],) * 2, [none],
    [Technical], ..([],) * 3,
    [Project \ Management], ..([],) * 3,
    [Operational], ..([],) * 3,
  ),
)

A risk classification table is a tool used to identify and classify risks based on their severity and likelihood.

#figure(
  caption: [Risk Matrix],
  [],
)

//TODO risk register (table)
