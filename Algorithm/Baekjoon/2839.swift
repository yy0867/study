import Foundation

func minOrNotZero(_ a: Int, _ b: Int) -> Int {
    if a == 0 && b == 0 { return 0 }
    else if a == 0 { return b }
    else if b == 0 { return a }
    else { return a < b ? a : b }
}

func solution(_ n: Int) -> Int {
    if n == 3 || n == 5 { return 1 } 
    else if n < 5 { return -1 }

    var p = [Int](repeating: 0, count: n + 1)
    p[3] = 1
    p[5] = 1

    for i in 6...n {
        let value = minOrNotZero(p[i - 3], p[i - 5]) 
        p[i] = value != 0 ? value + 1 : 0
    }
    return p[n] != 0 ? p[n] : -1
}

var n = Int(readLine()!)!
print(solution(n))