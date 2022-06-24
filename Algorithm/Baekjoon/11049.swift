import Foundation

func solution(_ matrices: [[Int]]) -> Int {
    var p = [[Int]](repeating: [Int](repeating: 0, count: matrices.count + 1), count: matrices.count + 1)

    for i in 1..<matrices.count {
        for j in 1...(matrices.count - i) {
            p[j][i + j] = 9999999999
            for k in j..<(i + j) {
                p[j][i + j] = min(p[j][i + j], p[j][k] + p[k + 1][i + j] + (matrices[j - 1][0] * matrices[k - 1][1] * matrices[i + j - 1][1]))
            }
        }
    }

    return p[1][matrices.count]
}

let n = Int(readLine()!)!
var matrices = [[Int]]()
for _ in 0..<n {
    let matrix = readLine()!.split(separator: " ").map { Int(String($0))! }
    matrices.append([matrix[0], matrix[1]])
}

print(solution(matrices))