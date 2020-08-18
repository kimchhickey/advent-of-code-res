open Util;

let input = readInputLines("Day2");
let parse = l => {
  l->Belt.List.map(Js.String.split("\t"));
};

parse(input)->Js.log;
