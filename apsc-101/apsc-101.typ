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
#import "@preview/unify:0.7.1": unit, num, qty, numrange, qtyrange

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

== Equity Diversity Inclusion (EDI)

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

== Business Letters
- Letter Structure
  - Address
  - Date month day, year
  - Receiver's Address (title after name)
  - Salutation with colon: not common (ms. mr. dr. prof.)
  - Introduction and purpose
  - Details
  - Restate purpose and request action
  - Sincerely,
  - Signature
  - Name

- Extra elements
  - Letterhead: only on first page, address in letterhead not body
  - Long title recipient as second line
  - Bolded reference line before salutation re: this letter is important
  - Enclosures below signature
  - cc section (stating the other recipients)
  - cc. bob and rob

== Recommendation Report
+ Problem statement
+ Engagement and implementation strategies
+ Description of possible solutions
+ Final selection and justification



= Risk Management

$"Risk" = "Severity" times "Likelihood"$

$"Risk" eq.not "Hazard"$

/ Risk: _Possibility_ of harm, consequences, or damage.
/ Hazard: _Capacity_ of equipment, material, or processes to cause
harm.

- The risk management process should be repeated from the beginning whenever a risk is mitigated

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
      [Safety], [], [N/A], [],
      [Technical], ..([],) * 3,
      [Project \ Management], ..([],) * 3,
      [Operational], ..([],) * 3,
    ),
  ),
)

A risk classification table is a tool used to identify and classify risks based on their severity and likelihood.

#{
  show figure: block.with(breakable: false)
  figure(
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
}

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
  ),
)


= Engineering Drawings

== Orthographic
A drawing that depicts an object’s axis, with no perspective \

/ Center line of hole: dash dot lines, + symbol in center
/ Hidden features: dashed lines
=== First Angle Projection
- Front, left side, bottom
=== Third Angle Projection
- Front, right side, top

#image("assets/firstthirdangleproj.png", width: 70%, height: 85pt, fit: "contain")
note: any orientation of the symbols are fine

== Title Block and Border:
- Border has measurements
- Title block has: name, author, company, revision, scale, units, tolerances, materials, drawing number, third angle symbol

== Dimensions:
- best to be outside of part
- extension lines: connecting dimension line to part
- *NO REDUNDANT DIMENSIONS*
- dimension *VISIBLE FEATURES* when possible
- If two dimensions can be solved from the other, choose the most important and the other
- Extension lines can cross, dimension lines cannot




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
== Sustainability Framework
#image("assets/susFramework.png", width: 60%, height: 165pt, fit: "contain")

== Resiliency
/ Resiliency: capacity to *adapt* to changing conditions and to *maintain* or regain functionality and vitality in the face of stress or *disturbance*
- Complex systems are more resilient than simple or complicated systems.
- Can be analyzed using a CLD.

- Design principles of resilient systems:
  - function across different scales
  - build redundancies
  - use locally available resources
  - as possible, simple, passive and flexible; e.g. not requiring constant monitoring or input
  - be ethical, supporting community and social equity


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

== Streamlined Life Cycle Assessment (SLCA)
- for each criterion and for each life cycle stage, evaluate performance of product/process on a qualitative scale. \
  e.g. "very poor" to "very good" or "significant negative impact" to "significant benefit"
  #image("assets/slcaResult.png", width: 75%, height: 165pt, fit: "contain")

- results usually tabulated in SLCA Matrix
  #image("assets/slcaMatrix.png", width: 80%, height: 100pt, fit: "contain")

- values in matrix then summed to determined environmentally responible product rating ($upright("R")_upright("ERP")$). \
  equivalent to score in WDM if all weights were 1

=== Usage of SLCA
+ use $upright("R")_"ERP"$ to benchmark performance against other products
+ use SLCA ratings to determine areas of greatest negative impact

=== Benefits of SLCA
- SLCA faster, easier, less expensive to complete
  - SLCA takes days, LCA can take months
