#import "./utils.typ": explorer_address, token_address

#let payment(details) = [
  == Payment instructions
  #v(1em)
  To be paid in #underline(token_address(
    url_template: details.chain.explorer_address_template,
    details.token
  )) on _#details.chain.name _ to the following digital wallet address:
  #link(explorer_address(details.wallet, details.chain.explorer_address_template), underline(raw(details.wallet))).
]