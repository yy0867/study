import Foundation

let n = Int(readLine()!)!
let m = Int(readLine()!)!
let INF = 999999999
var edges = [[Int]](repeating: [Int](repeating: INF, count : n + 1), count: n + 1)

for _ in 0..<m {
    let row = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let start = row[0], end = row[1], cost = row[2]
    if edges[start][end] > cost {
        edges[start][end] = cost
    }
}

func solution() {
    for node in 1...n {
        for i in 1...n {
            for j in 1...n {
                edges[i][j] = min(edges[i][j], edges[i][node] + edges[node][j])
            }
        }
    }
}

solution()

for i in 1..<edges.count {
    for j in 1..<edges[i].count {
        if edges[i][j] == INF || i == j { print("0", terminator: " ")}
        else { print("\(edges[i][j])", terminator: " ")}
    }
    print()
}