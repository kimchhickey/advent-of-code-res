type coord = {
  x: int,
  y: int
}

type data = {
  coord: coord
  value: int
}

let findDirection = (d2: data, d1: data) => {
  let direction = {
    x: d2.coord.x - d1.coord.x,
    y: d2.coord.y - d1.coord.y
  }
  direction
}

let leftDirection = ({x, y}: coord) => {x: -y, y: x}

let hasData = (pos': coord, l) => {
  let pred = value => {
    pos'.x == value.coord.x && pos'.y == value.coord.y
  }

  if l->Belt.List.some(pred) {
    true
  } else {
    false
  }
}

let valueOfpart1 = v => v + 1

let valueOfpart2 = (pos, l) => {
  let isNeighbor = v => {
    (pos.x == (v.coord.x + 1)
      || pos.x == (v.coord.x - 1)
      || pos.y == (v.coord.y + 1)
      || pos.y == (v.coord.y - 1))
  }
  let x = Belt.List.keep(l, isNeighbor)
  x->Belt.List.reduce(0, (acc, item) => acc + item.value)
}

let go = (pos, direction) => {
  {x: pos.x + direction.x,
   y: pos.y + direction.y}
}

let goStraight = go;
let turnLeft = (pos, direction) => {
  go(pos, leftDirection(direction))
}

let next = ((d2: data, d1: data, l: list<data>)) => {
  let direction = findDirection(d2, d1)
  let pos' = 
    if !hasData(turnLeft(d2.coord, direction), l) {
      turnLeft(d2.coord, direction)
    } else {
      goStraight(d2.coord, direction)
    }

  let value' = valueOfpart1(d2.value);
  let data' = {coord: pos', value: value'}

  (data', d2, l->Belt.List.add(data'))
}

// let target = 325489
let target = 1024
let d1 = {coord: {x: 0, y: 0}, value: 1}
let d2 = {coord: {x: 1, y: 0}, value: 2}
let square = list{d2, d1}

let rec find = ((d2, d1, square)) => {
  if (d2.value >= target) {
    Js.log(d2.value)
    (d2, d1, square)
  } else {
    Js.log(d2.value)
    find(next((d2, d1, square)))
  }
}

// find((d2, d1, square))->Js.log

//next(next(next((d2, d1, square))))->Js.log

next(next((d2, d1, square)))->Js.log