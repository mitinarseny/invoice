#import "./header.typ": header
#import "./parties.typ": parties
#import "./items.typ": items as make_items
#import "./payment.typ": payment as make_payment
#import "./signature.typ": signature as make_signature

#let invoice(
  id: none,
  issue_date: none,
  due_date: none,
  contractor: none,
  billed_to: none,
  service: none,
  additional_items: none,
  payment: none,
  signature: none,
) = {
  grid(
    columns: (1fr),
    rows: (1fr, 5fr, 5fr, 1.5fr, 1fr),
    gutter: 1fr,
    header(id, issue_date, due_date),
    parties(contractor, billed_to),
    make_items(service, ..additional_items),
    make_payment(payment),
    make_signature(
      signature.date,
      signature.at("location", default: none),
      signature.at("name", default: contractor.name),
      signature.at("sign", default: none),
    ),
  )
}