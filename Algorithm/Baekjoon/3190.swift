import Foundation

typealias Coord = (r: Int, c: Int)
typealias Move = (t: Int, dir: String)
let left = "L", right = "D"

func solution(_ n: Int, _ apples: [Coord], _ moves: [Move]) -> Int {
    let none = 0, body = 1, apple = 2

    var snake = Queue()
    var field = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)
    let dir = [0, 1, 0, -1, 0] // 0: right, 1: down, 2: left, 3: up
    var dirIndex = 0 // left -> (dirIndex + 3) % 4, right -> (dirIndex + 1) % 4
    var t = 0
    var nextMoveIndex = 0

    for appleCoord in apples {
        field[appleCoord.r][appleCoord.c] = apple
    }
    
    snake.push((1, 1))
    field[1][1] = body

    while true {
        t += 1
        let nextR = snake.front.r + dir[dirIndex], nextC = snake.front.c + dir[dirIndex + 1]
        
        // touch wall or body -> finish
        if nextR < 1 || nextR > n || nextC < 1 || nextC > n || field[nextR][nextC] == body { break }
        
        if field[nextR][nextC] != apple { // if not apple, remove tail and body
            let tail = snake.pop()
            field[tail.r][tail.c] = none
        }
        // add (nextR, nextC)
        snake.push((nextR, nextC))
        field[nextR][nextC] = body

        if nextMoveIndex < moves.count && t == moves[nextMoveIndex].t {
            if moves[nextMoveIndex].dir == left {
                dirIndex = (dirIndex + 3) % 4
            } else {
                dirIndex = (dirIndex + 1) % 4
            }
            nextMoveIndex += 1
        }
    }

    return t
}

let n = Int(readLine()!)!
let k = Int(readLine()!)!
var apples = [Coord]()
for _ in 0..<k {
    let rc = readLine()!.split(separator: " ").map { Int(String($0))! }
    apples.append((rc[0], rc[1]))
}
var moves = [Move]()
let l = Int(readLine()!)!
for _ in 0..<l {
    let move = readLine()!.split(separator: " ").map { String($0) }
    moves.append((Int(move[0])!, move[1]))
}
print(solution(n, apples, moves))

// Queue
struct Queue {
    var queue = [Coord]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }
    var front: Coord { queue.last! }
    var tail: Coord { queue[head] }

    mutating func push(_ element: Coord) {
        queue.append(element)
    }

    mutating func pop() -> Coord {
        let v = queue[head]
        head += 1
        if head > 1000 {
            queue.removeFirst(head)
            head = 0
        }
        return v
    }
}