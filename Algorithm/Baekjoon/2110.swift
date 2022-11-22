import Foundation

let nc = readLine()!.split(separator: " ").map { Int(String($0))! }
let n = nc[0], c = nc[1]
var houses = [Int]()

for _ in 0..<n {
    let input = Int(readLine()!)!
    houses.append(input)
}

houses.sort()

func solution(_ n: Int, _ c: Int, _ houses: [Int]) -> Int {
    var low = 1, high = houses.last! - houses.first! + 1

    while low < high {
        let mid = (low + high) / 2

        if count(mid) < c {
            high = mid
        } else {
            low = mid + 1
        }
    }

    func count(_ distance: Int) -> Int {
        var count = 1
        var last = houses[0]

        for i in 1..<n {
            if houses[i] - last >= distance {
                last = houses[i]
                count += 1
            }
        }
        return count
    }

    return low - 1
}

print(solution(n, c, houses))