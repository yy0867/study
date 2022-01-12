import Foundation

func solution(_ n:Int, _ s:Int, _ a:Int, _ b:Int, _ fares:[[Int]]) -> Int {
    
    let INF = 1000000000
    
    var minimumFares = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)
    
    for fare in fares {
        let start = fare[0], end = fare[1], cost = fare[2]
        minimumFares[start][end] = cost
        minimumFares[end][start] = cost
        minimumFares[start][start] = 0
        minimumFares[end][end] = 0
    }
    
    func floyd() {
        for mid in 1 ... n {
            for start in 1 ... n {
                for end in 1 ... n {
                    if minimumFares[start][end] > minimumFares[start][mid] + minimumFares[mid][end] {
                        minimumFares[start][end] = minimumFares[start][mid] + minimumFares[mid][end]
                    }
                }
            }
        }
    }
    
    floyd()
    
    var answer = Int.max
    for via in 1 ... n {
        let aToVia = minimumFares[a][via]
        let bToVia = minimumFares[b][via]
        let viaToS = minimumFares[via][s]
//      if aToVia == INF || bToVia == INF || viaToS == INF { continue }
        
        if aToVia + bToVia + viaToS < answer {
            answer = aToVia + bToVia + viaToS
        }
    }
    
    return answer
}

print(solution(6, 4, 6, 2, [[4, 1, 10], [3, 5, 24], [5, 6, 2], [3, 1, 41], [5, 1, 24], [4, 6, 50], [2, 4, 66], [2, 3, 22], [1, 6, 25]]))
print(solution(7, 3, 4, 1, [[5, 7, 9], [4, 6, 4], [3, 6, 1], [3, 2, 3], [2, 1, 6]]))
print(solution(6, 4, 5, 6, [[2,6,6], [6,3,7], [4,6,7], [6,5,11], [2,5,12], [5,3,20], [2,4,8], [4,3,9]]))