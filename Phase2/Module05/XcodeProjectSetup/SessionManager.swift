import SwiftUI
internal import Combine

class SessionManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    var isSessionExpired: Bool = false

    func recordBackgroundTimestamp() {}

    func evaluateSessionTimeout() {}

}
