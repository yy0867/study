import Foundation

func solution(_ n: Int) -> Int {
    var answer = 0

    func sum(_ number: Int) {
        if number == n {
            answer += 1
            return
        } else if number > n {
            return
        }

        for i in 1...3 {
            sum(number + i)
        }
    }

    sum(0)

    return answer
}

let t = Int(readLine()!)!

for _ in 0..<t {
    let n = Int(readLine()!)!
    print(solution(n))
}