- SLCA qualitative (easier to use with criteria which are more difficult to quantify), but also makes results *less precise*
- SLCA suitable for any stage of design process (especially early where potential influence on design decisions is greatest)
  - LCA suitable for existing products / very late in design process (where precise assessment of impact is required)

== Sunk Cost
/ Sunk cost: a cost that has already been incurred and cannot be recovered.

Sunk cost usually include equipments already bought, exploration and consultation already done: they would not be reversed to money.

== Duty to Consult
#link("https://www.rcaanc-cirnac.gc.ca/eng/1331832510888/1609421255810")[The Government of Canada has a duty to consult and, where appropriate, accommodate Indigenous groups when it considers conduct that might adversely impact potential or established Aboriginal or treaty rights.]





= Design Specification

== Design Parameter
The engineering factors of a product or service, e.g. "battery capacity".

== Attribute
The apparent properties affecting user experience, e.g. "battery life".

== Requirements
"Yes" or "no" questions, used mostly in screening.
Typically expressed in forms of thresholds, e.g. "germ level lower than 300", "potable".

== Satisfaction
Curves are *quantifiable and defensible* models of the relationship between attributes and stakeholder satisfaction.

"Extent" questions, used mostly in ranking and scoring.
Typically shown as a curve, with satisfaction changing with attribute value, e.g. "3-8 hours of battery life, the higher the better".
Sometimes, the higher the value, the worse the satisfaction.

The satisfaction line is curved because consumers perception of improvements at different level vary.
For example, an 1 to 2 hours battery life improvement will likely be strongly felt by users, but a 7 to 8 hours battery life extension would not have such positive reception, as the users are already pretty satisfied with 7 hours.

Building satisfaction curve involves market analysis, consumer/customer interview, experiments and more.

= Mining

== Mine Development
#image("assets/minedevcycle.png", width: 65%, height: 21%, fit: "contain")
#image("assets/decisionmakingcycle.png", width: 65%, height: 21%, fit: "contain")

== Definitions
/ Mineral: a substance that occurs naturally in the earth; the material we are trying to obtain through Mining
/ Ore: material containing a mix of valuable minerals and economically valueless materials (_*gangue*_) to be separated in proessing
/ Waste rock: material that does not contain sufficient minerals to viably process
/ Tailings: material rejected after minerals have been extracted in processing; usually a mix of fine particles and water
/ Concentrate: contains valuable mineral and a product from which most waste has been removed

== Mineral Deposits
2D approximation
#image("assets/mineralDeposits.png", width: 74%, height: 17%, fit: "contain")

== Block models
[05112] What does the APSC 101 Block Model most directly incorporate into its calculations and outputs?
- Estimating economic values of mineral and waste materials for different mine designs


== Mining Methods
=== Open pit mine
- diameter (or radius) of pit roughly proportional to depth
- area roughly proportional to depth#super[2]
- volume roughly proportional to depth#super[3]

Pros:
- good when deposit near surface
- faster and can use bigger equipment
- cost effective for lower grade Deposits
Cons:
- must remove and handle large amoutns of waste
- may not be feasible in environmentally or culturally sensitive strategies
- significant changes to landform


=== Underground mining
Pros:
- good for deep Deposits
- way less waste rock removed
- lower environmental footprint
- less space on surface required
Cons:
- additional safety considerations required (stability, ventilation, radiation)
- more expensive to remove material
- slower due to less room and smaller equipment

== treatment for waste water and tailings
- Tailings dams
- dry stack tailings (remove most of the water from the tailings before storing)
  - take up less space than dam
  - reduces risk of contamination / dam breach



= Module 7 Rainwater Harvesting System

== Overview

=== Objective
- To provide enough clean water to a 2 person house
- Full rwh system:
#image("assets/fullrwh.png", width: 65%, height: 21%, fit: "contain")
=== Prototype Classification
- Consumption model: focused virtual
- Early catchment model: focused virtual
- Cf lab: focused physical
- System model: comprehensive virtual

