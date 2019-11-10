import XCTest
@testable import BinaryUtilities

final class BinaryUtilitiesTests: XCTestCase {
    func testArrayDataSource() {
        let data: [UInt8] = [0, 3, 5, 7, 8, 3, 1]
        let dataSource = ArrayDataSource(buffer: data)
        XCTAssertEqual(dataSource.read(), 0)
        XCTAssertEqual(dataSource.read(), 3)
        XCTAssertEqual(dataSource.read(), 5)
        XCTAssertEqual(dataSource.read(), 7)
        XCTAssertEqual(dataSource.read(), 8)
        XCTAssertEqual(dataSource.read(), 3)
        
        XCTAssertTrue(dataSource.hasData)
        XCTAssertEqual(dataSource.read(), 1)
        
        XCTAssertFalse(dataSource.hasData)
    }
    func testStreamDataSource() {
        let array: [UInt8] = [0, 3, 5, 7, 8, 3, 1]
        let data = Data(array)
        let dataSource = StreamDataSource(data: data)
        XCTAssertEqual(dataSource.read(), 0)
        XCTAssertEqual(dataSource.read(), 3)
        XCTAssertEqual(dataSource.read(), 5)
        XCTAssertEqual(dataSource.read(), 7)
        XCTAssertEqual(dataSource.read(), 8)
        XCTAssertEqual(dataSource.read(), 3)
        
        XCTAssertTrue(dataSource.hasData)
        XCTAssertEqual(dataSource.read(), 1)
        
        XCTAssertFalse(dataSource.hasData)
    }
    func testArrayDataSourceOffset() {
        let data = [UInt8](repeating: 12, count: 100)
        let dataSource = ArrayDataSource(buffer: data)
        for i in 0..<data.count {
            XCTAssertEqual(i, dataSource.offset)
            dataSource.advance()
        }
    }
    func testStreamDataSourceOffset() {
        let array = [UInt8](repeating: 12, count: 100)
        let data = Data(array)
        let dataSource = StreamDataSource(data: data)
        for i in 0..<data.count {
            XCTAssertEqual(i, dataSource.offset)
            dataSource.advance()
        }
    }

    static var allTests = [
        ("testArrayDataSource", testArrayDataSource),
        ("testStreamDataSource", testStreamDataSource),
        ("testArrayDataSourceOffset", testArrayDataSourceOffset),
        ("testStreamDataSourceOffset", testStreamDataSourceOffset)
    ]
}
