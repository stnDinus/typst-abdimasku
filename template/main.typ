#import "@local/abdimasku-template:0.0.1": abdimasku
#show: abdimasku.with(pub_date: datetime(day: 1, month: 2, year: 2025))

= Pendahuluan
#lorem(25)

#lorem(25)

== Subbab
#lorem(50)

= Metode
#lorem(100) :
$
  sum_(k=0)^n k & = 1 + ... + n \
              F & = x           \
$ <eq>

#lorem(20)
#figure(
  table(
    columns: 2,
    align: center,
    [Foo], [Bar],
    [Baz], [Foobar],
  ),
  caption: "Example table",
)
#lorem(20)

#figure(circle(), caption: [Sol])
