
// from https://github.com/yunyu/advent-of-code-2018
let readFileAsLines = (filename, trim) => {
  let fileContents = Node.Fs.readFileAsUtf8Sync(filename);
  Js.String.split("\n", trim ? Js.String.trim(fileContents) : fileContents)
  ->Belt.List.fromArray;
};

let inputFilename = tag => "input/" ++ tag ++ ".txt";
let readInputLines = (~trim=true, tag) =>
  tag->inputFilename->readFileAsLines(trim);

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