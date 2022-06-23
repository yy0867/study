import Foundation

func solution(_ testcases: [[Int]]) -> [Int] {
    var answer = [Int]()
    for chapters in testcases {
        var sum = [Int](repeating: 0, count: chapters.count + 1)
        var p = [[Int]](repeating: [Int](repeating: 0, count: chapters.count + 1), count: chapters.count + 1)
        for i in 1...chapters.count { sum[i] = sum[i - 1] + chapters[i - 1] }

        for i in 1..<chapters.count {
            for j in 1...(chapters.count - i) {
                p[j][i + j] = 999999999
                for k in j..<(i + j) {
                    p[j][i + j] = min(p[j][i + j], p[j][k] + p[k + 1][i + j] + sum[i + j] - sum[j - 1])
                }
            }
        }

        answer.append(p[1][chapters.count])
    }
    return answer
}

let t = Int(readLine()!)!
var chapters = [[Int]]()
for _ in 0..<t {
    let _ = Int(readLine()!)!
    chapters.append(readLine()!.split(separator: " ").map { Int(String($0))! })
}

let result = solution(chapters)
for r in result {
    print(r)
}