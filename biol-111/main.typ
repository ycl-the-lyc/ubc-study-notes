#import "../lib.typ": *
#show: setup.with(
  title: [BIOL 111 \ _Introduction to Modern Biology_],
  author: "Yecheng Liang",
)

/// Make a allele symbol.
///
/// - base (str, content): Symbol of the gene.
/// - phenotypes (arguments): Symbols of the phenotypes.
/// -> content
#let allele(base, ..phenotypes) = $#base^#phenotypes.pos().join()$

/// Make a Punnett Square as a table.
///
/// - als (array): Alleles for the rows.
/// - comb (function): Combinator of two alleles, must take alleles `(row, col)` and return a `table.cell` equivalent.
/// - alt (auto, array): Alleles for the columns, leave as `auto` for `als`
/// - targs (arguments): Arguments for the `table` the function produces, excluding `columns` and `rows`
/// -> content
#let punnett(als, comb, alt: auto, targs: arguments()) = {
  alt = if alt == auto { als } else { alt }
  let targs = (
    arguments(
      align: center + horizon,
      stroke: (x, y) => if x == 0 and y == 0 { none } else { black + 0.5pt },
    )
      + targs
  )
  table(
    columns: alt.len() + 1,
    rows: als.len() + 1,
    ..targs,
    none,
    ..alt,
    ..als.zip(cartprod(als, alt).map(((a, b)) => comb(a, b)).chunks(alt.len())).flatten()
  )
}

= Genetics

== Genetic Materials

/ Deoxyribonucleic Acid (DNA): A molecule that contains information to build an organism.

/ Nucleotide: Smaller molecules that compose DNA.
  The pairing is always:
  - Thymine (T) and Adenine (A);
  - Guanine (G) and Cytosine (C).

/ Genome: The complete set of DNA.

/ Gene: A section of DNA that codes a specific protine.
  / Allele: A variation of a gene.

/ Codon: A Three-nucleotide block that codes a specific amino acid.

/ Phenotype: An expression of a physical property of an individual.

/ Chromosome: A pack of DNAs.
  / Chromatid: A DNA in the chromosome.
  / Centromere: A knot on the chromosome that joins and protects it.
  / Arm: An extension from the centromere.
  / Telomere: A section of DNA at ends of arms to protect them.
  / Locus: A fixed position where a gene will be on the chromosome.

/ Ploidy: The number of complete sets of chromosomes in a cell.
  Ha-, Di-, Tri-, and Poly- are prefixes for one, two, three, and many sets.
  / Haploid number: The number of types of chromosomes in a cell.

== Cell Cycle
/ Eukaryote: An organism whose cell has a nucleus.

/ Procaryote: An organism whose cell has no nucleus.

/ Somatic/vegetal cell: A "body" cell.
  / Autosomal: Of "body", not sex.

/ Gamete: A "sex" cell.

/ Homologous chromosomes: A pair of matching (not identical) chromosome in a diploid organism.
  They have the same
  - length,
  - centromere location,
  - locus.
  They might have different alleles.

/ Interphase: A time when cells get ready to divide.

/ Mitosis: A type of cell division that results in two cells with the same ploidy.

/ Meiosis: A type of cell division that results in four cells with half the ploidy.

/ Genotype: A set of gene carried in a cell.
  There can be multiple genotypes in one cell.

/ Homozygous: A cell having identical alleles across homologous chromosomes.

/ Heterozygous: A cell having different alleles across homologous chromosomes.

+ $G_1$, gap one, cell growth;
  At the end, cell checks if condition is favorable for cell division.

+ $S$, DNA synthesis / chromosome replication;
  DNA unzips, then bind with complementary nucleotides to form two identical DNAs.

+ $G_2$, gap two, cell growth;
  At the end, cell checks for condition and gene damage.

+ $M$, nuclear division, mitosis or meiosis, then cytokinesis (duplicating cytoplasm, which is stuff other than the nucleus).

After cytokinesis, animal cells pinch-off, plant cells form a wall in between.
Then, two new cells are formed.

=== Mitosis
+ Prophase & prometaphase, DNAs condense into chromosomes, spindle apparatus starts to form;

+ Metaphase, nuclear envelope breaks down, spindles line up the chromosomes;

+ Anaphase, chromosomes pulled apart horizontally at centromeres by the spindles;

+ Telophase, nuclear envelopes reform.

Each chromosome is duplicated, then distributed into two sister cells.
Hence, ploidy is unchaned.

=== Meiosis
+ Meiosis Ⅰ
  + Prophase, DNAs condense into chromosomes, spindle apparatus starts to form;

    Homologous chromosomes combine at centromeres, forming tetrads.
    Cross-over can happen when combining:
    + A protein breaks a pair of non-sister chromatids at one or two same location;
    + DNA repair proteins re-attaches the chromatid pieces back;
    + sometimes, they get re-attached to the "wrong side".

  + Metaphase, nuclear envelope breaks down, spindles line up _homologous_ chromosomes;
    Independent assortment can happen: the tetrads can flip.

  + Anaphase, tetrads pulled apart horizontally at centromeres by the spindles, going back to X-chromosomes;

  + Telophase, nuclear envelopes reform.

