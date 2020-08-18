/*
* Coordinate
*/

type coord = {
  x: int,
  y: int
}

// Direction Operations
let findDirection = (c2: coord, c1: coord) => {x: c2.x - c1.x, y: c2.y - c1.y}
let leftDirection = ({x, y}: coord) => {x: -y, y: x}

// Moving Operations
let move = (pos: coord, direction: coord) => {x: pos.x + direction.x, y: pos.y + direction.y}
let goStraight = move;
let turnLeft = (pos: coord, direction: coord) => move(pos, leftDirection(direction))

// Distance
let getDistance = (c1, c2) => {
  let dx = float_of_int(c2.x - c1.x)
  let dy = float_of_int(c2.y - c1.y)
  sqrt(dx ** 2.0 +. dy ** 2.0)
}

/*
 *  Square System
 */ 
type data = {
  coord: coord,
  value: int
}

let exist = (pos: coord, l) => {
  l->Belt.List.some((value) => pos.x == value.coord.x && pos.y == value.coord.y)
}

let nextPos = l => {
  let list{d2, d1, ...tail} = l
  let dir = findDirection(d2.coord, d1.coord)

  if !exist(turnLeft(d2.coord, dir), l) {
    turnLeft(d2.coord, dir)
  } else {
    goStraight(d2.coord, dir)
  }
}

let nextValue = (f, pos, l) => {
  f(pos, l)
}

let next = ((l, f)) => {
  let pos' = nextPos(l);
  let value' = nextValue(f, pos', l)
  (l->Belt.List.add({coord: pos', value: value'}), f)
}

// Find 
let rec find = ((spiralMemory, f), target) => {
  let list{head, ...tail} = spiralMemory

  if (head.value >= target) {
    head
  } else {
    find(next((spiralMemory, f)), target)
  }
}

let makeSpiralMemory = (d1, d2, f) => {
  (list{d2, d1}, f)
}

// Value Calculations
let sumAround = (pos, l) => {
  let isNeighbor = v => {
    getDistance(pos, v.coord) < 1.5
  }
  Belt.List.keep(l, isNeighbor)
  ->Belt.List.map(v=> v.value)
  ->Belt.List.reduce(0, (acc, itm) => acc + itm)
}

let incLastValue = (pos, l) => {
  let list{head, ...tail} = l
  head.value + 1
}

// part 1
makeSpiralMemory(
  {coord: {x: 0, y: 0}, value: 1},
  {coord: {x: 1, y: 0}, value: 2},
  incLastValue)
->find(325489)->Js.log

// part 2
makeSpiralMemory(
  {coord: {x: 0, y: 0}, value: 1},
  {coord: {x: 1, y: 0}, value: 1},
  sumAround)
->find(325489)->Js.log
