import Foundation

let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0], m = nm[1]
let trees = readLine()!.split(separator: " ").map { Int($0)! }

func cut(_ k: Int) -> Bool {
    var sum = 0

    for tree in trees {
        if tree < k { continue }

        sum += (tree - k)
    }

    return sum >= m
}

func solution() -> Int {
    let max = trees.max()!

    var left = 0, right = max
    while (left + 1) < right {
        let mid = (left + right) / 2

        if cut(mid) {
            left = mid
        } else {
            right = mid
        }
    }

    return left
}

print(solution())