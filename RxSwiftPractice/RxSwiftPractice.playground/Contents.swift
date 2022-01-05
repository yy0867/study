import Foundation
import RxSwift
import RxRelay

struct Plan {
    var name: String
    var id: Int
    var color: String
    var notification: Bool
    var achieve: Bool
}

let selectedDate: PublishRelay<Date> = PublishRelay()
let week: PublishRelay<[Date]> = PublishRelay()
let planList: PublishRelay<[Plan]> = PublishRelay()
let disposeBag = DisposeBag()

func getWeekBelongsDate(_ date: Date) -> [Date] {
    
    let calendar = Calendar.current
    let dayOfWeek = calendar.component(.weekday, from: date)
    let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: date)!
    let days = (weekdays.lowerBound ..< weekdays.upperBound)
        .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: date) }
    
    return days
}

func getDate(year: Int, month: Int, day: Int) -> Date {
    return DateComponents(calendar: Calendar.current,
                          year: year,
                          month: month,
                          day: day).date!
}

func bindWeekPlanListToSelectedDate() {
    selectedDate.subscribe(onNext: { date in
        print("date changes: \(date.toString())")
        week.accept(getWeekBelongsDate(date))
    }).disposed(by: disposeBag)
}

func changeDate(to date: Date) {
    selectedDate.accept(date)
    print("###################")
}


// MARK: - Execution
getWeekBelongsDate(getDate(year: 2022, month: 1, day: 3))
bindWeekPlanListToSelectedDate()

week.subscribe(onNext: { weekdays in
    print(weekdays.map { $0.toString() })
})

changeDate(to: getDate(year: 2022, month: 1, day: 30))
changeDate(to: getDate(year: 2022, month: 1, day: 31))
changeDate(to: getDate(year: 2022, month: 1, day: 5))


// MARK: - Extensions
extension Date {
    
    func toString(format: String = "YYYY-MM-dd (E) HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.timeZone = .autoupdatingCurrent
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
