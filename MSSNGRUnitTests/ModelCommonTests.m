//
//  ModelCommonTests.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 1/23/12.
//  Copyright (c) 2012 Coeus Solutions. All rights reserved.
//

#import "ModelCommonTests.h"
#import "Hotel.h"
#import "Convention.h"
#import "MSSNMessage.h"
#import "Page.h"
@implementation ModelCommonTests

// All code under test must be linked into the Unit Test bundle
- (void)setUp
{
    [super setUp];
    data = [[NSMutableDictionary alloc]init];
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    [data release];
    [super tearDown];
}
-(void)testModelWithNullValues{
    [data setValue:nil forKey:@"id"];
    [data setValue:nil forKey:@"lat"];
    [data setValue:nil forKey:@"lng"];
    Hotel *hotel = [Hotel dictionaryToObject:data];
    Convention *convention = [Convention dictionaryToObject:data];
    MSSNMessage *message = [MSSNMessage dictionaryToObject:data];
    Page *page = [Page dictionaryToObject:data];
    
    STAssertNil(hotel.Id,@"null string should be equal to nil");
    STAssertNil(hotel.lat,@"null string should be equal to nil");
    STAssertNil(hotel.lng,@"null string should be equal to nil");
    STAssertFalse([hotel validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(convention.Id,@"null string should be equal to nil");
    STAssertNil(convention.lat,@"null string should be equal to nil");
    STAssertNil(convention.lng,@"null string should be equal to nil");
    STAssertFalse([convention validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(message.Id,@"null string should be equal to nil");
    STAssertNil(message.lat,@"null string should be equal to nil");
    STAssertNil(message.lng,@"null string should be equal to nil");
    STAssertFalse([message validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(page.Id,@"null string should be equal to nil");
    STAssertNil(page.lat,@"null string should be equal to nil");
    STAssertNil(page.lng,@"null string should be equal to nil");
    STAssertFalse([page validCoordinates],@"coordinates should be invalid");
}
-(void)testModelWithEmptyValues{
    [data setValue:@"" forKey:@"id"];
    [data setValue:@"" forKey:@"lat"];
    [data setValue:@"" forKey:@"lng"];
    
    Hotel *hotel = [Hotel dictionaryToObject:data];
    Convention *convention = [Convention dictionaryToObject:data];
    MSSNMessage *message = [MSSNMessage dictionaryToObject:data];
    Page *page = [Page dictionaryToObject:data];
    
    STAssertNil(hotel.Id,@"empty string should be equal to nil");
    STAssertNil(hotel.lat, @"empty string should be equal to nil");
    STAssertNil(hotel.lng, @"empty string should be equal to nil");
    STAssertFalse([hotel validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(convention.Id,@"empty string should be equal to nil");
    STAssertNil(convention.lat, @"empty string should be equal to nil");
    STAssertNil(convention.lng, @"empty string should be equal to nil");
    STAssertFalse([convention validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(message.Id,@"empty string should be equal to nil");
    STAssertNil(message.lat, @"empty string should be equal to nil");
    STAssertNil(message.lng, @"empty string should be equal to nil");
    STAssertFalse([message validCoordinates],@"coordinates should be invalid");
    
    STAssertNil(page.Id,@"empty string should be equal to nil");
    STAssertNil(page.lat, @"empty string should be equal to nil");
    STAssertNil(page.lng, @"empty string should be equal to nil");
    STAssertFalse([page validCoordinates],@"coordinates should be invalid");
}
-(void)testModelWithItntegerValues{
    [data setValue:@"12" forKey:@"id"];
    [data setValue:@"12" forKey:@"lat"];
    [data setValue:@"12" forKey:@"lng"];
    
    Hotel *hotel = [Hotel dictionaryToObject:data];
    Convention *convention = [Convention dictionaryToObject:data];
    MSSNMessage *message = [MSSNMessage dictionaryToObject:data];
    Page *page = [Page dictionaryToObject:data];
    
    STAssertEquals([hotel.Id intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([hotel.lat intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([hotel.lng intValue],12, @"integer value should be parsed to int value");
    STAssertTrue([hotel validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([convention.Id intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([convention.lat intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([convention.lng intValue],12, @"integer value should be parsed to int value");
    STAssertTrue([convention validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([message.Id intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([message.lat intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([message.lng intValue],12, @"integer value should be parsed to int value");
    STAssertTrue([message validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([page.Id intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([page.lat intValue],12, @"integer value should be parsed to int value");
    STAssertEquals([page.lng intValue],12, @"integer value should be parsed to int value");
    STAssertTrue([page validCoordinates],@"coordinates should be valid");
}
-(void)testModelWithDoubleValues{
    [data setValue:@"12.434567" forKey:@"id"];
    [data setValue:@"12.434567" forKey:@"lat"];
    [data setValue:@"12.434567" forKey:@"lng"];
    
    Hotel *hotel = [Hotel dictionaryToObject:data];
    Convention *convention = [Convention dictionaryToObject:data];
    MSSNMessage *message = [MSSNMessage dictionaryToObject:data];
    Page *page = [Page dictionaryToObject:data];

    
    STAssertEquals([hotel.Id doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([hotel.lat doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([hotel.lng doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertTrue([hotel validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([convention.Id doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([convention.lat doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([convention.lng doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertTrue([convention validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([message.Id doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([message.lat doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([message.lng doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertTrue([message validCoordinates],@"coordinates should be valid");
    
    STAssertEquals([page.Id doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([page.lat doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertEquals([page.lng doubleValue],12.434567, @"double value should be parsed to double value");
    STAssertTrue([page validCoordinates],@"coordinates should be valid");
}

@end
