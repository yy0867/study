import Foundation

func isOneCharDifferent(_ lhs: String, _ rhs: String) -> Bool {
    var wrongCount = 0
    for i in 0 ..< lhs.count {
        if lhs[lhs.index(lhs.startIndex, offsetBy: i)] != rhs[rhs.index(rhs.startIndex, offsetBy: i)] { 
            wrongCount += 1 
        }
        if wrongCount > 1 { return false }
    }
    return wrongCount == 1
}

func solution(_ begin:String, _ target:String, _ words:[String]) -> Int {
    if !words.contains(target) { return 0 }
    
    var visited = [Bool](repeating: false, count: words.count)
    var answer = Int.max
    
    func findWord(_ current: String, _ v: Int) {
        if current == target { 
//          print(current)
            return answer = v < answer ? v : answer
        }
        
        for i in 0 ..< words.count {
            // check already visited
            if visited[i] { continue }
            // now visit
            if isOneCharDifferent(current, words[i]) {
                visited[i] = true
                findWord(words[i], v + 1)
                visited[i] = false
            }
        }
        return
    }
    
    findWord(begin, 0)
    
    return answer
}

print(solution("hit", "cog", ["hot", "dot", "dog", "lot", "log", "cog"]))
//print(solution("hit", "cog", ["hot", "dot", "dog", "lot", "log"]))