//
//  Interest.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Interest.h"
#import "Utility.h"
@implementation Interest
@synthesize Id=_Id;
@synthesize name=_name;
@synthesize selected=_selected;
-(void)dealloc{
    [_name release];
    [_Id release];
    _Id = nil;
    _name = nil;
    [super dealloc];
}
+(Interest *)dictionaryToObject :(NSDictionary *)dictionary{
    Interest *interest = [[[Interest alloc]init] autorelease];
    interest.Id = [Utility checkNSnumberValue:[dictionary valueForKey:@"id"]];
    interest.name = [Utility checkNullValues:[dictionary valueForKey:@"name"]];
    return interest;
}
@end
