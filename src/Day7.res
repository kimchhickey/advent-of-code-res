open Util

module ProgramMap = Belt.HashMap.String

type rec program = {
  weight: int,
  total: int,
  holdings: Belt.HashSet.String.t,
}

let tree = readInputLines("Day7")->Belt.List.reduce(ProgramMap.make(~hintSize=2000), (m, str) => {
  let str_arr = Js.String.splitByRe(%re("/\s|\(|\)/"), str)
  let key = Belt.Option.getExn(Belt.Array.getExn(str_arr, 0))
  let weight = int_of_string(Belt.Option.getExn(Belt.Array.getExn(str_arr, 2)))
  let total = 0
  let holdings =
    Belt.Array.length(str_arr) <= 4
      ? Belt.HashSet.String.make(~hintSize=0)
      : Belt.HashSet.String.fromArray(
          Belt.Array.map(str_arr, a => Belt.Option.getWithDefault(a, "")),
        )

  ProgramMap.set(m, key, {weight: weight, total: total, holdings: holdings})
  m
})

let total = (tree, key) => {
  let v = ProgramMap.get(tree, key)
  v->Js.log
}

total(tree, "bpvhwhh")
