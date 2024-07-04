#let parse_date(s) = {
  let (year, month, day) = s.split("-").map(int)
  datetime(year: year, month: month, day: day)
}
#let format_date(d) = d.display("[day] [month repr:short] [year]")

#let start_of_month(d) = datetime(
  year: d.year(),
  month: d.month(),
  day: 1,
)
#let end_of_month(d) = {
  let month = d.month()
  while d.month() == month {
    d += duration(days: 1)
  }
  d - duration(days: 1)
}

#let mailto(addr) = link("mailto:" + addr)
#let tel(number) = link("tel:" + number)

#let explorer_address(address, template) = template.replace("{}", address)
#let explorer_address_link(address, template) = link(explorer_address(address, template), address)
#let token_address(token, url_template: none) = {
  if url_template != none {
    link(
      explorer_address(token.address, url_template),
      [#token.name (#token.symbol)]
    )
  } else {
    [#token.name (#token.symbol)]
  }
}