open Util

module ProgramMap = Belt.HashMap.String

type rec program = {
  weight: int
  total: int
  // holdings: ProgramMap.t<program>
}

readInputLines("Day7")
->Belt.List.reduce(
  Belt.HashMap.String.make(~hintSize=2000),
  (m, str) => {
    // parse
    let sliced = Js.String.split(%re("/ab*/g"), str)
    if Belt.Array.length(sliced) == 2 {
      let key = Belt.Option.getExn(Belt.Array.get(sliced, 0))
      let weight = Belt.Option.getExn(Belt.Array.get(sliced, 1))
                   ->Js.String.split("")
      ProgramMap.set(m, key, {
        weight: 0,
        total: 0,
        // holdings: ProgramMap.Empty
      })
    } else {
      ProgramMap.set(m, str, {
        weight: 0,
        total: 0,
        // holdings: ProgramMap.Empty
      })
    }    
    m
  }
)->Js.log