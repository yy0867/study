import Foundation


typealias Coord = (r: Int, c: Int)


func solution(_ fields: [[Int]]) -> Int {
    var queue = Queue<Coord>()
    var field = fields
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: field[0].count), count: field.count)
    let dir = [-1, 0, 1, 0, -1]
    
    var zero = 0
    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if field[i][j] == 1 { 
                queue.push((i, j))
            } else if field[i][j] == 0 {
                zero += 1
            }
        }
    }
    if zero == 0 { return 0 }

    func isValidCoord(_ coord: Coord) -> Bool {
        let r = coord.r, c = coord.c
        if r < 0 || r >= field.count || c < 0 || c >= field[0].count || field[r][c] == -1 { return false }
        return !visited[r][c]
    }

    while !queue.isEmpty {
        let curCoord = queue.pop()
        if !isValidCoord(curCoord) { continue }
        visited[curCoord.r][curCoord.c] = true

        for i in 0...3 {
            let nextR = curCoord.r + dir[i], nextC = curCoord.c + dir[i + 1]
            if !isValidCoord((nextR, nextC)) || field[nextR][nextC] > 0 { continue }

            queue.push((nextR, nextC))
            field[nextR][nextC] = (field[curCoord.r][curCoord.c] + 1)
        }
    }

    var max = -1
    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if field[i][j] == 0 { return -1 }
            else if field[i][j] == -1 { continue }
            max = field[i][j] > max ? field[i][j] : max
        }
    }

    return max - 1
}

let mn = readLine()!.split(separator: " ").map { Int(String($0))! }
var field = [[Int]]()
for _ in 0..<mn[1] {
    let row = readLine()!.split(separator: " ").map { Int(String($0))! }
    field.append(row)
}

print(solution(field))

// Queue
struct Queue<T> {
    var queue = [T]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func pop() -> T {
        let value = queue[head]
        head += 1
        return value
    }

    mutating func push(_ element: T) {
        queue.append(element)
    }
}