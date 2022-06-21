import Foundation

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nm[0], m = nm[1]
var table = [[Int]]()
for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int(String($0))! }
    table.append(row)
}

var p = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: n + 1)

for i in 1...n {
    for j in 1...n {
        p[i][j] = p[i][j - 1] + p[i - 1][j] + table[i - 1][j - 1] - p[i - 1][j - 1]
    }
}

var answer = [Int]()

for _ in 0..<m {
    let req = readLine()!.split(separator: " ").map { Int(String($0))! }
    let x1 = req[0], y1 = req[1], x2 = req[2], y2 = req[3]
    let sum = p[x2][y2] - p[x2][y1 - 1] - p[x1 - 1][y2] + p[x1 - 1][y1 - 1]
    answer.append(sum)
}

for r in answer { print(r) }