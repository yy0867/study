import Foundation

let t = Int(readLine()!)!
var solutions = [Int]()

for _ in 0..<t {
    let n = Int(readLine()!)!
    let select = [0] + readLine()!.split(separator: " ").map { Int($0)! }

    solutions.append(solution(n, select))
}

for s in solutions {
    print(s)
}

func solution(_ n: Int, _ select: [Int]) -> Int {
    var visited = [Bool](repeating: false, count: n + 1)
    var teams = [[Int]]()
    var team = [Int]()

    func dfs(_ cur: Int) {
        visited[cur] = true
        team.append(cur)
        let next = select[cur]

        if !visited[next] {
            dfs(next)
        } else {
            if team.contains(next) {
                teams.append(Array(team[team.firstIndex(of: next)!...]))
            }
            return
        }
    }

    for i in 1...n {
        if !visited[i] {
            team = []
            dfs(i)
        }
    }

    return n - teams.flatMap({ $0 }).count
}