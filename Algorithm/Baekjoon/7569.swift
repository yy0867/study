import Foundation

func solution(_ fields: [[[Int]]]) -> Int {
    var queue = Queue()
    var field = fields
    var visited = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: field[0][0].count), count: field[0].count), count: field.count)
    var zero = 0
    let dir = [-1, 0, 1, 0, -1]
    let heightDir = [-1, 1]
    for h in 0..<field.count {
        for i in 0..<field[0].count {
            for j in 0..<field[0][0].count {
                if field[h][i][j] == 1 {
                    queue.push((h, i, j))
                } else if field[h][i][j] == 0 {
                    zero += 1
                }
            }
        }
    }
    if zero == 0 { return 0 }

    func isValidCoord(_ coord: Coord) -> Bool {
        let h = coord.h, r = coord.r, c = coord.c
        if h < 0 || h >= field.count || r < 0 || r >= field[0].count || c < 0 || c >= field[0][0].count || field[h][r][c] == -1 { return false }
        return !visited[h][r][c]
    }

    while !queue.isEmpty {
        let node = queue.pop()
        if !isValidCoord(node) { continue }
        visited[node.h][node.r][node.c] = true

        // same floor
        for i in 0...3 {
            let nextR = node.r + dir[i], nextC = node.c + dir[i + 1]
            if !isValidCoord((node.h, nextR, nextC)) || field[node.h][nextR][nextC] > 0 { continue }
            queue.push((node.h, nextR, nextC))
            field[node.h][nextR][nextC] = (field[node.h][node.r][node.c] + 1)
        }
        
        // different floor
        for d in heightDir {
            let nextH = node.h + d
            if !isValidCoord((nextH, node.r, node.c)) || field[nextH][node.r][node.c] > 0 { continue }
            queue.push((nextH, node.r, node.c))
            field[nextH][node.r][node.c] = (field[node.h][node.r][node.c] + 1)
        }
    }

    var max = -1
    for h in field {
        for i in h {
            for j in i {
                if j == 0 { return -1 }
                max = j > max ? j : max
            }
        }
    }

    return max - 1
}

let mnh = readLine()!.split(separator: " ").map { Int(String($0))! }
let m = mnh[0], n = mnh[1], h = mnh[2]

var field = [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: m), count: n), count: h)

for height in 0..<h {
    for r in 0..<n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        field[height][r] = row
    }
}

print(solution(field))

// Queue
typealias Coord = (h: Int, r: Int, c: Int)

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
        return v
    }
}