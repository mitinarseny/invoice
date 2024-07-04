#import "./src/invoice.typ": invoice
#import "./src/utils.typ": parse_date, start_of_month

#let data = yaml(sys.inputs.at("config", default: "./invoice.yaml"))

#{
  data.issue_date = if "issue_date" in data {
    parse_date(data.issue_date)
  } else {
    datetime.today()
  }
  data.due_date = if "due_date" in data {
    parse_date(data.due_date)
  } else {
    data.issue_date + duration(days: 15)
  }
  data.id = data.at("id", default: data.issue_date.display("[month]/[year]"))

  data.service.period = data.service.at("period", default: (:))
  data.service.period.from = if "from" in data.service.period {
    parse_date(data.service.period.from)
  } else {
    start_of_month(data.issue_date)
  }
  if "to" in data.service.period {
    data.service.period.to = parse_date(data.service.period.to)
  }
  if "dated" in data.service.at("contract", default: (:)) {
    data.service.contract.dated = parse_date(data.service.contract.dated)
  }

  data.signature.date = if "date" in data.signature {
     parse_date(data.signature.date)
  } else {
    data.issue_date
  }
  if "sign" in data.signature {
    data.signature.sign = image(data.signature.sign)
  }
}

#set document(
    title: [
      Invoice #if "id" in data [№#data.id],
    ],
    author: data.contractor.name,
    date: data.signature.date,
  )
#set text(font: "Arial", size: 10pt, lang: "en")

#invoice(
  id: data.at("id", default: none),
  issue_date: data.issue_date,
  due_date: data.due_date,
  contractor: data.contractor,
  billed_to: data.billed_to,
  service: data.service,
  additional_items: data.at("additional_items", default: ()),
  payment: data.payment,
  signature: data.signature,
)
