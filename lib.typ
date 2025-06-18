#let abdimasku(
  starting_page: 1,
  journal_vol: [x],
  article_no: [x],
  pub_date: datetime(day: 1, month: 2, year: 2025),
  title: [Judul Naskah Publikasi Maksimum 12 Kata dalam Bahasa Indonesia],
  departments: (
    [Nama departemen/jurusan, nama institusi/universitas],
  ),
  authors: (
    (
      name: "Penulis pertama",
      email: "penulis.1@email.ac.id",
      department_id: 1, // match departments index starting from 1
    ),
    (
      name: "Penulis kedua",
      email: "penulis.2@email.ac.id",
      department_id: 1, // match departments index starting from 1
    ),
    (
      name: "Penulis ketiga",
      email: "penulis.3@email.ac.id",
      department_id: 1, // match departments index starting from 1
    ),
  ),
  // TODO: use dictionary
  abstract: (
    [
      Abstrak maksimal 200 kata berbahasa Indonesia dan berbahasa Inggris (abstrak Bahasa Inggris dicetak miring) dengan ukuran font Times New Roman 11 point. Abstrak harus jelas, deskriptif dan harus memberikan gambaran singkat masalah dan pentingnya kegiatan pengabdian dilakukan. Abstrak meliputi alasan pemilihan topik atau pentingnya topik pengabdian, metode pengabdian dan ringkasan hasil. Abstrak harus diakhiri dengan komentar tentang pentingnya hasil atau kesimpulan singkat. Yang perlu diperhatikan adalah kesimpulan merupakan sesuatu yang sudah terjadi, bukan yang masih diharapkan. Tidak ada sitasi, tabel atau gambar di dalam abstrak.
    ],
    [
      A maximum 200 words abstract in English in italics with Times New Roman 11 point. Abstract should be clear, descriptive, and should provide a brief overview of the problem and what the importance of the community service. Abstract topics include reasons for the selection or the importance of the community service, methods and a summary of the results. Abstract should end with a comment about the importance of the results or conclusions brief. There are no citations, tables or figures in abstract.
    ],
  ),
  // TODO: use dictionary
  keywords: (
    (
      "kata kunci 1",
      "kata kunci 2",
      "kata kunci 3",
      "kata kunci 4",
      "kata kunci 5",
      "kata kunci 6",
      "kata kunci 7",
    ),
    (
      "keyword 1",
      "keyword 2",
      "keyword 3",
      "keyword 4",
      "keyword 5",
      "keyword 6",
      "keyword 7",
      "keyword 8",
    ),
  ),
  body,
) = {
  // system variables
  let font_size = 11pt
  let y_margin_font_size = 10pt
  let caption_font_size = 10pt
  let title_font_size = 18pt
  let author_info_font_size = 11pt
  let heading_1_numbering_size = 10pt
  let line_height = .65em
  let month_translation = (
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
  let abstract_heading(body) = {
    set align(center)
    set text(weight: "bold")
    set block()
    body
  }
  let keyword_separator = ", "

  // settings
  set text(lang: "id", size: font_size, font: "Times New Roman")
  set par(justify: true, leading: line_height, spacing: line_height)
  set math.equation(numbering: "(1)", supplement: "Persamaan ")
  context counter(page).update(starting_page)
  set page(
    margin: 1.18in,
    header: context [
      #set text(style: "italic", size: y_margin_font_size)
      #set align(center)

      Abdimasku, Vol. #journal_vol, No. #article_no, #month_translation.at(pub_date.month() - 1) #pub_date.year(): #{ starting_page }-#{ counter(page).final().last() }
    ],
    header-ascent: 22%,
    footer: context [
      #set text(size: y_margin_font_size)
      #set align(center)
      #counter(page).display()
    ],
  )
  set heading(numbering: "1. ")
  show heading.where(depth: 1): it => {
    set align(center)
    set text(style: "normal")
    block(below: 2 * line_height)[
      #text(
        if type(it.numbering) == str { counter(heading).display(it.numbering) },
        size: heading_1_numbering_size,
      )
      #upper(it.body)
    ]
  }
  show heading: it => {
    set block(above: 2 * line_height)
    set text(size: font_size, weight: "regular", style: "italic")
    it
  }
  set figure.caption(separator: ". ")
  show figure.caption: set text(size: caption_font_size)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(supplement: "Tabel")
  show figure.where(kind: image): set figure(supplement: "Gambar")
  set bibliography(title: "Daftar Pustaka")

  // body
  // title
  v(line_height * 3)
  text(size: title_font_size)[
    #set align(center)
    #title
  ]
  // authors
  v(line_height)
  {
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
  v(line_height * 2)
  // abstract
  abstract_heading([Abstrak])
  abstract.at(0)
  block(above: line_height * 2, below: line_height * 2)[
    Kata kunci: #keywords.at(0).join(keyword_separator)
  ]

  // abstract translatioin
  set text(style: "italic")
  abstract_heading([Abstract])
  abstract.at(1)
  block(above: line_height * 2, below: line_height * 3)[
    Keywords: #keywords.at(1).join(keyword_separator)
  ]

  set text(style: "normal")
  set par(first-line-indent: (
    amount: 0.5in,
    all: true,
  ))

  body
}
