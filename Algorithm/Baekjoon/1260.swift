import Foundation

func forDFS(_ start: Int, _ n: Int, _ field: [[Bool]]) -> [Int] {
    var visited = [Bool](repeating: false, count: n + 1)
    var result = [Int]()

    func dfs(_ node: Int) {
        if visited[node] { return }
        visited[node] = true
        result.append(node)

        for (i, dest) in field[node].enumerated() {
            if !dest { continue }
            dfs(i)
        }
    }

    dfs(start)

    return result
}

func forBFS(_ start: Int, _ n: Int, _ field: [[Bool]]) -> [Int] {
    var visited = [Bool](repeating: false, count: n + 1)
    var result = [Int]()
    var queue = Queue()

    func bfs(_ node: Int) {
        queue.push(node)
        visited[node] = true
        while !queue.isEmpty {
            let curNode = queue.pop()
            result.append(curNode)
            for (i, dest) in field[curNode].enumerated() {
                if !dest || visited[i] { continue }
                visited[i] = true
                queue.push(i)
            }
        }
    }

    bfs(start)

    return result
}

var inputs = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = inputs[0], m = inputs[1], v = inputs[2]
var field = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: n + 1)
for _ in 0..<m {
    inputs = readLine()!.split(separator: " ").map { Int(String($0))! }
    field[inputs[0]][inputs[1]] = true
    field[inputs[1]][inputs[0]] = true
}

let dfs = forDFS(v, n, field).map { String($0) }.joined(separator: " ")
let bfs = forBFS(v, n, field).map { String($0) }.joined(separator: " ")

print(dfs)
print(bfs)

// Queue
struct Queue {
    var head = 0
    var queue = [Int]()

    var isEmpty: Bool { head == queue.count }

    mutating func pop() -> Int {
        let value = queue[head]
        head += 1
        return value
    }

    mutating func push(_ element: Int) {
        queue.append(element)
    }
}