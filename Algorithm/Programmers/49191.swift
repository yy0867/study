import Foundation

func solution(_ n:Int, _ results:[[Int]]) -> Int {
    let none = 0, win = 1, lose = 2
    var rankTable = [[Int]](repeating: [Int](repeating: none, count: n + 1), count: n + 1)
    
    for res in results {
        rankTable[res[0]][res[1]] = win
        rankTable[res[1]][res[0]] = lose
    }
    
    for _ in 1...2 {
        for curPlayer in 1...n {
            for opponent in 1...n where curPlayer != opponent {
                if rankTable[curPlayer][opponent] == win {
                    for i in 1...n {
                        if rankTable[i][opponent] == lose {
                            rankTable[curPlayer][i] = win
                            rankTable[i][curPlayer] = lose
                        }
                    }
                }
            }
        }
    }
    
    return rankTable.filter { $0.filter { $0 != none }.count == n - 1 }.count
}

print(solution(5, [[1, 4], [4, 2], [2, 5], [5, 3]]))