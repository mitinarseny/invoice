#import "./utils.typ": parse_date, format_date

#let header(id, issue_date, due_date) = {
    if due_date < issue_date {
      panic("due_date must be after issue_date")
    }

    grid(
      columns: (1fr, 1fr),
      rows: 1,
      align: (left, right),
      align(horizon, text(size: 1.6em, [
        = Invoice #if id != none [№#id]
      ])),
      table(
        columns: 2,
        rows: (1fr, 1fr),
        stroke: none,
        align: (x, y) => {
          if x == 0 {right} else {left} + if y == 0 {bottom} else {top}
        },
        [_Issue Date_:],
        [*#format_date(issue_date)*],
        [_Due Date_:],
        [*#format_date(due_date)*],
      )
    )
  }