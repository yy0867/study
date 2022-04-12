import Foundation

func solution(_ n: Int, _ k: Int) -> Int {
    var numbers = [Int]()
    var origin = n
    var answer = [Int]()

    repeat {
        let mod = origin % k
        numbers.append(mod)
        origin = origin / k
    } while origin > 0
    numbers = numbers.reversed()
    let splitedNumbers = numbers.map { String($0) }
        .joined(separator: "")
        .split(separator: "0")
        .map { Int($0)! }

    for number in splitedNumbers {
        let root = Int(sqrt(Double(number))) + 1
        var isPrime = true
        if root < 2 {
            if number == 2 || number == 3 { answer.append(number) }
            continue
        }
        for i in 2..<root {
            if number % i == 0 {
                isPrime = false
                break
            }
        }
        if isPrime { answer.append(number) }
    }

    return answer.count
}

print(solution(437674, 3))
print(solution(110011, 10))
