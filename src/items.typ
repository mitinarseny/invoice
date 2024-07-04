#import "./utils.typ": format_date, end_of_month

#let items(service, ..additional_items) = [
  == Items

  #let total = float(service.amount)
  #if "to" not in service.period {
    service.period.to = end_of_month(service.period.from)
  }

  #align(horizon, table(
    columns: (9fr, 2fr),
    align: (left, center),
    stroke: 0.4pt,
    table.header(
      [*Description*], [*Amount (USD)*]
    ),
    [
      #eval(service.description, mode: "markup") for the period
      from *#format_date(service.period.from)*
      to *#format_date(service.period.to)*
      #if "contract" in service [
        under the contract
        #if "ref" in service.contract [
          _#service.contract.ref _
        ]
        #if "dated" in service.contract [
          dated #format_date(service.contract.dated)
        ]
      ]
    ],
    str(service.amount),
    ..for (description, amount) in additional_items.pos() {
      total += float(amount)
      (
        eval(description, mode: "markup"),
        str(amount),
      )
    },
    table.cell(stroke: none, align(right)[*Total*]),
    [#total\*],
    table.cell(stroke: none, align(right)[*Including VAT*]),
    [Without VAT],
    table.cell(stroke: none, align(right)[*Total to pay*]),
    [#total\*],
  ))

  #text(size: 0.8em)[\* All payments made by the Company are net of and not subject to any withholding or deduction of any fees, taxes or duties, and must arrive to the Contractor's bank account in full, with consideration of the all bank fees and charges (including those of the bank-correspondent).]
]
