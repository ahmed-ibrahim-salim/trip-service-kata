@testable import TripServiceKata
import XCTest

class TripServiceKataTests: XCTestCase {
    var sut: TripService?
    var stubbedUserSession: UserSessionStub?
    var tripDAOStub: TripDAOStub?

    override func setUp() {
        stubbedUserSession = UserSessionStub()
        tripDAOStub = TripDAOStub()
        sut = TripService(userSession: stubbedUserSession, tripDAO: tripDAOStub)
        super.setUp()
    }

    override func tearDown() {
        stubbedUserSession = nil
        tripDAOStub = nil
        sut = nil
        super.tearDown()
    }

    func testLoggedOutUserCannotLogIn() {
        let user = User()
        XCTAssertThrowsError(try sut?.getTripsByUser(user))
    }

    func testLoggedInUserCanLogIn() {
        let user = User()
        let friend = User()
        stubbedUserSession?.stubbedLoggedInUser = friend

        XCTAssertNoThrow(try sut?.getTripsByUser(user))
    }

    func testLoggedInUserWithNoFriendsHasNoTrips() {
        let user = User()
        let friend = User()
        stubbedUserSession?.stubbedLoggedInUser = friend

        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, nil)
    }

    func testUserHasAFriendCanSeeFriendTrips() {
        let user = User()
        let friend = User()
        let trip = Trip()
        user.addFriend(friend)
        user.addTrip(trip)
        stubbedUserSession?.stubbedLoggedInUser = friend

        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, 1)
    }
}

class UserSessionStub: UserSession {
    var stubbedLoggedInUser: User?

    override func isUserLoggedIn(_: User) throws -> Bool {
        stubbedLoggedInUser != nil
    }

    override func getLoggedUser() throws -> User? {
        stubbedLoggedInUser
    }
}

class TripDAOStub: TripDAO {
    override func findTripsByUser(_ user: User) throws -> [Trip]? {
        user.trips()
    }
}
