import Foundation

let n = Int(readLine()!)!
var houses = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.map { Int(String($0))! }
    houses.append(row)
}

func solution() -> [Int] {
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    var answer = [Int]()
    var index = 0
    let dir = [1, 0, -1, 0, 1]

    func dfs(_ r: Int, _ c: Int) {
        if houses[r][c] == 0 || visited[r][c] { return }
        visited[r][c] = true
        answer[index] += 1

        for i in 0...3 {
            let nextR = r + dir[i]
            let nextC = c + dir[i + 1]

            if nextR < 0 || nextR >= n || nextC < 0 || nextC >= n { continue }
            dfs(nextR, nextC)
        }
    }

    for i in 0..<n {
        for j in 0..<n {
            if houses[i][j] == 0 || visited[i][j] { continue }
            answer.append(0)
            dfs(i, j)
            index += 1
        }
    }

    return answer.sorted()
}

let answer = solution()
print(answer.count)
for h in answer {
    print(h)
}