import Foundation

func solution(_ locations: [(Int, Int)]) -> [Int] {
    var answer = [Int]()
    for location in locations {
        let d = location.1 - location.0
        var n = 0

        while d > n * (n + 1) {
            n += 1
        }
        
        if d <= n * n {
            answer.append(n * 2 - 1)
        } else {
            answer.append(n * 2)
        }
    }
    return answer
}

let n = Int(readLine()!)!
var locations = [(Int, Int)]()
for _ in 0..<n {
    let sd = readLine()!.split(separator: " ").map { Int(String($0))! }
    locations.append((sd[0], sd[1]))
}
let result = solution(locations)
for r in result {
    print(r)
}