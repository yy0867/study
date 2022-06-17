import Foundation

func solution(_ n: Int, _ scores: [Int]) -> Int {
    if n == 1 { return scores[0] }
    else if n == 2 { return scores[0] + scores[1] }

    var p = [[Int]](repeating: [Int](repeating: 0, count: n + 2), count: n)
    p[0][1] = scores[0]
    p[0][2] = scores[1]
    p[1][2] = p[0][1] + scores[1]
    p[1][3] = p[0][1] + scores[2]

    for i in 2..<n {
        p[i][i + 1] = p[i - 2][i] + scores[i]
        p[i][i + 2] = max(p[i - 2][i], p[i - 1][i]) + scores[i + 1]
    }

    return max(p[n - 2][n], p[n - 1][n])
}

let n = Int(readLine()!)!
var scores = [Int]()
for _ in 0..<n {
    let input = Int(readLine()!)!
    scores.append(input)
}
scores.append(0)
print(solution(n, scores))