import Foundation

let nk = readLine()!.split(separator: " ").map { Int($0)! }
let n = nk[0], k = nk[1]
var coins = [Int]()

for _ in 0..<n {
    coins.append(Int(readLine()!)!)
}

var p = [Int](repeating: 0, count: k + 1)
p[0] = 1

for coin in coins {
    for j in 0...k {
        if j - coin >= 0 {
            p[j] += p[j - coin]
            if p[j] > Int64(pow(2.0, 31.0)) { p[j] = 0 }
        }
    }
}

print(p[k])