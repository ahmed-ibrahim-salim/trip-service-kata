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
        sut = nil
        super.tearDown()
    }

    func testLoggedOutUserCannotLogIn() {
        XCTAssertThrowsError(try sut?.getTripsByUser(User()))
    }

    func testLoggedInUserCanLogIn() {
        let user = User()
        stubbedUserSession?.stubbedUser = user
        stubbedUserSession?.stubbedIsUserLoggedIn = true

        XCTAssertNoThrow(try sut?.getTripsByUser(User()))
    }

    func testLoggedInUserWithNoFriendsHasNoTrips() {
        let user = User()
        stubbedUserSession?.stubbedUser = user
        stubbedUserSession?.stubbedIsUserLoggedIn = true
        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, nil)
    }

    func testUserHasAFriendCanSeeFriendsTrips() {
        let user = User()
        let trip = Trip()
        stubbedUserSession?.stubbedUser = user
        stubbedUserSession?.stubbedIsUserLoggedIn = true
        tripDAOStub?.stubbedTrips = [trip]

        user.addFriend(user)

        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, 1)
    }
}

class UserSessionStub: UserSession {
    var stubbedIsUserLoggedIn: Bool = false
    var stubbedUser: User?

    override func isUserLoggedIn(_: User) throws -> Bool {
        stubbedIsUserLoggedIn
    }

    override func getLoggedUser() throws -> User? {
        stubbedUser
    }
}

class TripDAOStub: TripDAO {
    var stubbedTrips: [Trip]?
    override func findTripsByUser(_: User) throws -> [Trip]? {
        stubbedTrips
    }
}
