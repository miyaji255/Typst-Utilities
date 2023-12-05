

#let _era-map = json("./era-map.json").map(
  era => (
    :..era,
    from: datetime(year: era.from.year, month: era.from.month, day: era.from.day),
  ),
)

#let _get-year-regex = regex("\[year( sign:(kanji|alphabet|upper_alphabet|lower_alphabet))?\]")

#let get-era(date, with-nen: true, era-style: "kanji") = {
  assert.eq(datetime, type(date), message: "The type of 'date' must be datetime.")
  assert.eq(bool, type(with-nen), message: "The type of 'with-nen' must be bool.")
  assert(
    ("kanji", "alphabet", "lower_alphabet", "upper_alphabet").contains(era-style),
    message: "'era-style' must be 'kanji', 'alphabet', 'lower_alphabet' or 'upper_alphabet'.",
  )
  assert(
    _era-map.at(-1).from <= date,
    message: _era-map.at(-1).from.display("'date' must be later than [year]-[month]-[day]."),
  )

  let era = ""
  let year = 0
  for (from, name, alphabet) in _era-map {
    if (from <= date) {
      year = date.year() - from.year() + 1
      era = if era-style == "kanji" {
        name
      } else if era-style == "alphabet" {
        alphabet
      } else if era-style == "upper_alphabet" {
        upper(alphabet)
      } else if era-style == "lower_alphabet" {
        lower(alphabet)
      } else {
        assert(false, message: "unreachable")
      }
      break
    }
  }

  if with-nen {
    return era + if year == 1 { "元年" } else { str(year) + "年" }
  } else {
    return era + if year == 1 { "元" } else { str(year) }
  }
}

#let display-era(date, format) ={
  assert.eq(datetime, type(date), message: "The type of 'date' must be datetime.")
  assert.eq(str, type(format), message: "The type of 'format' must be str.")

  return date.display(
    format.replace(
      _get-year-regex,
      (era-style) => {
        if era-style.captures.at(1) == none {
          return get-era(date, with-nen: false)
        } else {
          return get-era(date, with-nen: false, era-style: era-style.captures.at(1))
        }
      },
    ),
  )
}

#let _get-digits = (value) => {
  if value > 0 {
    if value >= 1 {
      let digits = 0;
      let base = 1;
      while value >= base * 10 {
        digits += 1
        base *= 10
      }
      return (digits, base)
    } else {
      let digits = 0;
      let base = 1
      while value * base < 1 {
        digits -= 1
        base *= 10
      }
      return (digits, 1 / base)
    }
  } else if value < 0 {
    if value <= -1 {
      let digits = 0;
      let base = -1
      while value <= base * 10 {
        digits += 1;
        base *= 10
      }
      return (digits, -base)
    } else {
      let digits = 0;
      let base = -1
      while value * base < 1 {
        digits -= 1;
        base *= 10
      }
      return (digits, 1 / -base)
    }
  } else { // value == 0
    return (0, 1)
  }
}

#let fmt-float(
  value,
  accuracy,
  dot: math.dot,
  is-equation: true,
  ignore-invalid: true,
) = {
  assert.eq(type(accuracy), int, message: "Type of 'accuracy' must be integer.");
  assert.eq(type(is-equation), bool)
  assert(accuracy > 0, message: "'accuracy' must be more than 0");
  if (
    ignore-invalid and type(value) != int and type(value) != float and str(value).match(regex("^(|\+|-)\d+(.\d+)?([eE](|\+|-)\d+)?$")) == none
  ) {
    return value
  }
  value = if type(value) == int { value } else { float(value) }
  if value < 0 {
    accuracy += 3;
  }
  let (digits, base) = _get-digits(value)

  let valuestr = str(value / base)
  if valuestr.contains(".") or valuestr.contains(",") {
    while valuestr.len() < accuracy + 1 {
      valuestr += "0";
    }
    valuestr = valuestr.slice(0, accuracy + 1)
  } else {
    if valuestr.len() < accuracy {
      valuestr += "."
      while valuestr.len() < accuracy + 1 {
        valuestr += "0";
      }
    } else {
      valuestr = valuestr.slice(0, accuracy)
    }
  }

  if is-equation {
    return $valuestr dot 10^digits$
  } else {
    return [#valuestr #dot 10#super(str(digits))]
  }
}
