#import "exports.typ": *

#let experiment_date = datetime(year: 2023, month: 11, day: 1)

#{
  assert.eq("令和5年", display-era(datetime(year: 2023, month: 1, day: 1), "[year]年"))
  assert.eq(
    "令和5年",
    display-era(datetime(year: 2023, month: 1, day: 1), "[year sign:kanji]年"),
  )
  assert.eq(
    "R5年",
    display-era(datetime(year: 2023, month: 1, day: 1), "[year sign:alphabet]年"),
  )
  assert.eq(
    "R5年",
    display-era(datetime(year: 2023, month: 1, day: 1), "[year sign:upper_alphabet]年"),
  )
  assert.eq(
    "r5年",
    display-era(datetime(year: 2023, month: 1, day: 1), "[year sign:lower_alphabet]年"),
  )

  assert.eq("令和元年", display-era(datetime(year: 2019, month: 5, day: 1), "[year]年"))
  assert.eq(
    "平成31年",
    display-era(datetime(year: 2019, month: 4, day: 30), "[year]年"),
  )
}

#fmt-float("12687.326482", accuracy: 2, is-equation: false)

#fmt-float("1.48148E-07")

#fmt-float("-1481.48E")

#fmt-float("74", accuracy: 1)

#fmt-float("1235")

