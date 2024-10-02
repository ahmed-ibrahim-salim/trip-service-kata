@testable import TripServiceKata
import XCTest

class TripServiceKataTests: XCTestCase {
    var sut: TestableTripService?

    override func setUp() {
        sut = TestableTripService()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testLoggedOutUserCannotLogIn() {
        XCTAssertThrowsError(try sut?.getTripsByUser(User()))
    }

    func testLoggedInUserWithNoFriendsHasNoTrips() {
        let user = User()
        sut?.user = user
        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, nil)
    }

    func testUserWithFriend() {
        let user = User()
        // let friend = User()
        user.addFriend(user)
        sut?.user = user
        let trips = try! sut?.getTripsByUser(user)

        XCTAssertEqual(trips?.count, 1)
    }
}

class TestableTripService: TripService {
    var user: User?
    override func getLoggedUser() -> User? { user }
    override func findTripsByUser(_: User) -> [Trip]? { nil }
}
