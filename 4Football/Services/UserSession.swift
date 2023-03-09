import Foundation

class UserSession {
    static let shared: UserSession = .init()
    private init() {}
    
//    static let shared: UserSession = .init()
//
//    let nationality: Country?
//    let club: Team?
//
//    private init() {
//        nationality = UserDefaults.standard.object(forKey: "nationality") as? Country
//        club = UserDefaults.standard.object(forKey: "club") as? Team
//    }

//    let nationality: Country?
//    let club: Team?
//
//    init() {
//        nationality = UserDefaults.standard.object(forKey: "nationality") as? Country
//        club = UserDefaults.standard.object(forKey: "club") as? Team
//    }

    var nationality: Country {
        get {
            UserDefaults.standard.object(forKey: "nationality") as! Country
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nationality")
        }
    }
    var club: Team {
        get {
            UserDefaults.standard.object(forKey: "club") as! Team
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "club")
        }
    }

    var isFirstTime: Bool {
        get {
            UserDefaults.standard.bool(forKey: "first_time")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "first_time")
        }
    }
}
