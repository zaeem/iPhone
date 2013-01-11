//
//  ModelCommonTests.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 1/23/12.
//  Copyright (c) 2012 Coeus Solutions. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

@interface ModelCommonTests : SenTestCase{
    NSMutableDictionary *data;
}
-(void)testModelWithNullValues;
-(void)testModelWithEmptyValues;
-(void)testModelWithItntegerValues;
-(void)testModelWithDoubleValues;
@end
