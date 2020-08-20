type banks = array<int>

let rec cycle = history => {
  let redistribute = origin => {
    let banks = Js.Array.copy(origin)
    // select
    let maxValue = Js.Array.reduce(max, 0, banks)
    let maxIndex = Js.Array.indexOf(maxValue, banks)

    // redistribute
    let index = ref(maxIndex)

    Js.Array.unsafe_set(banks, maxIndex, 0)
    for _ in maxValue downto 1 {
      if index.contents >= Js.Array.length(banks) - 1 {
        index := 0
      } else {
        index := index.contents + 1
      }

      Js.Array.unsafe_set(banks, index.contents, Js.Array.unsafe_get(banks, index.contents) + 1)
    }
    banks
  }

  let find = (history, banks) => {
    history->Belt.List.some(h =>
      Belt.List.eq(Belt.List.fromArray(h), Belt.List.fromArray(banks), (a, b) => a == b)
    )
  }

  let latest = Belt.List.headExn(history)
  let banks' = redistribute(latest)

  if find(history, banks') {
    // history // part1
    history->Belt.List.add(banks')
  } else {
    cycle(history->Belt.List.add(banks'))
  }
}

let input = [11, 11, 13, 7, 0, 15, 5, 5, 4, 4, 1, 1, 7, 1, 15, 11]
let history0 = list{input}

// part 1
cycle(history0)->Js.log

// part 2
let history = cycle(history0)
let target = Belt.List.headExn(history)
let history = Belt.List.tailExn(history)

history->Belt.List.toArray->Js.Array.findIndex(a => a == target, _)->Js.log

/*

배운 것
  - ref의 사용 법
  - mutable array의 사용법
  - index 기반으로 array 처리하기
*/
