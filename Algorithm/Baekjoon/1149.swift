import Foundation

func min(_ a: Int, _ b: Int, _ c: Int = 1000000001) -> Int {
    if a <= b && a <= c { return a }
    else if b <= a && b <= c { return b }
    else { return c }
}

func solution(_ n: Int, _ costs: [[Int]]) -> Int {
    var p = [[Int]](repeating: [Int](repeating: 0, count: n), count: 3)
    let r = 0, g = 1, b = 2

    func getCosts(rgb: Int, house: Int) -> Int {
        return costs[house][rgb]
    }

    p[r][0] = getCosts(rgb: r, house: 0)
    p[g][0] = getCosts(rgb: g, house: 0)
    p[b][0] = getCosts(rgb: b, house: 0)

    for i in 1..<n {
        // r
        p[r][i] = min(p[g][i - 1], p[b][i - 1]) + getCosts(rgb: r, house: i)

        // g
        p[g][i] = min(p[r][i - 1], p[b][i - 1]) + getCosts(rgb: g, house: i)

        // b
        p[b][i] = min(p[r][i - 1], p[g][i - 1]) + getCosts(rgb: b, house: i)
    }

    return min(p[r][n - 1], p[g][n - 1], p[b][n - 1])
}

let n = Int(readLine()!)!
var input = [[Int]]()
for _ in 0..<n {
    let curInput = readLine()!.components(separatedBy: " ").map { Int($0)! }
    input.append([curInput[0], curInput[1], curInput[2]])
}

print(solution(n, input))