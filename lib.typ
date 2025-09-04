#import "@preview/ilm:1.4.1": *

#import "@preview/physica:0.9.5"
#import physica: *

#let conj = math.overline
#let kern = math.cal([N])
#let Set(..args) = {
  let args = args.pos();
  $physica.Set(#args.remove(0), #args.join($, $))$
}

#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange, unit

#import "@preview/frame-it:1.2.0": *

#let theorem = frame("Theorem", red.desaturate(25%))

#let proof = frame("Proof", purple.lighten(60%).desaturate(40%)).with([])

#let example = frame("Example", gray)

#let qna = frame("Q&A", black.lighten(20%))

#let frames-outline(..supplements) = {
  let sps = supplements.pos()
  outline(target: selector.or(..sps.map(sp => figure.where(supplement: sp))), title: sps
    .map(sp => sp + [s])
    .join([, ], last: [ and ]))
}

#let setup(
  title: [],
  author: "",
  body,
) = {
  show: ilm.with(
    title: title,
    author: author,
  )
  show: frame-style(styles.thmbox)

  show: it => {
    set math.equation(numbering: "(1.1)")
    import "@preview/equate:0.3.2": equate
    equate(it, breakable: true, sub-numbering: true, number-mode: "label")
  }

  show: super-T-as-transpose // Render "..^T" as transposed matrix

  body
}
