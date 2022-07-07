import Foundation

func getLargestSequence(_ sequence: [Int]) -> [Int] {
    var p = [Int](repeating: 1, count: sequence.count)
    p[0] = 1

    for i in 0..<sequence.count {
        for j in 0..<i {
            if sequence[i] > sequence[j] {
                p[i] = max(p[i], p[j] + 1)
            }
        }
    }

    return p
}

func solution(_ sequence: [Int]) -> Int {
    let increase = getLargestSequence(sequence)
    let decrease = Array(getLargestSequence(Array(sequence.reversed())).reversed())

    var max = -1
    for i in 0..<increase.count {
        let sum = increase[i] + decrease[i]
        max = sum > max ? sum : max
    }

    return max - 1
}

let n = Int(readLine()!)
let sequence = readLine()!.split(separator: " ").map { Int(String($0))! }

print(solution(sequence))