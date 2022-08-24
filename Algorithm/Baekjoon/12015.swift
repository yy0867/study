import Foundation

func solution(_ n: Int, _ sequence: [Int]) -> Int {
    var result = [Int]()

    for number in sequence {
        if result.isEmpty || result.last! < number { 
            result.append(number) 
            continue
        }

        var left = 0, right = result.count - 1
        while left <= right {
            let mid = (left + right) / 2
            
            if result[mid] == number { break }
            else if result[mid] > number {
                if mid == 0 || result[mid - 1] < number {
                    result[mid] = number
                    break
                } else {
                    right = mid - 1
                }
            } else {
                if mid == result.count - 1 {
                    result.append(number)
                    break
                }
                if result[mid + 1] > number {
                    result[mid + 1] = number
                    break
                } else {
                    left = mid + 1
                }
            }
        }
    }

    return result.count
}

let n = Int(readLine()!)!
let sequence = readLine()!.split(separator: " ").map { Int($0)! }

print(solution(n, sequence))