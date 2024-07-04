#import "./utils.typ": format_date

#let signature(
  date,
  location,
  name,
  sign,
) = {
  grid(
    columns: (2fr, 1fr),
    align: center,
    table(
      columns: (1fr, 1fr),
      stroke: none,
      align: (right, left),
      [Date:],
      [*#format_date(date)*],
      ..if location != none {(
        [Location:],
        [*#location*],
      )},
      [The contractor:],
      [*#name*],
    ),
    sign,
  )
}