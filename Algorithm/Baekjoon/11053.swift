import Foundation

func solution(_ n: Int, _ sequence: [Int]) -> Int {
    var p = [Int](repeating: 1, count: n)
    p[0] = 1

    for i in 0..<n {
        for j in 0..<i {
            if sequence[i] > sequence[j] {
                p[i] = max(p[i], p[j] + 1)
            }
        }
    }

    return p.max()!
}

let n = Int(readLine()!)!
let sequence = readLine()!.components(separatedBy: " ").map { Int($0)! }

print(solution(n, sequence))