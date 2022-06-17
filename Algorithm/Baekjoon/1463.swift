import Foundation

func min(_ a: Int, _ b: Int, _ c: Int) -> Int {
    if a <= b && a <= c { return a }
    else if b <= a && b <= c { return b }
    else { return c }
}

func solution(_ n: Int) -> Int {
    if n == 1 { return 0 }
    else if n == 2 || n == 3 { return 1 }

    var p = [Int](repeating: 0, count: n + 1)
    for i in 2...3 { p[i] = 1 }
    
    for i in 4...n {
        var divThree = 10_000_000
        var divTwo = 10_000_000

        let minusOne = p[i - 1]
        if i % 3 == 0 { divThree = p[i / 3] }
        if i % 2 == 0 { divTwo = p[i / 2] }

        p[i] = min(minusOne, divTwo, divThree) + 1
    }

    return p[n]
}

let n = Int(readLine()!)!
print(solution(n))