=== RWH Collection Side
- Catchment collects
- Collection tank near house leads to pump
- Filtration, chlorination
- Pump provides pressure to elevated tank, which can then distribute water
#image("assets/rwhcollection.png", width: 70%, height: 32%, fit: "contain")

=== RWH Storage Side
- Storage tank holds
- filter (if not already used), UV treatment
- Minimum on-demand flowrate and sustained average flow rate must be met
#image("assets/rwhstorage.png", width: 70%, height: 32%, fit: "contain")


== FLOW PHYSICS!!

=== basics
Hydrostatic Pressure:
$ p = rho g h $
Flow rate and velocity
$ Q_"out" = A_"nozzle" v_"out" $
- Q: volume flow rate

=== Flowrate / velocity / pressure out of a tank
$ Q_"out" = A_"nozzle" sqrt((2 p)/rho) $
$ v_"out" = sqrt((2 p)/rho) $
Rearrange to get: (because only a pressure *difference* will encourage a flow)
$ p_1 - p_2 = (rho (v_"out")^2) / 2 $
where $p_1$ is pressure inside water inside tank, $p_2$ is pressure outside (usually equal to atmospheric pressure, but we set as 0 (as kind of a datum))
- Flow/Velocity from *high pressure* (height) to *low pressure* (height)



== System Pressure
=== Collection Side
- you want a pump to drive water from catchment (house roof) up to storage tank

$
  p_"pump" (v) = rho g h_"storage" + underbrace(f L / D (rho v^2) / 2, "friction") + underbrace(K (rho v^2) / 2, "restrictions") + underbrace(C_f v, "filter")
$
- equation solves for the intersection point of the following #text(red.darken(15%))[pump] and #text(blue.darken(10%))[system] curve
- $C_f$ filters' friction coefficient.
  Changed by filters on the _rising_ edge.
- $L$ is the pipe length, and it _does not necessarily_ change if $x, y, z$ of the tanks are changed.
\
- As pump pressure increases, flow rate decreases
- The pump operates at the intersection of these two curves for maximum flow rate
#image("assets/pressureFlowrateIntersection.png", width: 70%, height: 22%, fit: "contain")
- Must overcome storage height and all resistance and restrictions for water to flow towards the tank
\
To improve performance:
- Move system curve:
  - Reduce elevation (moves system curve right/down)
  - Reduce pressure losses (by bringing storage tank closer to pump, or by removing filters from the line)
- Move pump curve:
  - Use a better pump


=== Storage (on demand) Side
- Line from storage to house
- No pump, driving pressure is elevation from storage tank

$
  rho g h_"storage" = underbrace(f L / D (rho v^2) / 2, "friction") + underbrace(K (rho v^2) / 2, "restrictions") + underbrace(C_f v, "filter")
$
- The tank provide a constant flow rate dependent on height
- Must match the same quantities as the pump (save the possibility of filters)

Consider the worst case scenario, when water in tank is nearly empty:
#image("assets/rwhdown1.png", width: 70%, height: 14%, fit: "contain")

And assume constant water level:
*Storage Tank and System Curve*
#image("assets/rwhdown2.png", width: 70%, height: 21%, fit: "contain")

- #text(blue.darken(40%))[on demand supply system curve] starts at origin, as we defined height of house to be 0
- flow rate is intersection
- to improve:
  - increase elevation of storage tank (moves storage pressure curve up)
  - reduce losses in supply system curve (move storage tank closer, remove filters)

- Storage tank height must overcome all restrictions
- *So the tank must be high enough to meet on-demand flow rate, but low enough to allow the pump to match its pressure!*

== Maintenance
- Filters \
  Life of a filter is determined by the filter size immediately larger than itself.
  E.g. life of a $qty("1", "micro m")$ filter is affected by the presence of a $qty("5", "micro m")$ filter, but not by the $qty("200", "micro m")$ if the prior is already present.

