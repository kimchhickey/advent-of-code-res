open Util
open Belt

module ProgramMap = Belt.HashMap.String
module ProgramSet = Belt.HashSet.String

type rec program = {
  weight: int,
  total: int,
  holdings: ProgramSet.t,
}

let tree = readInputLines("Day7")->List.reduce(ProgramMap.make(~hintSize=2000), (pmap, str) => {
  let str_arr = Js.String.splitByRe(%re("/\s|\(|\)/"), str)
  let key = Option.getExn(Array.getExn(str_arr, 0))
  let weight = int_of_string(Option.getExn(Array.getExn(str_arr, 2)))
  let total = 0
  let holdings =
    Array.length(str_arr) <= 4
      ? ProgramSet.make(~hintSize=0)
      : ProgramSet.fromArray(
          Array.map(Array.sliceToEnd(str_arr, 5), a => Option.getWithDefault(a, "")),
        )

  ProgramMap.set(pmap, key, {weight: weight, total: total, holdings: holdings})
  pmap
})

let total = (tree, key) => {
  ProgramMap.get(tree, key)
}

Option.getExn(total(tree, "bpvhwhh")).holdings->Js.log
