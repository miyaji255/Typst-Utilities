#let myname = "阪大　太郎"
#let mynumber = "00A01234"
#let mycourse = "~~コース"
#let mymail = "example@ecs.osaka-u.ac.jp"
#let mygroup = 1
#let members = ("阪大　太郎", "阪大　太郎")

#let first_page = (
  number,
  title,
  experiment_date,
  write_date: datetime.today(),
  members: members,
) => [
  #set text(font: "Yu Mincho", size: 14pt)
  #set underline(offset: 0.25em, stroke: 0.5pt)

  #align(
    center,
  )[
    #text(font: "Yu Gothic", size: 20pt)[*電子情報工学科*\
      *電気電子工学専門実験A 報告*\

      #h(1em)

      *第 #number 号*]

    #v(2em)

    #text(size: 16pt)[
      実 験 題 目\ #underline(title)\
    ]

    #underline(
      )[#mycourse#box(width: 2em, stroke: (bottom: 0.5pt), outset: (bottom: 0.25em))第
      #mygroup 班

      #members.join("\n")
    ]

    #align(bottom)[

      #{ "報　　告　　者" }

      #underline()[
        #{ mynumber }番#{ " " }#myname #{ " " } (#mycourse)\
        電子メールアドレス：#mymail
      ]

      #v(4em)

      #write_date.display("[year]年[month]月[day]日")\
      大阪大学工学部電子情報工学科]
  ]

  #pagebreak()
]

#let experiment_date = datetime(year: 2023, month: 01, day: 01)

#first_page("A1", "ハイパワー衝撃回路の基礎実験", experiment_date)