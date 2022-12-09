//
//  ImageInfoDetail.swift
//  NASAGalleryAppTests
//
//  Created by Saravana kumar on 10/12/22.
//

import XCTest

struct URLValidator {
    enum Error: Swift.Error {
        case emptyURLKey
    }

    func validate(urlKey: String) throws {
        guard !urlKey.isEmpty else {
            throw Error.emptyURLKey
        }
    }
}

class URLValidatorTests: XCTestCase {
    let validator = URLValidator()

    func testThrowingEmptyLicenseKeyError() {
        XCTAssertThrowsError(try validator.validate(urlKey: ""), "An empty url key error should be thrown") { error in
            /// We ensure the expected error is thrown.
            XCTAssertEqual(error as? URLValidator.Error, .emptyURLKey)
        }
    }

    func testNotThrowingLicenseErrorForNonEmptyKey() {
        XCTAssertNoThrow(try validator.validate(urlKey: "https://apod.nasa.gov/apod/image/1912/M94_Hubble_1002.jpg"), "Non-empty license key should pass")
    }
}

class ImageInfoDetail: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
