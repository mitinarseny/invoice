#import "./utils.typ": mailto, tel

#let address(addr) = [
  #if "street" in addr [
    #addr.street, \
  ]
  #if "city" in addr [
    #addr.city,
  ]
  #if "country" in addr [
    #addr.country \
  ]
  #if "postal_code" in addr [
    #addr.postal_code
  ]
]

#let party(details) = align(horizon, table(
  columns: 1,
  stroke: none,
  [*#details.name*],
  [],
  eval(details.at("info", default: ""), mode: "markup"),
  [#if "address" in details [
    _Address:_ \
    #address(details.address)
  ]],
  [],
  [
    #if "email" in details [
      _e-mail:_: #mailto(details.email)
    ] \
    #if "tel" in details [
      _tel_: #tel(details.tel)
    ]
  ],
))

#let parties(contractor, billed_to) = table(
  columns: (1fr, 1fr),
  stroke: (x, y) => {
    if x == 0 {(right: 1pt)} else {none} + if y == 0 {(bottom: 1pt)} else {none}
  },
  table.header(align(center)[== Contractor], align(center)[== Billed To]),
  party(contractor), party(billed_to),
)