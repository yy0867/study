import Foundation

let n = Int(readLine()!)!
var times = (0..<n).map { _ in readLine()!
        .split(separator: " ")
        .map { Int($0)! }
    }
    .map { ($0[0], $0[1]) }

times = times.sorted { $0.0 < $1.0 }
times = times.sorted { $0.1 < $1.1 }

func solution() -> Int {
    if n == 1 { return 1 }

    var cur = times[0].1
    var answer = 1

    for i in 1..<n {
        let t = times[i]
        let start = t.0, end = t.1

        if start >= cur {
            cur = end
            answer += 1
        }
    }

    return answer
}

print(solution())