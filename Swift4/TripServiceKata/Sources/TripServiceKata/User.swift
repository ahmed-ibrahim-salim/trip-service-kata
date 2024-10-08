import Foundation

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs === rhs
    }
}

class User {
    private var userTrips: [Trip] = []
    private var friends: [User] = []

    func getFriends() -> [User] {
        return friends
    }

    func addFriend(_ friend: User) {
        friends.append(friend)
    }

    func trips() -> [Trip] {
        return userTrips
    }

    func addTrip(_ trip: Trip) {
        userTrips.append(trip)
    }

    func isMyFriend(_ user: User) -> Bool { getFriends().contains(user) }
}
