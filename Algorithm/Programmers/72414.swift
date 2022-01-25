import Foundation

func solution(_ play_time: String, _ adv_time: String, _ logs: [String]) -> String {
    let playTime = toSecond(play_time)
    let advTime = toSecond(adv_time)
    var timeline = [Double](repeating: 0, count: playTime + 1)

    for log in logs {
        let split = log.split(separator: "-").map { String($0) }
        let start = toSecond(split[0]), end = toSecond(split[1])

        timeline[start] += 1
        timeline[end] -= 1
    }

    for i in 1 ... playTime {
        timeline[i] += timeline[i - 1]
    }

    var sum = timeline[0..<advTime].reduce(0, +)
    var maxSum: Double = sum
    var maxStartSecond = 0

    for i in advTime ..< playTime {

        sum += (timeline[i] - timeline[i - advTime])

        if maxSum < sum {
            maxSum = sum
            maxStartSecond = i - advTime + 1
        }
    }

    return toString(maxStartSecond)
}

func toSecond(_ time: String) -> Int {
    let split = time.split(separator: ":").map { Int($0)! }
    return (split[2] + split[1] * 60 + split[0] * 60 * 60)
}

func toString(_ time: Int) -> String {
    var remainTime = 0
    let hour = time / 3600
    remainTime = time % 3600

    let minute = remainTime / 60
    remainTime = remainTime % 60

    let second = remainTime

    let h = String(hour).count == 2 ? "\(hour)" : "0\(hour)"
    let m = String(minute).count == 2 ? "\(minute)" : "0\(minute)"
    let s = String(second).count == 2 ? "\(second)" : "0\(second)"

    return "\(h):\(m):\(s)"
}

print(solution("02:03:55", "00:14:15", ["01:20:15-01:45:14", "00:40:31-01:00:00", "00:25:50-00:48:29", "01:30:59-01:53:29", "01:37:44-02:02:30"]))
