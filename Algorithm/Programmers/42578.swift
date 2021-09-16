import Foundation

func solution(_ clothes:[[String]]) -> Int {
    var count = [String : Int]()
    var answer = 1

    for c in clothes {
        let kind = c[1]

        if count[kind] == nil { count[kind] = 1 }
        else { count[kind]! += 1 }
    }

    for c in count {
        answer *= (c.value + 1)
    }

    return answer - 1
}

print(solution([["yellowhat", "headgear"], ["bluesunglasses", "eyewear"], ["green_turban", "headgear"]]))