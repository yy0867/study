import Foundation

func solution(_ n: Int, _ k: Int, _ subjects: [[Int]]) -> Int {
    let sortedSubjects = subjects.sorted { $0[0] < $1[0] }
    var p = [[Int]](repeating: [Int](repeating: 0, count: k + 1), count: n + 1)
    let weight = 0, value = 1

    for i in 1...n {
        let curWeight = sortedSubjects[i - 1][weight]
        let curValue = sortedSubjects[i - 1][value]

        for j in 1...k {
            if j - curWeight >= 0 {
                p[i][j] = max(p[i - 1][j], p[i - 1][j - curWeight] + curValue)
            } else {
                p[i][j] = p[i - 1][j]
            }
        }
    }

    return p[n][k]
}

let input = readLine()!.components(separatedBy: " ").map { Int($0)! }
let n = input[0], k = input[1]
var subjects = [[Int]]()
for _ in 0..<n {
    let subject = readLine()!.components(separatedBy: " ").map { Int($0)! }
    subjects.append(subject)
}

print(solution(n, k, subjects))