+ Meiosis Ⅱ

  Basically mitosis.

Each chromosome is duplicated, combined with its duplicated homologous chromosome, then distributed into four cells.
Hence, ploidy is halved.

From the meiosis process, we can see that in a diploid cell, the number of possible genotypes is
$
  2^n
$
where $n$ is the number of alleles that can independently swap, since there are two possible alignments for each homologous chromosome pair.
Homozygpous alleles does not affect this number.

Cross-over and locus of the gene determines if the alleles can be swapped independently.
In other words, if the cross-over separates genes of the genotype (on a chromosome).

== Genotype and Phenotype
This section assumes diploid organisms.

/ Dominant allele: An allele that would express a phenotype with a positive number of it present.

/ Recessive allele: An allele that would not express a phenotype unless all of the gene is that allele.

The relationship can be affected by other genes.

#example[
  #let (FB, FW) = ("B", "W").map(allele.with("F"))
  Let $FB := "black fur", FW := "white fur"$.
  If we say that $FB$ is dominant and $FW$ is recessive (some times distinguished with capitalization), then
  $
    FB FB = FB FW = & "black fur" \
            FW FW = & "white fur".
  $
]

/ Incomplete dominance: The two original phenotypes combine to produce a third, in-between phenotype.

/ Co-dominance: The two phenotypes interleave, but in their original way.

#definition(title: [Punnett Square])[
  Basically, Cartesian product of two identical sets.
]

#example[
  Use the fruit fly eye color example.

  #let red = red.darken(20%).transparentize(30%)
  #let (XR, Xr) = ("R", "r").map(allele.with("X"))
  #let Y = allele("Y")
  #let a2c(a) = ((XR, red), (Xr, white)).find(((b, _)) => a == b).at(1)

  $
    XR := & "red eye" \
    Xr := & "white eye" \
    XR >> & Xr.
  $
  #figure(
    caption: $#XR#Xr times #XR#Y$,
    punnett(
      (XR, Xr),
      alt: (XR, Y),
      (a, b) => {
        let fill = if b == Y { a2c(a) } else { red }
        let sex = if b == Y { sym.mars } else { sym.venus }
        table.cell(
          fill: fill,
          $#a#b space #sex$,
        )
      },
    ),
  )
]

#example[
  An for non-dominance with skin color as example.

  #let (R1, R2) = (1, 2).map(allele.with("R"))
  $
        #R1 := & "red skin" \
        #R2 := & "white skin" \
    #R1 approx & #R2.
  $

  #figure(
    caption: $#R1#R2 times #R1#R2$,
    punnett(
      (R1, R2),
      (a, b) => {
        let fill = if (a, b) == (R1, R1) {
          red
        } else if (a, b) == (R2, R2) {
          white
        } else {
          gradient.linear(red, white, angle: 45deg).sharp(3)
        }
        table.cell(fill: fill, $#a#b$)
      },
    ),
  )
]

/ Trait: An observable characteristic of an organism, usually morphological.
  A phenotype is an expression of a state of a trait.

/ True-breeding: A breeding where both parents are homozygpous.
  The offspring is then heterozygous.


Remember that X-link traits can inherit differently across male and female offsprings.
A phenotypic mode of inheritance difference between male and female offsprings indicate that the trait is X-linked.

#definition(title: [Pedigree])[
  A pedigree is a tree of decendence showcasing sex, mating outcome, and traits.

  #figure(
    caption: [Pedigree Symbols],
    table(
      columns: (20%, auto),
      [Symbol], [Meaning],
      $square$, [Male],
      $circle$, [Female],
      $square.filled \/ circle.filled$, [Is "affected"],
      $stretch(-, size: #200%)$, [Mated],
      $stretch(=, size: #200%)$, [Consanguine mated],
      $tack.b$, [Produced],
    ),
  )
]

In pratice, we need to be aware of assumptions made in drawing a pedigree.
Phenotypes are not always two distinct types, determined by only one gene, or not affected by external factors like the environment.
Genotypes may not be typical, for example, one can carry extra chromosomes.

Always check reliability of a pedigree when interpreting it.

#example[
  Given an unaffected female (1) and an affected male (2), who mate to produce an affected male (3), the inheritance mode cannot be X-linked dominant.

  #let (XA, Xa) = ("A", "a").map(allele.with("X"))
  #let Y = allele("Y")
  #proof[
    Assume that the inheritance mode is X-linked dominant.
    Let $A$ be the indicator that one is affected.
    $
      #XA := & "affected" \
      #Xa := & "not affected".
    $
    Then,
    $
         not A(P_1) implies & P_1 = Xa Xa \
             A(P_2) implies & P_2 = Xa #Y \
             A(F_3) implies & F_3 = XA #Y \
      P_1 times P_2 implies & F_3 = s #Y quad & "where" s in P_1.
    $
    However, $XA in.not P_1 implies s eq.not XA$, which contradicts $XA #Y = s #Y$.
    Therefore, the inheritance mode cannot be X-linked dominant.
  ]
]

= Evolution
/ Microevolution: Changes in allele frequencies within a species.

