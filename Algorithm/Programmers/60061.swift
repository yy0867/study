import Foundation

func solution(_ n:Int, _ build_frame:[[Int]]) -> [[Int]] {
    var answer = Set<[Int]>()

    func canConstruct() -> Bool {
        for structure in answer {
            let x = structure[0], y = structure[1], a = structure[2]

            // 기둥
            if a == 0 {
                if answer.contains([x - 1, y, 1]) || answer.contains([x, y, 1]) || answer.contains([x, y - 1, 0]) || y == 0 { continue }
                return false
            }
            // 보
            else {
                if answer.contains([x, y - 1, 0]) || answer.contains([x + 1, y - 1, 0]) || (answer.contains([x - 1, y, 1]) && answer.contains([x + 1, y, 1])) { continue }
                return false
            }
        }
        return true
    }

    for structure in build_frame {
        var valid = true
        // 설치
        if structure[3] == 1 {
            answer.insert([structure[0], structure[1], structure[2]])
            valid = canConstruct()
            if !valid { answer.remove([structure[0], structure[1], structure[2]]) }
        }
        // 삭제
        else {
            let comp = [structure[0], structure[1], structure[2]]
            answer.remove(comp)
            valid = canConstruct()
            if !valid { answer.insert(comp) }
        }
    }

    return answer.sorted { lhs, rhs in 
        if lhs[0] == rhs[0] {
            if lhs[1] == rhs[1] {
                return lhs[2] < rhs[2]
            }
            return lhs[1] < rhs[1]
        }
        return lhs[0] < rhs[0]
    }
}

print(solution(5, [[1,0,0,1],[1,1,1,1],[2,1,0,1],[2,2,1,1],[5,0,0,1],[5,1,0,1],[4,2,1,1],[3,2,1,1]]))