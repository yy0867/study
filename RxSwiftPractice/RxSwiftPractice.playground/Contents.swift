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

//let selectedDate: PublishSubject<Date> = PublishSubject()
//let week: PublishRelay<[Date]> = PublishRelay()
//let planList: PublishRelay<[Plan]> = PublishRelay()
//let disposeBag = DisposeBag()
let calendar = Calendar(identifier: .gregorian)

func getWeekBelongsDate(_ date: Date) {
    let weekOfYear = calendar.component(.weekOfYear, from: date)
    let component = DateComponents.init(calendar: calendar, timeZone: TimeZone(abbreviation: "KST"), weekOfYear: weekOfYear)
    print(component.date)
}

//func bindWeekPlanListToSelectedDate() {
//    week.subscribe(selectedDate)
//}
//
//func changeDate(to date: Date) {
//    selectedDate.onNext(date)
//}


// MARK: - Execution
getWeekBelongsDate(DateComponents(calendar: calendar, timeZone: TimeZone(abbreviation: "KST"), year: 2022, month: 1, day: 1).date!)
