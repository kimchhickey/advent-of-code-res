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
  readInputLines("Day5")
  ->Belt.List.reduceWithIndex(
      MemoryMap.empty,
      (map, value, index) => MemoryMap.set(map, index, int_of_string(value)))
}

let program0 = Init({
  ip: 0,
  step: 0,
  mem: mem0(),
})

// run program
run(program0)->Js.log