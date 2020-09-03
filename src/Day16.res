@bs.module("fs")
external readFileSync: (
  ~name: string,
  @bs.string [
    | #utf8
    | @bs.as("ascii") #useAscii
  ],
) => string = "readFileSync"

let input = readFileSync(~name="input/day16.txt", #utf8)

type danceMovement =
  | Spin(int)
  | Exchange(int, int)
  | Partner(string, string)

let parseInt = p => {
  p
  ->Belt.Option.map(int_of_string)
  ->Belt.Option.getWithDefault(0)
}

let parseString = p => {
  p
  ->Belt.Option.map(Js.String2.trim)
  ->Belt.Option.getWithDefault("")
}

let parse = str => {
  let command = Js.String2.get(str, 0) 
  let param = str
              ->Js.String2.sliceToEnd(~from=1)
              ->Js.String2.split("/")

  let p1 = Belt.Array.get(param, 0)  // option<'a>
  let p2 = Belt.Array.get(param, 1)  // option<'a>

  switch command {
    | "s" => Some(Spin(parseInt(p1)))
    | "x" => Some(Exchange(parseInt(p1), parseInt(p2)))
    | "p" => Some(Partner(parseString(p1), parseString(p2)))
    | _ => None
  }
}

let commands = input
->Js.String2.splitByRe(%re("/,/")) // let splitByRe: (t, Js_re.t) => array<option<t>>
->Belt.Array.keepMap(s => Belt.Option.map(s, parse))
// ->Js.log

// -------
let spin = programs => n => {
  let l = Belt.Array.length(programs)

  Belt.Array.concat(
    Belt.Array.slice(programs, ~offset=(l - n), ~len=n)
    Belt.Array.slice(programs, ~offset=0, ~len=(l - n))
  )
}

let exchange = programs => p1 => p2 => {
  let v1 = 
    Belt.Array.get(programs, p1)
    ->Belt.Option.getWithDefault("")

  let v2 = 
    Belt.Array.get(programs, p2)
    ->Belt.Option.getWithDefault("")

  let _ = Belt.Array.set(programs, p1, v2)
  let _ = Belt.Array.set(programs, p2, v1)
  programs
}

let partner = programs => p1 => p2 => {
  let findIndex = programs => x => {
    programs
    ->Belt.Array.getIndexBy(v => v === x)
    ->Belt.Option.getWithDefault(0)
  }

  let i = findIndex(programs, p1)
  let j = findIndex(programs, p2)
  exchange(programs, i, j)
}

let move = programs => command => {
  switch command {
    | Spin(n) => spin(programs, n)
    | Exchange(p1, p2) => exchange(programs, p1, p2)
    | Partner(p1, p2) => partner(programs, p1, p2)
    | _ => programs
  }
}

let join = strArray => Js.String2.concatMany("", strArray)

// test
let test = spin(["a", "b", "c", "d", "e"], 1)
->exchange(3, 4)
->partner("e", "b")
->join
->Js.log

// part 1
let initPrograms = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]

Belt.Array.reduce(
  commands,
  initPrograms,
  (p, c) => Belt.Option.mapWithDefault(c, p, move(p)))
->join
->Js.log
