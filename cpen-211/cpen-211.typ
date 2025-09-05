#import "../lib.typ": *
#show: setup.with(
  title: [CPEN 211 \ _Digital Design & Computer Architecture_],
  author: "Yecheng Liang"
)

= Number Systems
#figure(
  caption: [Commonly used values],
  table(
    columns: 3,
    table.header([Binary], [Decimal], [Hexidecimal]),
    [0100], [4], [4],
    [1010], [10], [A],
    [1111], [15], [F]
  )
)

== Conversion

=== To Decimal
+ Compute each digit's value in decimal;
+ sum them up.

=== From Decimal
+ Divide by 2;
+ take reminder as digit;
+ take quotient as the next digit;
+ repeat if quotient is greater than base.

=== Between Hexidecimal and Binary
Each hex digit is four binary digits.

== Addition

== Signed Numbers

== Extension
