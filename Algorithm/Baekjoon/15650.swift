import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]

func printArray(_ arr: [Int]) {
    for a in arr {
        print(a, terminator: " ")
    }
    print()
}

func solution(_ n: Int, _ m: Int) {
    func seq(_ arr: [Int], _ count: Int) {
        if count <= 0 {
            printArray(arr)
            return
        }

        if arr.last! == n { return }

        for i in ((arr.last! + 1)...n) {
            seq(arr + [i], count - 1)
        }
    }
    
    for i in 1...n {
        seq([i], m - 1)
    }
}

solution(n, m)