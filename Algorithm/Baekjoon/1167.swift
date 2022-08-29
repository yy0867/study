import Foundation

func farthest(from node: Int) -> (node: Int, dist: Int) {
    var farNode = 0
    var maxDist = 0

    visited = [Bool](repeating: false, count: n + 1)

    func dfs(_ cur: Int, _ dist: Int) {
        if visited[cur] { return }
        if dist > maxDist {
            maxDist = dist
            farNode = cur
        }

        visited[cur] = true

        for next in graph[cur]! where next.value != 0 && !visited[next.key] {
            dfs(next.key, dist + next.value)
        }
    }

    dfs(node, 0)

    return (farNode, maxDist)
}

func solution() -> Int {
    let lastNode = farthest(from: 1)
    let radius = farthest(from: lastNode.node)

    return radius.dist
}

let n = Int(readLine()!)!
var graph = [Int: [Int: Int]]()
var visited = [Bool](repeating: false, count: n + 1)
for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    let node = row[0]
    var input = [Int: Int]()

    for i in stride(from: 1, to: row.count, by: 2) where row[i] != -1 {
        input[row[i]] = row[i + 1]
    }

    graph.updateValue(input, forKey: node)
}

print(solution())