import Foundation

extension League: Query {
    var key: String {
        "league"
    }

    var value: String {
        String(self.id)
    }
}
