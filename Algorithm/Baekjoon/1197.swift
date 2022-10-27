import Foundation

typealias Edge = (Int, Int, Int)

let ve = readLine()!.components(separatedBy: " ").map { Int($0)! }
let v = ve[0], e = ve[1]
var edges = [Edge]()
var parent = [0]

for i in 1...v {
    parent.append(i)
}

for _ in 0..<e {
    let row = readLine()!.components(separatedBy: " ").map { Int($0)! }
    edges.append((row[0], row[1], row[2]))
}

func findRoot(_ v: Int) -> Int {
    if parent[v] == v { return v }
    parent[v] = findRoot(parent[v])
    return parent[v]
}

func unionRoot(_ v1: Int, _ v2: Int) {
    let p1 = findRoot(v1)
    let p2 = findRoot(v2)

    if p1 != p2 {
        parent[p1] = p2
    }
}

func solution(_ edges: [Edge]) -> Int {
    let sortedEdges = edges.sorted { $0.2 < $1.2 }
    var mst = [Edge]()

    for (start, end, cost) in sortedEdges {
        if findRoot(start) == findRoot(end) {
            continue 
        }

        mst.append((start, end, cost))
        unionRoot(start, end)

        if mst.count == v - 1 { break }
    }

    return mst.reduce(0, { $0 + $1.2 })
}

print(solution(edges))