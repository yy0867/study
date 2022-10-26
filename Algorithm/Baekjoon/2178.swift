import Foundation

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
var field = [[Bool]]()

for _ in 0..<n {
    let row = readLine()!.map { $0 == "1" ? true : false }
    field.append(row)
}

func solution(_ field: [[Bool]]) -> Int {
    var queue = Queue()
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: m), count: n)
    let dir = [1, 0, -1, 0, 1]
    queue.push((0, 0, 1))

    while !queue.isEmpty {
        let next = queue.pop()
        let r = next.0, c = next.1

        if r == n - 1 && c == m - 1 { return next.2 }

        if visited[r][c] || !field[r][c] { continue }
        visited[r][c] = true

        for d in 0...3 {
            let nextR = r + dir[d], nextC = c + dir[d + 1]
            
            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= m { continue }
            queue.push((nextR, nextC, next.2 + 1))
        }
    }

    return 0
}

print(solution(field))

struct Queue {
    var queue = [(Int, Int, Int)]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: (Int, Int, Int)) {
        queue.append(element)
    }

    mutating func pop() -> (Int, Int, Int) {
        let v = queue[head]
        head += 1

        if head > 1000 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}