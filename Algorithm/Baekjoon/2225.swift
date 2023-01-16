import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]

var p = [[Int]](repeating: [Int](repeating: 0, count: n + 1), count: k + 1)
for i in 0...k {
    p[i][0] = 1
}
for i in 0...n {
    p[0][i] = 1
}

for i in 1...k {
    for j in 1...n {
        p[i][j] = (p[i - 1][j] + p[i][j - 1]) % 1000000000
    }
}

print(p[k - 1][n])