type banks = list<int>

let history = list{}

let rec cycle = banks => {
  let select = banks => Belt.List.headExn(banks)
  let redistribute = (bank, banks) => bank

  let selected = select(banks)
  let redistributed = redistribute(selected, banks)
  if banks->Belt.List.some(bank => Belt.List.eq(bank, redistributed, (a, b) => a == b)) {
    banks->Belt.List.length
  } else {
    cycle(banks->Belt.List.add(redistributed))
  }
}

