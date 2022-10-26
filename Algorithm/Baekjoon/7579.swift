import Foundation

let nm = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
let memories = [0] + readLine()!.components(separatedBy: " ").map { Int($0)! }
let costs = [0] + readLine()!.components(separatedBy: " ").map { Int($0)! }
let sum = costs.reduce(0, +)
var dp = [[Int]](repeating: [Int](repeating: 0, count: sum + 1), count: n + 1)

for i in 1...n {
    for j in 0...sum {
        if j - costs[i] >= 0 {
            dp[i][j] = max(dp[i][j], dp[i - 1][j - costs[i]] + memories[i])
        }

        dp[i][j] = max(dp[i][j], dp[i - 1][j])
    }
}

for i in 0...sum {
    if dp[n][i] >= m {
        print(i)
        break
    }
}