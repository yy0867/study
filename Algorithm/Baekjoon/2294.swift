import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]
let coins = (0..<n).map { _ in Int(readLine()!)! }

func solution(_ n: Int, _ k: Int, _ coins: [Int]) -> Int {
    var p = [Int](repeating: 987654321, count: k + 1)
    p[0] = 0

    for coin in coins {
        if coin > k { continue }
        for i in coin...k {
            p[i] = min(p[i], p[i - coin] + 1)
        }
    }

    if p[k] == 987654321 {
        return -1
    }
    return p[k]
}

print(solution(n, k, coins))