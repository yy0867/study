import Foundation

func solution(_ sequence: [Int]) -> Int {
    var p = [Int](repeating: 1, count: sequence.count)

    let reversed = Array(sequence.reversed())
    for i in 0..<reversed.count {
        for j in 0..<i {
            if reversed[i] > reversed[j] {
                p[i] = max(p[i], p[j] + 1)
            }
        }
    }

    return p.max()!
}

let n = Int(readLine()!)!
let sequence = readLine()!.split(separator: " ").map { Int(String($0))! }

print(solution(sequence))