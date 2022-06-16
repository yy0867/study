import Foundation

let t = Int(readLine()!)!

for _ in 0..<t {
    let input = readLine()!.components(separatedBy: " ")
    let n = Int(input[0])!, m = Int(input[1])!
    if n == 1 {
        print(m)
        continue
    }

    var p = [[Int]](repeating: [Int](repeating: 0, count: m + 1), count: n + 1)

    for j in 1...m {
        p[1][j] = j
    }

    for i in 2...n {
        for j in 1...m {
            p[i][j] = p[i][j - 1] + p[i - 1][j - 1]
        }
    }

    print(p[n][m])
}