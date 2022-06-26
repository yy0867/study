import Foundation

func solution(_ field: [[Bool]]) -> Int {
    var visited = [Bool](repeating: false, count: field.count)
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

    dfs(1)

    return result.count - 1
}

let n = Int(readLine()!)!
let m = Int(readLine()!)!
var field = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: n + 1)
for _ in 0..<m { 
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    field[input[0]][input[1]] = true
    field[input[1]][input[0]] = true
}

print(solution(field))