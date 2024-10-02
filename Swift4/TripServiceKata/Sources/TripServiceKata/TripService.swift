import Foundation

// Code smells
// nested conditionals
// global state

class TripService {
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
        try! UserSession.sharedInstance.getLoggedUser()
    }

    func findTripsByUser(_ user: User) -> [Trip]? {
        try! TripDAO.findTripsByUser(user)
    }
}
