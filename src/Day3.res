type coord = {
  x: int,
  y: int
}

type data = {
  coord: coord,
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

let getDistance = (c1, c2) => {
  let dx = float_of_int(c2.x - c1.x)
  let dy = float_of_int(c2.y - c1.y)
  sqrt(dx ** 2.0 +. dy ** 2.0)
}

let valueOfpart1 = v => v + 1

let valueOfpart2 = (pos, l) => {
  let isNeighbor = v => {
    getDistance(pos, v.coord) < 1.5  
  }
  let x = Belt.List.keep(l, isNeighbor)
  x->Js.log
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

  let value' = valueOfpart2(pos', l)
  let data' = {coord: pos', value: value'}

  (data', d2, l->Belt.List.add(data'))
}

let target = 325489
let d1 = {coord: {x: 0, y: 0}, value: 1}
let d2 = {coord: {x: 1, y: 0}, value: 1}
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

find((d2, d1, square))->Js.log
