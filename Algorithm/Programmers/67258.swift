import Foundation

func solution(_ gems: [String]) -> [Int] {
    let gem = Array(Set(gems))
    
    if gem.count == 1 { return [1, 1] }
    
    var s = 0, e = 1
    var container = [String : Int]()
    var answer = (0, gems.count - 1)
    
//  for g in gem { container.updateValue(0, forKey: g) }
    container[gems[s]] = 1
    container[gems[e]] = 1
    
    func hasAllGem() -> Bool {
        return container.count == gem.count
    }
    
    while s < gems.count - gem.count + 1 && e < gems.count {
        if !hasAllGem() { 
            e += 1
            if e >= gems.count { break }
            
            if container[gems[e]] == nil {
                container.updateValue(1, forKey: gems[e])
            } else {
                container[gems[e]]! += 1
            }
        } else {
            let newAnswer = (s, e)
            if newAnswer.1 - newAnswer.0 < answer.1 - answer.0 {
                answer = newAnswer
                if newAnswer.1 - newAnswer.0 == gem.count - 1 { break }
            }
            
            container[gems[s]]! -= 1
            if container[gems[s]]! == 0 {
                container.removeValue(forKey: gems[s])
            }
            s += 1
        }
    }
    
    return [answer.0 + 1, answer.1 + 1]
}

print(solution(["DIA", "RUBY", "RUBY", "DIA", "DIA", "EMERALD", "SAPPHIRE", "DIA"]))
print(solution(["AA", "AB", "AC", "AA", "AC"]))
print(solution(["XYZ", "XYZ", "XYZ"]))
print(solution(["ZZZ", "YYY", "NNNN", "YYY", "BBB"]))