- Power sources \
  Can be either diesel fuel engine or solar panels and battery.
  Solar has outstandingly low risk exposure, but might be less reliable.

== Water Treatment

*Order*:
+ Chemical before storage
+ Filters (before or after storage)
+ UV (post filter)

=== Filters
- Can be on line to or from storage
- Finer filter --> higher flow resistance, faster fouling
- Put large filters first
- Filter life depends on previous filters

=== Non chemical treatment (UV)
- Pros
  - No residue
  - Kills pathogens
- Cons
  - Need pre-pure water (dirt blocks UV)
  - Uses electric power

=== Chemical Treatment
*Chlorine*
- Pros
  - Kills pathogens
  - Well developed and inexpensive
- Cons
  - Needs time to chlorinate
  - Hazardous

*Ozone*
- Pros
  - Kills pathogens
  - On-site production (from air)
- Cons
  - Cost
  - Needs electric power
  - Contact time


== Power
=== Solar System
- Operates pump and ozone during day
- Since this is only supply side, it can turn off and leave the battery to run the UV at night
- Pros:
  - No emissions
  - Silent
  - No fuel transportation

=== Diesel System
- Operates pump and ozone, while charging UV battery for 24/7 use
- Chemical E converted to mechanical w/ given efficiency
- Risk transporting fuel

=== Equations

$ E_"water" = m g h $
- $E$ is power required to raise water to storage tank of height $h$

Using the following equations:
$ p_"storage" = rho g h $
$ "mass" = rho V_"collected" $

To get:
$ E_"water" = p_"pump" V_"catch" $
- Energy *output* needed to raise catchment water to storage tank w/ pump

- Recall that pump pressure must match the height differential and systemic losses.
- $E_"water"$ is an output value and efficiency must be accounted for
$ E_"input" * "Efficiency" = E_"water (output)" $
$ "Pump power" = "flowrate" * "pressure" $

- *Finding operational flow of system*
  - Where the pressure/flow rate curves intersect
  + Find total time $= V / Q_"intersect"$ units: $"volume"/"volume per time" = "time"$
  + Convert $p_"pump"$ into $E_"water"$
  + Convert $E_"water"$ into input (divide by efficiency)
  + Convert $E$ to power by dividing by time


= Risk Modelling
#image("assets/rwhrisktabl2.png", width: 77%, height: 30%, fit: "contain")
#image("assets/rwhriskcurve1.png", width: 77%, height: 30%, fit: "contain")

= Content from APSC100 (TODO PUT MORE)
== Stakeholders / Salience
/ Power: stakeholder's ability to influence a project
/ Legitimacy: stakeholder's *moral* or *legal* right to have a say in a project
/ Urgency: how critical or time sensitive a stakeholder perceives their needs in a project to be

Primary stakeholders: has all 3 \
Secondary stakeholders: has 2 \
Tertiary: has 1 \
Non stakeholder: 0 \
\
Note: stakeholder salience can change over time

=== Needs
/ Needs: capture teh wants and wishes of thes takeholders and the things that will increase/decrease stakeholder satisfaction
/ Expressed needs: needs stakeholders are aware of and freely share (usually through consultations)
/ Latent needs: needs stakeholders might not be aware of
/ Threshold needs: needs stakeholders expect but dont mentioned

== Target Design Specifications
/ Requirements: collection of min. thresholds our design must achieve to satisfy stakeholders
/ Evaluation criteria: attributes of importance to stakeholders that determines satisfaction beyond min requirements



== Validation and Verification
/ Validation: ensuring correct design specfications
  - are we solving the correct problem?
/ Verification: check solution meets requirements and maximizes overall stakeholder satisfaction
  - did we solve the problem correctly?


= Other things mentioned
#image("assets/realFilters.png", width: 60%, height: 21%, fit: "contain")

= Some mistakes I (nathan) made
- If two tanks have different diameter/radius/area, but volume same, when subject to constant rainfall, the water depth in the tanks *increase at the same _rate_*
