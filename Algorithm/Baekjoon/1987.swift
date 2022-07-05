import Foundation

func solution(_ n: Int, _ m: Int, _ field: [[Int]]) -> Int {

    var maxCount = -1
    let dir = [-1, 0, 1, 0, -1]

    func dfs(_ r: Int, _ c: Int, _ count: Int, _ bit: Int) {

        for i in 0...3 {
            let nextR = r + dir[i], nextC = c + dir[i + 1]
            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= m { continue }
            
            let nextBit = 1 << field[nextR][nextC]
            if bit & nextBit == 0 {
                dfs(nextR, nextC, count + 1, bit | nextBit)
            }
        }

        maxCount = count > maxCount ? count : maxCount
    }

    dfs(0, 0, 1, 1 << field[0][0])

    return maxCount
}

let nm = readLine()!.split(separator: " ").map { Int(String($0))! }
var map = [[Int]]()
for _ in 0..<nm[0] {
    let row = readLine()!.map { Int($0.asciiValue!) - 65 }
    map.append(row)
}
print(solution(nm[0], nm[1], map))