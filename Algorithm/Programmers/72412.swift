import Foundation

func solution(_ info:[String], _ query:[String]) -> [Int] {
    var dict = [String: [Int]]()

    for information in info {
        let parsedInfo = information.components(separatedBy: " ")
        let score = Int(parsedInfo[4])!
        for lang in [parsedInfo[0], "-"] {
            for end in [parsedInfo[1], "-"] {
                for career in [parsedInfo[2], "-"] {
                    for food in [parsedInfo[3], "-"] {
                        let key = "\(lang)\(end)\(career)\(food)"
                        if dict[key] == nil { dict[key] = [score] }
                        else { dict[key]!.append(score) }
                    }
                }
            }
        }
    }

    func count(array: [Int], number: Int) -> Int {
        var start = 0, end = array.count
        while end > start {
            let mid = (start + end) / 2
            if array[mid] >= number { end = mid }
            else { start = mid + 1 }
        }
        return array.count - start
    }

    for d in dict { 
        let sortValue = d.value.sorted() 
        dict[d.key] = sortValue 
    }

    var answer = [Int]()
    for q in query {
        let splitedQuery = q.components(separatedBy: " ")
        let parsedQuery = "\(splitedQuery[0])\(splitedQuery[2])\(splitedQuery[4])\(splitedQuery[6])"
        if dict[parsedQuery] == nil { answer.append(0) }
        else {
            let c = count(array: dict[parsedQuery]!, number: Int(splitedQuery[7])!)
            answer.append(c)
        }
    }

    return answer
}

print(
    solution(
        ["java backend junior pizza 150","python frontend senior chicken 210","python frontend senior chicken 150","cpp backend senior pizza 260","java backend junior chicken 80","python backend senior chicken 50"],
        ["java and backend and junior and pizza 100","python and frontend and senior and chicken 200","cpp and - and senior and pizza 250","- and backend and senior and - 150","- and - and - and chicken 100","- and - and - and - 150"]
    )
)