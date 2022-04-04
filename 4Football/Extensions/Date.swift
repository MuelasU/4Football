import Foundation

extension Date {
    init?(_ year: Int, _ month: Int, _ day: Int) {
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        
        if let date = gregorianCalendar.date(from: dateComponents) {
            self = date
        } else {
            return nil
        }
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayOfTheWeek: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
    var dayOfTheMonth: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    func isSameDay(to day: Date) -> Bool {
        let otherDay = Calendar.current.dateComponents([.day], from: self)
        let currentDay = Calendar.current.dateComponents([.day], from: .now)
        let diff = otherDay.day! - currentDay.day!
        return diff == 0
    }
    
    func getNextDays(count: Int) -> [Date] {
        return (1...count).map { i in
            Calendar.current.date(
                byAdding: .day,
                value: i,
                to: self
            )!
        }
    }
    
    func getPreviousDays(count: Int) -> [Date] {
        return (1...count).map { i in
            Calendar.current.date(
                byAdding: .day,
                value: -i,
                to: self
            )!
        }
    }
}
