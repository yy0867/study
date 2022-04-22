import Foundation

func solution(_ n:Int, _ info:[Int]) -> [Int] {

    var selected = [Int](repeating: 0, count: 11)
    var target = [Int](repeating: 0, count: 11)
    var answer = [-1]
    var maxOfSub = -1

    for (index, count) in info.enumerated() {
        selected[index] = count + 1
    }

    func calculateScore() {
        var appeachScore = 0
        var lionScore = 0
        for i in 0...10 {
            let appeach = info[i]
            let lion = target[i]
            let currentScore = 10 - i

            if appeach == 0 && lion == 0 { continue }
            else if appeach >= lion { appeachScore += currentScore }
            else { lionScore += currentScore }
        }
        
        if lionScore > appeachScore {
            if (lionScore - appeachScore) > maxOfSub || answer.count == 1 {
                maxOfSub = lionScore - appeachScore
                answer = target
            } else if (lionScore - appeachScore) == maxOfSub {
                for i in stride(from: 10, to: -1, by: -1) {
                    if answer[i] == target[i] { continue }
                    else if answer[i] > target[i] { break }
                    else {
                        maxOfSub = lionScore - appeachScore
                        answer = target
                        break
                    }
                }
            }
        }
    }

    func dfs(arrow: Int, index: Int) {
        if arrow < 0 { return }
        if index > 10 {
            target[10] += arrow
            calculateScore()
            target[10] = 0
            return
        }

        for i in 0...1 {
            if i == 0 { target[index] = 0 }
            else { target[index] = selected[index] }
            dfs(arrow: arrow - target[index], index: index + 1)
            target[index] = 0
        }
    }

    dfs(arrow: n, index: 0)

    return answer
}

print(solution(5, [2,1,1,1,0,0,0,0,0,0,0]))
print(solution(2, [1,1,0,0,0,0,0,0,0,0,0]))
print(solution(9, [0,0,1,2,0,1,1,1,1,1,1]))
print(solution(10, [0,0,0,0,0,0,0,0,3,4,3]))