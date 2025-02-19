#import "@preview/ilm:1.4.0": *
#show: ilm.with(
  title: [
    APSC101 Study Notes \
    #underline[]
  ],
  author: "Nathan Lui",
)


#set terms(separator: [: ])

#import "@preview/physica:0.9.4": *
#import "@preview/metro:0.3.0": *
#import units: *
#import prefixes: *

= Professional Skills / Working in a team
== Tuckerman's Stage of Development
/ 4 Stages: Forming, Storming, Norming, Performing

/* insert image */
#image("assets/tuckermanTeamDev.png", width: 60%, height: 200pt, fit: "contain")

#v(-5pt)

=== Important Notes
- relationships within members get BETTER over time 
  -  this includes storming, as team members are more willing to speak their minds
- conflict occurs at all stages

=== Good vs Bad Norming
- Good norming is healthy
- Bad norming --> team disfunction
    - e.g. one team member routinely misses meetings and team does nothing

== Conflict Management

/* insert image of conflict management styles */

#image("assets/conflictManagementStyles.png", width: 60%, height: 200pt, fit: "contain")

-  
  - *Avoiding* good when tensions high
  - *Accommodating* good when the issue matters more to the other party
  - *Competing* good when issue is self-critical and immediate
  - *Compromising* good if time is short and relationships/problem must be balanced
  - *Collaborating* when you have time to work towards finding the ideal solution for everyone
- _Good teams change their style as situation demands_

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

== Definition

$"Risk" = "Severity" times "Likelihood"$


=== Risk Sources

/ Preventable: controllable 
/ Strategic: taken for possibility of greater reward
/ External: outside of control

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
  - #image("assets/funcUnitImg.png", width: 85%, height: 150pt, fit: "contain")

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
  - for each criterion and for each life cycle stage, evaluate performance of product/process on a qualitative scale
    - e.g. "very poor" to "very good" or "significant negative impact" to "significant benefit"
    - #image("assets/slcaResult.png", width: 75%, height: 165pt, fit: "contain")

  - results usually tabulated in SLCA Matrix
    - #image("assets/slcaMatrix.png", width: 80%, height: 100pt, fit: "contain")

  - values in matrix then summed to determined environmentally responible product rating ($upright("R")_upright("ERP")$)
    - equivalent to score in WDM if all weights were 1

=== Usage of SLCA
  + use $upright("R")_upright("ERP")$ to benchmark performance against other products
  + use SLCA ratings to determine areas of greatest negative impact 

=== Benefits of SLCA
  - SLCA faster, easier, less expensive to complete 
    - SLCA takes days, LCA can take months
  - SLCA qualitative (easier to use with criteria which are more difficult to quantify), but also makes results *less precise*
  - SLCA suitable for any stage of design process (especially early where potential influence on design decisions is greatest)
    - LCA suitable for existing products / very late in design process (where precise assessment of impact is required)