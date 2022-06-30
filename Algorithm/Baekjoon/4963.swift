import Foundation

func solution(_ field: [[Bool]]) -> Int {
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: field[0].count), count: field.count)
    var count = 0
    var queue = [(Int, Int)]()
    let diag = [1, 1, -1, -1, 1]
    let dir = [1, 0, -1, 0, 1]

    for i in 0..<field.count {
        for j in 0..<field[0].count {
            if !field[i][j] || visited[i][j] { continue }
            queue.append((i, j))
            count += 1
            while !queue.isEmpty {
                let node = queue.removeLast()
                visited[node.0][node.1] = true
                for i in 0...3 {
                    let nextR = node.0 + dir[i], nextC = node.1 + dir[i + 1]
                    if nextR < 0 || nextR >= field.count || nextC < 0 || nextC >= field[0].count { continue }
                    if !field[nextR][nextC] || visited[nextR][nextC] { continue }
                    queue.append((nextR, nextC))
                }
                for i in 0...3 {
                    let nextR = node.0 + diag[i], nextC = node.1 + diag[i + 1]
                    if nextR < 0 || nextR >= field.count || nextC < 0 || nextC >= field[0].count { continue }
                    if !field[nextR][nextC] || visited[nextR][nextC] { continue }
                    queue.append((nextR, nextC))
                }
            }
        }
    }

    return count
}

var answer = [Int]()
while true {
    let wh = readLine()!.split(separator: " ").map { Int(String($0))! }
    if wh[0] == 0 && wh[1] == 0 { break }

    var field = [[Bool]]()
    for _ in 0..<wh[1] {
        let row = readLine()!.split(separator: " ").map { $0 == "1" }
        field.append(row)
    }
    answer.append(solution(field))
}

for ans in answer {
    print(ans)
}