import Foundation

class TripDAO {
    class func findTripsByUser(_: User) throws -> [Trip]? {
        throw UnitTestErrorType.dependendClassCallDuringUnitTest
    }

    func findTripsByUser(_: User) throws -> [Trip]? {
        throw UnitTestErrorType.dependendClassCallDuringUnitTest
    }
}
