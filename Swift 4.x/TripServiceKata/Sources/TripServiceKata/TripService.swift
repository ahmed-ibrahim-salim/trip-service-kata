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
                tripList = try! TripDAO.findTripsByUser(user)
            }
            return tripList
        } else {
            throw TripServiceErrorType.userNotLoggedIn
        }
    }

	func getLoggedUser() -> User? {
		try! UserSession.sharedInstance.getLoggedUser()
	}
}