/ Macroevolution: Descent of new species from an old one, usually over a very long time.

In this course as of now, we define life as organisms of one or multiple cells and use DNA as genetic codes.
So viruses are not, and we can assume that all living things have a common ancestor.

/ Homology: Also homologous feature; a trait present in multiple organisms that was inherited from their common ancestor.
  A homologous feature does not have to look the same, or function in the same way on these organisms.
  Traits that look or function similarly may not be homologies.

/ Analogy: Also analogous feature; traits that look or function similarly but not inherited from a common ancestor.

/ Extinction: An event where a species has no living members and can no longer pass their distinct genetic material to offspings.
  "Javis, overlay extinction rate with human industrialization timeline."

/ Vestigial feature: A small remnant of a feature that was significant.

== Machenisms of Evolution

/ Mutation: Random changes to alleles that introduces new alleles.
  From as small as one nucleotide, to segments of chromosomes.

Mostly due to error in gene duplication, hence most prominant during meiosis and mitosis.
If a mutation occurs in a germline cell ("sex" cell), it could be inherited, hence significant to evolution.

Many mutation has little to no effect on an individual or its fitness.
It is because most genes do not code for amino acids, and those which do sometime have redundancy.

/ Gene flow: Alleles introduced to a population by moving-in and mating of individuals.

Skipping explanation since random walk is learned.

/ Genetic drift: Random shifts in allele frequencies in a population over generations.

  For diploids like us, passing of either of the two paired chromosomes from each parent can cause genetic drifts.
  There is also random survival of individuals carrying certain alleles.
  In all, some individuals have more descendants than others, just by luck.

  Genetic drift tend to have larger effects on smaller populations, since each drift in an individual is more effective when population is small.
  Yes, the partial differential random walk diagrams.

  / Bottleneck event: A drastic decrease of population.
    Only alleles left in indivuduals alive are carried on.

  / Founder event: A small group from a population starting a new population.
    It is effectively the same as a bottleneck event.

  These events make genetic drifts more likely, but it can happen without change in popilation.

/ Natural selection: Non-random changes in allele frequencies due to conditions being favorable to some individuals.

  / Fitness: A measure of relative reproductive success.
    Survival before potential reproduction counts, but survival alone does not matter.

=== Natural Selection
Natural selection occur iff:
- Variation: There is variation in phenotypes.
- Differential reproduction: The different phenotypes result in different fitness.
  In case of sexual selection, the difference can also be the gene quality of the offsprings.
- Heredity: The alleles expressing the phenotypes are inheritable.

There are three modes of selection:

/ Directional selection: Selection that favors one end of a phenotype.
  It usually reduces variation in that phenotype.

/ Stablilzing selection: Selection that favors the average of a phenotype.
  It usually reduces variation in that phenotype.

/ Disruptive selection: Selection that punishes the average of a phenotype.
  It usually raises variation in that phenotype, but does not affect the range or the average.

Note that the same selected phenotype may be results of different alleles or genes.

/ Adaptation: A species becoming more fit over generations.
  It can be physiological, but also behavioral.

  As a part of natural selection, the adapted phenotype must be heritable, and function towards higher fitness.

/ Acclimation: An individual becoming more fit during its lifetime.
  Hence, not a part of natural selection.

== Phylogenetic Trees
Basically a tree of species growing along time, with some nodes having trait marks, whom of common parent indicate diversion of a trait.
A node of one child may not be marked, but we can point to any point with a non-zero time component and say some species is there.

/ Sister taxa: Children of a common parent on a phylogenetic tree.

/ Monophyletic group: Also clade; a subtree of a phylogenetic tree.
/ Polyphyletic group: A monophyletic group without the common ancestor.
/ Paraphyletic group: A monophyletic group excluding some subtrees of the common ancestor.

/ Synapomorphy: Homologous traits inherited from the most recent ancestor.
/ Plesiomorphy: Also symplesiomorphy; homologous traits inherited from before the penultimate branching.
/ Autapomorphy: Traits unique to a branch.

Note that these are only defined for branchings shown.
It is very likely for more intermediate branching to exist but not drawn.

/ Related: Having a common ancestor.
  The more homology (usually more common ancestors), the closer two species are related.

The trees are bifurcating, but they can multifurcate when details are not known or coarsely scaled.

== Speciation
There is no definite definition of species, but in this class...

/ Species (biological): A population whose members can interbreed and produce viable, fertile offsprings.
  This is not defined for asexual or organisms whose reproductive status we cannot confirm, exempli gratiā extinct species without relevant records.
/ Viable: Can survive.
/ Fertile: Can reproduce.

The timing in breeding also counts as a reproductive barrier.

To speciate:
+ Stop gene flow.
+ Diverge genetics.
+ Isolate reproduction.

/ Allopatric speciation: Speciation via physical separation of population.
  / Vicariance: Formation of new physical barriers.
  / Dispersal: One-way movement of populations, not migration.

/ Sympatric speciation: Speciation without physical barriers.
  This include microhabitat choices, since the organisms can technically move among those freely.
  For instance, the speciation of Apply Fly and Hawthorn Fly.

