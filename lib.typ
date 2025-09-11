#import "@preview/ilm:1.4.1": *

#import "@preview/physica:0.9.5"
#import physica: *

#let iff = $<=>$
#let conj = math.overline
#let kern = math.cal([N])
#let xor = "xor"
#let Set(..args) = {
  let args = args.pos();
  $#physica.Set(args.remove(0), args.join($, $))$
}
#let vn(body) = $norm(vb(body))$

#import "@preview/unify:0.7.1": num, numrange, qty, qtyrange, unit

#import "@preview/frame-it:1.2.0": *

#let definition = frame("Definition", black)

#let theorem = frame("Theorem", red.desaturate(20%))

#let lemma = frame("Lemma", orange)

#let proof = frame("Proof", purple.lighten(60%).desaturate(40%)).with([])

#let example = frame("Example", gray)

#let frames-outline(..supplements) = {
  let sps = supplements.pos()
  outline(target: selector.or(..sps.map(sp => figure.where(supplement: sp))), title: sps
    .map(sp => sp + [s])
    .join([, ], last: [ and ]))
}

#let max(arr) = arr.reduce((m, i) => if i > m { i } else { m })

#let min(arr) = arr.reduce((m, i) => if i < m { i } else { m })

#let ndissect(n, ilen: auto, dlen: auto, ipad: 0, dpad: 0) = {
  let d = ("sign", "int", "dec")
    .zip((
      int(n.signum()),
      ..str(calc.abs(n)).split(".").map(ds => ds.codepoints().map(int)),
    ))
    .to-dict()
  if type(ilen) == int and "int" in d {
    let len = d.int.len()
    if len > ilen {
      d.int = d.int.slice(len - ilen)
    } else {
      d.int = (ipad,) * (ilen - len) + d.int
    }
  }
  if type(dlen) == int and "dec" in d {
    let len = d.dec.len()
    if len > dlen {
      d.dec = d.dec.slice(0, dlen + 1)
    } else {
      d.dec += (dpad,) * (dlen - len)
    }
  }
  return d
}

#let ladd(
  ..nums,
  numeral: 10,
  ilen: auto,
  dlen: auto,
) = {
  let ns = nums.pos().map(ndissect.with(ilen: ilen, dlen: dlen))
  if auto in (ilen, dlen) {
    if ilen == auto {
      ilen = max(ns.map(n => n.int.len()))
    }
    if dlen == auto {
      dlen = max(ns.map(n => n.at("dec", default: ()).len()))
    }
    ns = nums.pos().map(ndissect.with(ilen: ilen, dlen: dlen)).map(n => (dec: (0,) * dlen) + n)
  }

  let add(part, c) = {
    let (c, ds) = array
      .zip(..ns.map(n => n.at(part)))
      .map(array.sum)
      .rev()
      .fold((c, ()), ((c, ds), d) => {
        d = d + c
        c = if d >= numeral { 1 } else { 0 }
        (
          c,
          (..ds, d - numeral * c),
        )
      })
    (c, ds.rev())
  }

  let (dc, dds) = add("dec", 0)
  let ids = add("int", dc).flatten()

  grid(
    columns: (.8em,) * (2 + ilen + if dlen > 0 { dlen + 1 }),
    inset: .3em,
    ..array
      .zip((([], []),) * (ns.len() - 1) + (([+], []),), ns.map(n => n.int.map(str)), ns.map(n => (
        if dlen > 0 { ([.],) } + n.dec.map(str),
      )))
      .flatten(),
    grid.hline(),
    ..(
      [],
      if ids.remove(0) == 1 { "1" } else [],
      ..ids.map(str),
      if dlen > 0 [.],
      ..dds.map(str),
    ).filter(el => el != none)
  )
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
  show figure.where(kind: "frame"): set block(breakable: true)

  show: it => {
    set math.equation(numbering: "(1.1)")
    import "@preview/equate:0.3.2": equate
    equate(it, breakable: true, sub-numbering: true, number-mode: "label")
  }

  show: super-T-as-transpose // Render "..^T" as transposed matrix

  body
}
