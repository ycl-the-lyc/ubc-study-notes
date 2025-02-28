#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    APSC 101 Study Notes \
    #underline[Intro to Engineering II]
  ],
  author: "Nathan Lui",
)

#set terms(separator: [: ])

#import "@preview/fletcher:0.5.4" as fletcher: diagram, node, edge
#import fletcher.shapes: diamond

#import "@preview/physica:0.9.4": *
#import "@preview/metro:0.3.0": *
#import units: *
#import prefixes: *

= Professional Skills / Working in a team

== Tuckerman's Stage of Development
/ Tuckerman's Stages of Development: Forming, Storming, Norming, Performing

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

== Equity Diversion Inclusion (EDI)

/ Equity: Everyone has same opportunities and outcomes
/ Diversity: recognizing and valuing different background, identity, experiences, and different points of view

== Biases
/ Implicit biases: subconcious stereotypes about groups, learned through what we see 
/ Microaggressions: small, subtle, or indirect discriminatory actions or statements 
/ Stereotype threat: when people feel concerned about conforming to a stereotype for a group they belong to 
\
/ Allyship: acting to support those facing discrimination in or underrepresented groups
- Reactive allyship: in response to an incident of bias (e.g. team member steps in to defend another)
- Proactive allyship: when someone actively engages to make marginalised individuals feel more included and respected


== 5 Keys to an effective team
*
- Dependability
- Structure & clarity
- Meaning
- Impact
*
- *Psychological safety  * _[most important]_

Does not depend on skills of team members.



= Risk Management

$"Risk" = "Severity" times "Likelihood"$

$"Risk" eq.not "Hazard"$

/ Risk: _Possibility_ of harm, consequences, or damage.
/ Hazard: _Capacity_ of equipment, material, or processes to cause
harm.

== Risk Sources

/ Preventable: Controllable. \
  General time management issues included, such as not anticipating delays.
/ Strategic: Taken for possibility of greater reward. \
  For example, rushing through decision making stages for earlier project completion, this is a strategic risk, not preventable.
/ External: Outside of control.

=== Risk vs Hazard
/ Risk: #underline[possibility] of harm, consequences, or damage
/ Hazard: #underline[capacity] of equipment, material, or processes to cause harm

=== Control Hierarchy for Safety Hazards

#image("assets/safetyControlHierarchy.png", width: 103%, height: 220pt, fit: "contain")


= Drawings (tbd)

= Feedback

== 7 Cs (recap)

*Clear* - easy to follow, easy to understand \
*Correct* - Factually accurate, prepared according to professional standard \ 
*Concise* - Brief, efficient \
*Concrete* - Detailed, vivid, and specific. Main point is clearly evident \
*Complete* - includes info relevant to the audience, conveys what audience should do \ 
*Courteous* - polite and respectful, geuine and sincere \ 
*Considerate* - empathetic and mindful, prepared with receiver in mind \ 

== 3x3 Feedback Model
#image("assets/3x3feedback.png", width: 103%, height: 220pt, fit: "contain")


= Systems Thinking (covered in APSC100, will be tested again in 101)


= Life Cycle Thinking

/ Life cycle thinking: accounting for all impacts of a product or process across all stages of its life cycle

== Life Cycle Stages
#image("assets/lifeCycleStages.png", width: 100%, height: 220pt, fit: "contain")

At product end of life, the following options are ranked most desirable to least desirable
+ *Reuse: * reuse the product in its current state, upcycle unwanted products to products of higher quality or value, or repurpose the product to a new use 
+ *Recycle: * process the raw materials in the product and produce something new
+ *Recovery:* extracting as much energy or material from product as possible before disposing of it 

Another is *reduce*, which is to change behaviours as a society to reduce what we consume and use.


== Life Cycle Assessment (LCA)

- systematic evaluation of the impacts of energy and material inputs and outputs for a product/process across all life cycle stages

