#import "@preview/ilm:1.4.1": *

#import "@preview/physica:0.9.5": *
#show: super-T-as-transpose // Render "..^T" as transposed matrix

#let conj = math.overline
#let kern = math.cal([N])

// #import "@preview/equate:0.2.1": equate
// #show: equate.with(breakable: true, sub-numbering: true, number-mode: "label")
#show: it => { import "@preview/equate:0.3.2": equate; equate(it, breakable: true, sub-numbering: true, number-mode: "label") }
#set math.equation(numbering: "(1.1)")

#import "@preview/unify:0.7.1": unit, qty, qtyrange, num, numrange
