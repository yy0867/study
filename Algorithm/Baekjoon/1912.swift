import Foundation

let n = Int(readLine()!)!
let seq = readLine()!.split(separator: " ").map { Int($0)! }

func solution(_ n: Int, _ seq: [Int]) -> Int {
    if n == 1 { return seq.first! }

    var p = [Int](repeating: -999999999, count: n + 1)
    p[0] = seq[0]

    for i in 1..<n {
        p[i] = max(seq[i], p[i - 1] + seq[i])
    }

    return p.max()!
}

print(solution(n, seq))