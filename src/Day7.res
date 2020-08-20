open Util

module ProgramMap = Belt.HashMap.String

type rec program = {
  weight: int,
  total: int,
  // holdings: ProgramMap.t<program>
}

readInputLines("Day7")->Belt.List.reduce(Belt.HashMap.String.make(~hintSize=2000), (m, str) => {
  // parse
  m
})->Js.log
