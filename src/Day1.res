open Util

let shift = (l, n) => {
  let escape = (f, l, n) => {
    switch (f(l, n)) {
      | None => list{}
      | Some(x) => x
    }
  }
  
  List.concat(
    escape(List.drop, l, n),
    escape(List.take, l, n)
  )
}

let match = (l1, l2) => {
  let rec d = (l1, l2, result) => {
    switch (l1, l2) {
      | (list{}, list{}) => result
      | (list{h1, ...t1}, list{h2, ...t2}) => {
        let result' =
          if h1 == h2 {
            List.add(result, h1)
          } else {
            result
          }
        d(t1, t2, result')
      }
      | _ => {
        Js.log("The length of two list is not same.")
        list{}
      }
    }
  }

  d(l1, l2, list{})
}

let data = List.head(readInputLines("Day1")); // r
let origin = stringToList(data) // "3294191..." -> list{3, 2, 9...}

// part 1
let part1 = shift(origin, 1)
match(origin, part1)
  ->List.reduce(0, ((a, b) => a + b))
  ->Js.log
  
// part 2
let part2 = shift(origin, List.length(origin) / 2)
match(origin, part2)
  ->List.reduce(0, ((a, b) => a + b))
  ->Js.log
  