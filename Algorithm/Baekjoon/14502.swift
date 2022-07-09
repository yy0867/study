import Foundation

func calcSafeArea(_ field: [[Int]], _ viruses: [Coord]) -> Int {
    var queue = Queue()
    let dir = [-1, 0, 1, 0, -1]
    var field = field

    for virus in viruses {
        queue.push(virus)
    }

    while !queue.isEmpty {
        let coord = queue.pop()

        for i in 0...3 {
            let nextR = coord.r + dir[i], nextC = coord.c + dir[i + 1]
            if nextR < 0 || nextR >= field.count || nextC < 0 || nextC >= field[0].count { continue }
            if field[nextR][nextC] != empty { continue }
            queue.push((nextR, nextC))
            field[nextR][nextC] = virus
        }
    }

    var result = 0
    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if field[i][j] == empty { result += 1 }
        }
    }
    return result
}

func solution(_ field: [[Int]]) -> Int {
    var maxEmpty = -1
    var mutableField = field
    var viruses = [Coord]()

    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if field[i][j] == virus {
                viruses.append((i, j))
            }
        }
    }

    func makeWall(_ count: Int, _ r: Int, _ c: Int) {
        if count == 3 { 
            let safeArea = calcSafeArea(mutableField, viruses)
            maxEmpty = safeArea > maxEmpty ? safeArea : maxEmpty

            // print("## safe: \(safeArea) ##")
            // for row in mutableField {
            //     print(row)
            // }
            return
        }

        for i in r..<mutableField.count {
            for j in 0..<mutableField[0].count {
                if i == r && j < c { continue }
                if mutableField[i][j] == empty {
                    mutableField[i][j] = wall
                    makeWall(count + 1, i, j)
                    mutableField[i][j] = empty
                }
            }
        }
    }

    makeWall(0, 0, 0)

    return maxEmpty
}

let empty = 0, wall = 1, virus = 2
let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0], m = nm[1]
var field = [[Int]]()
for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int(String($0))! }
    field.append(row)
}

print(solution(field))

// Queue
typealias Coord = (r: Int, c: Int)

struct Queue {
    var queue = [Coord]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

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