+ *Goal Definition and Scope*
  - System boundary: a description of what elements are included or not included in an LCA
  - Functional units: a reference measure of performance to use as a baseline in comparing options
    #image("assets/funcUnitImg.png", width: 85%, height: 150pt, fit: "contain")

+ *Inventory Analysis*

+ *Impact Assessment*
  - impacts of each material and energy flow are quantified

+ *Interpretation*
  - systematically review work of each stage as new information comes in

=== Challenges with LCA
  - Detailed knowledge of material and energy flows required
  - Impacts must be known and quantified
  - Focuses on environmental impacts
  - *_difficult to use early in design process_*

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

#block(
  width: 100%,
  breakable: false,
  figure(
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
        rotate(-90deg, origin: right + top, reflow: true, smallcaps[Risk Category #h(.2em)]),
      ),
      [Safety], [], [N/A],[],
      [Technical], ..([],) * 3,
      [Project \ Management], ..([],) * 3,
      [Operational], ..([],) * 3,
    ),
  ),
)

A risk classification table is a tool used to identify and classify risks based on their severity and likelihood.

#figure(
  caption: [Risk Matrix],
  table(
    columns: (2em,) + (4em,) * 6,
    stroke: (x, y) => if (x < 2 and y < 2) { none } else { black + 0.5pt },
    fill: (x, y) => if (x < 2 or y < 2) { none } else {
      red.transparentize(10% * (6 - x + y))
    },
    table.header(
      table.cell(colspan: 2, rowspan: 2, none),
      table.cell(colspan: 5)[Severity],
      [1],
      [2],
      [3],
      [4],
      [5],
    ),
    table.cell(
      rowspan: 5,
      rotate(-90deg, origin: right + top, reflow: true, smallcaps[Likelihood #h(1.2em)]),
    ),
    [5], ..([],) * 5,
    [4], ..([],) * 5,
    [3], ..([],) * 5,
    [2], ..([],) * 5,
    [1], ..([],) * 5,
  ),
)

#figure(
  caption: [Risk Register],
  table(
    columns: 6,
    table.header(
      [ID],
      [Description],
      [Severity],
      [Likeli#{sym.wj}hood], // for some reason it wants to break here
      [Rating],
      [Mitigation],
    ),
    [1], ..([],) * 5,
    [2], ..([],) * 5,
    [3], ..([],) * 5,
  )
)

== Streamlined Life Cycle Assessment (SLCA)
  - for each criterion and for each life cycle stage, evaluate performance of product/process on a qualitative scale. \
    e.g. "very poor" to "very good" or "significant negative impact" to "significant benefit"
      #image("assets/slcaResult.png", width: 75%, height: 165pt, fit: "contain")

  - results usually tabulated in SLCA Matrix
    #image("assets/slcaMatrix.png", width: 80%, height: 100pt, fit: "contain")

  - values in matrix then summed to determined environmentally responible product rating ($upright("R")_upright("ERP")$). \
    equivalent to score in WDM if all weights were 1

=== Usage of SLCA
  + use $upright("R")_upright("ERP")$ to benchmark performance against other products
  + use SLCA ratings to determine areas of greatest negative impact 

=== Benefits of SLCA
  - SLCA faster, easier, less expensive to complete 
    - SLCA takes days, LCA can take months
  - SLCA qualitative (easier to use with criteria which are more difficult to quantify), but also makes results *less precise*
  - SLCA suitable for any stage of design process (especially early where potential influence on design decisions is greatest)
    - LCA suitable for existing products / very late in design process (where precise assessment of impact is required)

= Sunk Cost
/ Sunk cost: a cost that has already been incurred and cannot be recovered.

Sunk cost usually include equipments already bought, exploration and consultation already done: they would not be reversed to money.

= Duty to Consult
#link("https://www.rcaanc-cirnac.gc.ca/eng/1331832510888/1609421255810")[The Government of Canada has a duty to consult and, where appropriate, accommodate Indigenous groups when it considers conduct that might adversely impact potential or established Aboriginal or treaty rights.]
