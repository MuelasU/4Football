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
}
