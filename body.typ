// write variables
#let starting_page = 1
#let journal_vol = [x]
#let article_no = [x]
#let pub_date = datetime.today()
#let title = lorem(6)
#let departments = (
  "Fakultas Ilmu Komputer, Universitas Dian Nuswantoro Semarang",
)
#let authors = (
  (
    name: "Steven Staria Nugraha",
    email: "111202214433@mhs.dinus.ac.id",
    department_id: 1, // match departments index starting from 1
  ),
)
#let abstract = (
  [#lorem(50)],
  [#lorem(50)], // translation (i.e. english)
)
#let keywords = (
  ("Foo", "Bar", "Baz"),
  ("Baz", "Bar", "Foo"), // translation
)

// system variables
#let font_size = 11pt
#let y_margin_font_size = 10pt
#let caption_font_size = 10pt
#let title_font_size = 18pt
#let author_info_font_size = 11pt
#let line_height = .65em
#let month_translation = (
  "Januari",
  "Februari",
  "Maret",
  "April",
  "Mei",
  "Juni",
  "Juli",
  "Agustus",
  "September",
  "Oktober",
  "November",
  "Desember",
)
#let abstract_heading(body) = {
  set align(center)
  set text(weight: "bold")
  set block()
  body
}
#let keyword_separator = ", "

// settings
#set text(lang: "id", size: font_size)
#set par(justify: true, leading: line_height, spacing: line_height)
#set math.equation(numbering: "(1)", supplement: "Persamaan ")
#context counter(page).update(starting_page)
#set page(
  margin: 1.18in,
  header: context [
    #set text(style: "italic", size: y_margin_font_size)
    #set align(center)

    Abdimasku, Vol. #journal_vol, No. #article_no, #month_translation.at(pub_date.month() - 1) #pub_date.year(): #{ starting_page }-#{ counter(page).final().last() }
  ],
  footer: context [
    #set text(size: y_margin_font_size)
    #set align(center)
    #counter(page).display()
  ],
)
#set heading(numbering: "1. ")
#show heading.where(depth: 1): it => {
  set align(center)
  set text(style: "normal")
  set block(below: 2 * line_height)
  upper(it)
}
#show heading: it => {
  set block(above: 2 * line_height)
  set text(size: font_size, weight: "regular", style: "italic")
  it
}

// body
// title
#v(line_height)
#text(size: title_font_size)[
  #set align(center)
  #title
]
// authors
#v(line_height)
#{
  set align(center)
  [
    #(
      authors
        .enumerate(start: 1)
        .map(((i, a)) => { [#a.name#super([#i])] })
        .join(", ")
    )\
    #(
      departments
        .enumerate(start: 1)
        .map(((department_id, d)) => {
          [#super([#(
                authors
                  .enumerate(start: 1)
                  .filter(((_, author)) => {
                    author.department_id == department_id
                  })
                  .map(((author_id, _)) => { [#author_id] })
                  .join(",")
              )])#d]
        })
    ).join("\n")\
    Email: #(
      authors.enumerate(start: 1).map(((i, a)) => { [#super([#i])#a.email] }).join(", ")
    )
  ]
}
#v(line_height * 2)
// abstract
#abstract_heading([Abstrak])
#abstract.at(0)
#block(above: line_height * 2, below: line_height * 2)[
  Kata kunci: #keywords.at(0).join(keyword_separator)
]

// abstract translatioin
#set text(style: "italic")
#abstract_heading([Abstract])
#abstract.at(1)
#block(above: line_height * 2, below: line_height * 3)[
  Keywords: #keywords.at(1).join(keyword_separator)
]

#set text(style: "normal")
#set par(first-line-indent: (
  amount: 0.5in,
  all: true,
))

= Pendahuluan
#lorem(25)

#lorem(25)

== Subbab
#lorem(50)

= Metode
#lorem(100) @eq:
$
  sum_(k=0)^n k & = 1 + ... + n \
              F & = x
$  <eq>

