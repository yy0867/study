import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var buses = [[(end: Int, value: Int)]](repeating: [], count: n + 1)
for _ in 0..<m {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    buses[row[0]].append((row[1], row[2]))
}

let se = readLine()!.split(separator: " ").map { Int($0)! }
let start = se[0], end = se[1]

var visited = [Bool](repeating: false, count: n + 1)
var graph = [Int](repeating: Int.max, count: n + 1)
visited[0] = true
graph[start] = 0

func solution(_ node: Int) {
    if node == end { return }

    visited[node] = true

    for (end, value) in buses[node] {
        graph[end] = min(graph[end], graph[node] + value)
    }

    let next = graph.enumerated()
        .filter { !visited[$0.offset] }
        .min(by: { $0.element < $1.element })!.offset

    solution(next)
}

solution(start)

print(graph[end])