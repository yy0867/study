import Foundation

let n = Int(readLine()!)!
let k = Int(readLine()!)!

func count(_ n: Int, _ mid: Int) -> Int {
    var result = 0

    for i in 1...n {
        let cnt = mid / i
        result += (n < cnt) ? n : cnt
    }

    return result
}

func solution(_ n: Int, _ k: Int) -> Int {
    var low = 0, high = n * n
    var answer = 0

    while low <= high {
        let mid = (low + high) / 2
        let count = count(n, mid)

        if count < k {
            low = mid + 1
        } else {
            answer = mid
            high = mid - 1
        }
    }

    return answer
}

print(solution(n, k))