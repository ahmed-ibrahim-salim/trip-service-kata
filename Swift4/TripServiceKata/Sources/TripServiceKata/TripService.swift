import Foundation

// Code smells
// nested conditionals
// global state

class TripService {
    let userSession: UserSession?
    let tripDAO: TripDAO?

    init(userSession: UserSession? = UserSession.sharedInstance, tripDAO: TripDAO?) {
        self.userSession = userSession
        self.tripDAO = tripDAO
    }

    func getTripsByUser(_ user: User) throws -> [Trip]? {
        guard let loggedUser = getLoggedUser() else { throw TripServiceErrorType.userNotLoggedIn }

        for friend in user.getFriends() {
            if friend == loggedUser {
                return findTripsByUser(user)
            }
        }

        return nil
    }

    func getLoggedUser() -> User? {
        try! userSession?.getLoggedUser()
    }

    func findTripsByUser(_ user: User) -> [Trip]? {
        try! tripDAO?.findTripsByUser(user)
    }
}
