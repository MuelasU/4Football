import Foundation

class UserSession {
    static let shared: UserSession = .init()
    private init() {}

    private func setObject<T: Encodable>(_ obj: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(obj)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    private func getObject<T: Decodable>(forKey key: String) -> T? {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                return try JSONDecoder().decode(T.self, from: data)
            } else {
                print("Key '\(key)' not found")
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }

    var nationality: Country? {
        get {
            return getObject(forKey: "nationality")
        }
        set {
            setObject(newValue, forKey: "nationality")
        }
    }

    var club: Team? {
        get {
            return getObject(forKey: "club")
        }
        set {
            setObject(newValue, forKey: "club")
        }
    }

    var isUserDefined: Bool {
        get {
            UserDefaults.standard.bool(forKey: "user_defined")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "user_defined")
        }
    }
}
