import Foundation

func solution(_ m: Int, _ n: Int, _ map: [[Int]]) -> Int {
    var memo = [[Int]](repeating: [Int](repeating: -1, count: n), count: m)
    let dir = [-1, 0, 1, 0, -1]

    func dfs(r: Int, c: Int) -> Int {
        if r == m - 1 && c == n - 1 { return 1 }
        if memo[r][c] >= 0 { return memo[r][c] }

        memo[r][c] = 0
        for i in 0...3 {
            let nextR = r + dir[i], nextC = c + dir[i + 1]
            if nextR < 0 || nextR >= m || nextC < 0 || nextC >= n || map[nextR][nextC] >= map[r][c] { continue }

            memo[r][c] += dfs(r: nextR, c: nextC)
        }
        return memo[r][c]
    }

    return dfs(r: 0, c: 0)
}

let mn = readLine()!.split(separator: " ").map { Int($0)! }
let m = mn[0], n = mn[1]
var map = [[Int]]()

for _ in 0..<m {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    map.append(row)
}

print(solution(m, n, map))