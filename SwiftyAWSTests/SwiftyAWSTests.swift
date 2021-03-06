//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

import XCTest
@testable import SwiftyAWS

class SwiftyAWSTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUploadUsingSingleton() {
        
        let expected = expectation(description: "Should upload to S3")

        SwiftyAWS.main.bucketName = "crash-chat"
        SwiftyAWS.main.configure(type: .USEast1, identity: "xxxxx-xxxx--xxxxx-xxxx-xxxxx-xxxxx")
        
        let bundle = Bundle.init(for: SwiftyAWSTests.self)
        let image = UIImage(named: "cheetah.jpg", in: bundle, compatibleWith: nil)
        
        SwiftyAWS.main.upload(image: image, type: .png, name: .effient, permission: .publicReadWrite) { (path, error) in
           
            if error != nil {
                print(error!)
                XCTAssertTrue(false)
            }
            
            XCTAssertTrue(true, path!)
            expected.fulfill()
        }

        waitForExpectations(timeout: 45) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            XCTAssert(true, "Successfully uploaded to AWS")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
