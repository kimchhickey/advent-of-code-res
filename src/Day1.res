// from https://github.com/yunyu/advent-of-code-2018
let readFileAsLines = (filename, trim) => {
  let fileContents = Node.Fs.readFileAsUtf8Sync(filename);
  Js.String.split("\n", trim ? Js.String.trim(fileContents) : fileContents)
  ->Belt.List.fromArray;
};

let inputFilename = tag => "input/" ++ tag ++ ".txt";
let readInputLines = (~trim=true, tag) =>
  tag->inputFilename->readFileAsLines(trim);

let data = Belt.List.head(readInputLines("Day1"));

let stringToList = (s) => {
  switch (s) {
    | None => list{}
    | Some(s) => {
      let rec make = (i, l) => {
        if (i <= 0) {
          l
        } else {
          let c = Char.code(String.get(s, i - 1)) - 48
          let l' = Belt.List.add(l, c)
          make(i - 1, l')
        }
      }

      make(String.length(s), list{})
    }
  }
}

let shift = (l, n) => {
  let d =
    switch Belt.List.drop(l, n) {
      | None => list{}
      | Some(x) => x
    }
  let t =
    switch Belt.List.take(l, n) {
      | None => list{}
      | Some(x) => x
    }
  
  Belt.List.concat(d, t)
}

let match = (l1, l2) => {
  let rec d = (l1, l2, result) => {
    switch (l1, l2) {
      | (list{}, list{}) => result
      | (list{h1, ...t1}, list{h2, ...t2}) => {
        let result' =
          if h1 == h2 {
            Belt.List.add(result, h1)
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

let origin = stringToList(data) // "3294191..." -> list{3, 2, 9...}

// part 1
let part1 = shift(origin, 1)
match(origin, part1)
  ->Belt.List.reduce(0, ((a, b) => a + b))
  ->Js.log
  
// part 2
let part2 = shift(origin, Belt.List.length(origin) / 2)
match(origin, part2)
  ->Belt.List.reduce(0, ((a, b) => a + b))
  ->Js.log
  