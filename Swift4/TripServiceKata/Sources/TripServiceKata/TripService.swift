import Foundation

class TripService {
    func getTripsByUser(_ user: User) throws -> [Trip]? {
        var tripList:[Trip]? = nil        
        var isFriend = false
        
        if let loggedUser = getLoggedUser() {
            for friend in user.getFriends() {
                if friend == loggedUser {
                    isFriend = true
                    break
                }
            }
            if isFriend {
                tripList = findTripsByUser(user)
            }
            return tripList
        } else {
            throw TripServiceErrorType.userNotLoggedIn
        }
    }

	func getLoggedUser() -> User? {
		try! UserSession.sharedInstance.getLoggedUser()
	}

	func findTripsByUser(_ user: User) -> [Trip]? {
		try! TripDAO.findTripsByUser(user)
	}
}
