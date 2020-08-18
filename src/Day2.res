open Util;

let input = readInputLines("Day2");
let parse = l => {
  let sheet = [];
  l->Belt.List.forEach(row => {
    let arr_row =
      row |> Js.String.split("\t") |> Js.Array.map(v => int_of_string(v));

    Js.Array.push(arr_row, sheet);
  });
  sheet;
};
