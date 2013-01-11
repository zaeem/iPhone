//
//  Result.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Result.h"

@implementation Result
@synthesize object=_object,status=_status,message=_message,didUseCachedData=_didUseCachedData;
-(void)dealloc{
    [_object release];
    [_status release];
    [_message release];
    _object=nil;
    _status=nil;
    _message=nil;
   [super dealloc];
}
@end
