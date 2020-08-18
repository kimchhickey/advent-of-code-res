open Util

module MemoryMap = Belt.Map.Int;

type state = {
  ip: int               // instruction pointer
  step: int 
  mem: MemoryMap.t<int> // memory
}

type program =
| Init(state)
| Running(state)
| Stopped(state)

let rec run = program => {
  switch (program) {
    | Init(state) => run(Running(state))
    | Running({ip, step, mem}) => {
      switch MemoryMap.get(mem, ip) {
        | None => run(Stopped({ip, step, mem}))
        | Some(n) => {
          // let mem' = MemoryMap.set(mem, ip, n + 1) // part 1
          let mem' = n >= 3 ? MemoryMap.set(mem, ip, n - 1) : MemoryMap.set(mem, ip, n + 1) // part 2
          let state' = {
            ip: ip + n,
            step: step + 1
            mem: mem'
          }
          run(Running(state'))
        }
      }
    }
    | Stopped(state) => state.step
  }
}

let mem0 = () => {
  let input = readInputLines("Day5")->Belt.List.map(int_of_string);     // -> list{0, 0, 0, 2...}
  let indexes = Belt.List.makeBy(Belt.List.size(input), i => i)         // -> list{0, 1, 2, 3, 4}
  MemoryMap.fromArray(Belt.List.toArray(Belt.List.zip(indexes, input))) // -> Belt.Map.Int.fromArray([(0, 0), (1, 0), ...],
}

let state0 = {
  ip: 0,
  step: 0
  mem: mem0(),
}

// run program
run(Init(state0))->Js.log