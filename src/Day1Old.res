/*
 * 
 * this function works only part 1
 *
*/
let is_match_next = l => {
  let rec match = (l, result) => {
    switch (l) {
      | list{} => result
      | list{last} => {
        switch (Belt.List.head(l)) {
          | None => result
          | Some(first) => {
            if last == first {
              Belt.List.add(result, last)
            } else {
              result
            }
          }
        }
      }
      | list{first, second, ...tail} => {
        let result' =
          if first == second {
            Belt.List.add(result, first)
          } else {
            result
          }

        match(list{second, ...tail}, result')
      }
    }
  }

  match(l, list{})
}

// is_match_next(data_list)
// ->Belt.List.reduce(0, ((a, b) => a + b))
// ->Js.log
