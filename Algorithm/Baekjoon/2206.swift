import Foundation

func solution(_ n: Int, _ m: Int, _ field: [[Bool]]) -> Int {
    var queue = Queue()
    var visited = [[[Bool]]](repeating: [[Bool]](repeating: [Bool](repeating: false, count: m), count: n), count: 2)
    let dir = [-1, 0, 1, 0, -1]
    var minCount = 99999999999

    queue.push((0, 0, 1, false))
    while !queue.isEmpty {
        let node = queue.pop()

        if visited[node.isDestroyed ? 0 : 1][node.r][node.c] { continue }
        visited[node.isDestroyed ? 0 : 1][node.r][node.c] = true

        if node.r == n - 1 && node.c == m - 1 {
            minCount = node.count < minCount ? node.count : minCount
        }

        for i in 0...3 {
            let nextR = node.r + dir[i], nextC = node.c + dir[i + 1]
            
            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= m { continue }

            if !field[nextR][nextC] { 
                if node.isDestroyed { continue }
                else { queue.push((nextR, nextC, node.count + 1, true)) }
            } else {
                queue.push((nextR, nextC, node.count + 1, node.isDestroyed))
            }
        }
    }

    return minCount == 99999999999 ? -1 : minCount
}

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0], m = nm[1]
var field = [[Bool]]()
for _ in 0..<n {
    let row = readLine()!.map { Int(String($0))! == 0 ? true : false }
    field.append(row)
}
print(solution(n, m, field))

// Queue
typealias Coord = (r: Int, c: Int, count: Int, isDestroyed: Bool)

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

        if head >= 10000 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}