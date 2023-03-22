import Foundation

extension Team: Query {
    var key: String {
        "team"
    }

    var value: String {
        String(self.id)
    }
}
