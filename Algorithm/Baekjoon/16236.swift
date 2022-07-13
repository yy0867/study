import Foundation

func solution(_ n: Int, _ field: [[Int]]) -> Int {
    let dir = [-1, 0, 1, 0, -1]
    var mutableField = field
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var dest = [(r: Int, c: Int, dist: Int)]()
    var queue = Queue<(r: Int, c: Int, t: Int, dist: Int)>()
    var sharkSize = 2
    var curEat = 0
    var answer = 0

    func initVisited() {
        visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    }

    func findShark() -> (r: Int, c: Int) {
        for i in 0..<n {
            for j in 0..<n {
                if field[i][j] == 9 { return (i, j) }
            }
        }
        return (0, 0)
    }
    let start = findShark()
    queue.push((start.r, start.c, 0, 0))

    while !queue.isEmpty {
        initVisited()
        dest.removeAll()

        while !queue.isEmpty {
            let node = queue.pop()
            if visited[node.r][node.c] { continue }
            visited[node.r][node.c] = true

            if mutableField[node.r][node.c] != 9 && mutableField[node.r][node.c] != 0 {
                // if size is bigger, cannot go
                if sharkSize < mutableField[node.r][node.c] { continue }
                // if size is smaller, can eat
                else if sharkSize > mutableField[node.r][node.c] {
                    dest.append((node.r, node.c, node.dist))
                }
            }

            for i in 0...3 {
                let nextR = node.r + dir[i], nextC = node.c + dir[i + 1]
                if nextR < 0 || nextR >= n || nextC < 0 || nextC >= n || visited[nextR][nextC] { continue }
                queue.push((nextR, nextC, node.t + 1, node.dist + 1))
            }
        }
        if dest.isEmpty { break }
        let target = dest.sorted { lhs, rhs in
            if lhs.dist == rhs.dist {
                if lhs.r == rhs.r {
                    return lhs.c < rhs.c
                }
                return lhs.r < rhs.r
            } else {
                return lhs.dist < rhs.dist
            }
        }.first!
        answer += target.dist
        queue.push((target.r, target.c, answer, 0))
        curEat += 1
        if curEat == sharkSize {
            curEat = 0
            sharkSize += 1
        }
        mutableField[target.r][target.c] = 0
    }

    return answer
}

let n = Int(readLine()!)!
var field = [[Int]]()
for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int(String($0))! }
    field.append(row)
}
print(solution(n, field))

// Queue
struct Queue<T> {
    var queue = [T]()
    var head = 0
    var isEmpty: Bool { head >= queue.count }

    mutating func push(_ element: T) {
        queue.append(element)
    }

    mutating func pop() -> T {
        let v = queue[head]
        head += 1

        if head > 1000 {
            queue.removeFirst(head)
            head = 0
        }

        return v
    }
}