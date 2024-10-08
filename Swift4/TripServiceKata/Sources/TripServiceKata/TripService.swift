import Foundation

// Code smells
// 1- nested conditionals
// 2- implicit dependencies
// 3- feature envy, moved how to get my friends to the user object

class TripService {
    let userSession: UserSession?
    let tripDAO: TripDAO?

    init(userSession: UserSession? = UserSession.sharedInstance, tripDAO: TripDAO?) {
        self.userSession = userSession
        self.tripDAO = tripDAO
    }

    func getTripsByUser(_ user: User) throws -> [Trip]? {
        guard let loggedUser = getLoggedUser() else { throw TripServiceErrorType.userNotLoggedIn }
        return user.isMyFriend(loggedUser) ? findTripsByUser(user) : nil
    }

    func getLoggedUser() -> User? {
        try! userSession?.getLoggedUser()
    }

    func findTripsByUser(_ user: User) -> [Trip]? {
        try! tripDAO?.findTripsByUser(user)
    }
}
