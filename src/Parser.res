// type parser<'a> = string => (option<'a>, string)
// let item: parser<string> =
//   str =>
//     switch str {
//       | "" => (None, str)
//       | str => (
//         Some(Js.String.charAt(0, str)),
//         Js.String.substringToEnd(~from=1, str)
//       )
//     }
// let filter = pred => p => str => {
//     switch p(str) {
//     | (None, _) => (None, str)
//     | (Some(v), str') => {
//       if (pred(v)) {
//         (Some(v), str')
//       } else {
//         (None, str)
//       }
//     }
//   }
// }
// let char = c => filter(a => a === c, item)
// let seq = p1 => p2 => str => {
//   switch p1(str) {
//     | (None, _) => (None, str)
//     | (Some(v1), str1) => {
//       switch p2(str1) {
//         | (None, _) => (None, str)
//         | (Some(v2), str2) => (Some(v1 ++ v2), str2)
//       }
//     }
//   }
// }
// // let charA = char("a")
// // let charB = char("b")
// // let parserAB = seq(charA, charB)
// // Js.log(parserAB("abcde"))
// // Gill
// let and_then = f => pa =>
//   str =>
//     switch pa(str) {
//       | (Some(a), rest) => f(a)(rest)
//       | (None, _) => (None, str)
//     }
// let map = f => pa =>
//   str =>
//     switch pa(str) {
//       | (Some(a), rest) => (f(a), rest)
//       | (None, _) => (None, str)
//     }
// let parse_a = char("a")
// let parse_b = char("b")
// // let ab = parse_a |> and_then((_) => parse_b)
// let ab = parse_a
//   |> and_then((_) => parse_b)
//   |> map((_) => "ab")
// Js.log(ab("abc"))
