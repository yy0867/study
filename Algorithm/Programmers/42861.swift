import Foundation

func solution(_ n:Int, _ costs:[[Int]]) -> Int {
    let sortedCosts = costs.sorted { $0[2] < $1[2] }
    var record = [Int](repeating: 0, count: n)
    var answer = 0

    for i in 0..<n { record[i] = i }

    func findParent(_ island: Int) -> Int {
        if island == record[island] { return island }
        else { return findParent(record[island]) }
    }

    for info in sortedCosts {
        let start = info[0], end = info[1], cost = info[2]
        let parentStart = findParent(start), parentEnd = findParent(end)
        if parentStart == parentEnd { continue }
        if parentStart > parentEnd { record[parentStart] = record[parentEnd] }
        else { record[parentEnd] = record[parentStart] }
        answer += cost
    }

    return answer
}

print(solution(4, [[0,1,1],[0,2,2],[1,2,5],[1,3,1],[2,3,8]]))