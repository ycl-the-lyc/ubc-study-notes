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

/ Phenotype: A measurable physical property of an individual.

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

/ Homozygpous: A cell having identical alleles across homologous chromosomes.

/ Heterozygous: A cell having different alleles across homologous chromosomes.

+ $G_1$, gap one, cell growth;
  At the end, cell checks if condition is favorable for cell division.

+ $S$, DNA synthesis / chromosome replication;
  DNA unzips, then bind with complementary nucleotides to form two identical DNAs.

+ $G_2$, gap two, cell growth;
  At the end, cell checks for condition and gene damage.

+ $M$, nuclear division, mitosis or meiosis, then cytokinesis (duplicating cytoplasm, which is stuff other than the nucleus).

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
