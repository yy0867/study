typealias Time = (hour: Int, minute: Int)

func timeStringToInt(_ time: String) -> Time {
    let splited = time.split(separator: ":")
    return (Int(splited[0])!, Int(splited[1])!)
}

func timeToString(_ time: Time) -> String {
    var hour = String(time.hour)
    hour = hour.count == 1 ? "0\(hour)" : hour
    var minute = String(time.minute)
    minute = minute.count == 1 ? "0\(minute)" : minute
    
    return "\(hour):\(minute)"
}

func isEarlyOrEqual(_ time: Time, than compare: Time) -> Bool {
    return (timeToString(time) <= timeToString(compare))
}

func addMinute(of time: Time, add: Int) -> Time {
    let hour = time.hour, minute = time.minute + add
    return (hour + minute / 60, minute % 60)
}

func subMinute(of time: Time, sub: Int) -> Time {
    if time.minute > 0 { return Time(time.hour, time.minute - 1) }
    var result = Time(time.hour - 1, 59)
    if result.hour < 0 { result.hour = 23 }
    return result
}

func solution(_ n: Int, _ t: Int, _ m: Int, _ timetable: [String]) -> String {
    let busBegin = Time(9, 0), dayEnd = Time(23, 59)
    
    var compactTimetable = timetable.sorted().map { timeStringToInt($0) }
    var busDepartTime = [Time]()
    var busDepartCrewCount = [Int]()
    
    for busNumber in 0 ..< n {
        busDepartTime.append(addMinute(of: busBegin, add: busNumber * t))
        busDepartCrewCount.append(0)
    }
    
    // remove crew from last bus time to 23:59
    let lastBusTime = addMinute(of: busDepartTime.last!, add: 1)
    compactTimetable = compactTimetable.filter { time in
        return !(isEarlyOrEqual(lastBusTime, than: time) && isEarlyOrEqual(time, than: dayEnd))
    }
    
    if compactTimetable.isEmpty {
        return timeToString(busDepartTime.last!)
    }
    
    var busNo = 0, crewNo = 0
    while busNo < busDepartTime.count {
        
        let departTime = busDepartTime[busNo]
        
        for i in crewNo ..< crewNo + m where i < compactTimetable.count {
            let crew = compactTimetable[i]
            if isEarlyOrEqual(crew, than: departTime) {
                busDepartCrewCount[busNo] += 1
                crewNo += 1
                
                if busDepartCrewCount[busNo] >= m {
                    if busNo == n - 1 {
                        return timeToString(subMinute(of: crew, sub: 1))
                    }
                    break 
                }
            }
        }
        
        busNo += 1
    }
    
    let lastCrew = compactTimetable.last!
    if busDepartCrewCount.last! == m {
        return timeToString(subMinute(of: lastCrew, sub: 1))
    }
    return timeToString(busDepartTime.last!)
}

print(solution(1, 1, 5, ["08:00", "08:01", "08:02", "08:03"]))
print(solution(2, 10, 2, ["09:10", "09:09", "08:00"]))
print(solution(2, 1, 2, ["09:00", "09:00", "09:00", "09:00"]))
print(solution(1, 1, 5, ["00:01", "00:01", "00:01", "00:01", "00:01"]))
print(solution(1, 1, 1, ["23:59"]))
print(solution(10, 60, 45, ["23:59","23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59", "23:59"]))
print(solution(1, 1, 5, ["00:01", "00:01", "00:01","00:01", "00:01", "00:02", "00:03", "00:04"] ))