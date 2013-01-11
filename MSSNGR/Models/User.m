//
//  User.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize token=_token,returningUser=_returningUser;
-(void)dealloc{
    [_token release];
    _token = nil;
    [super dealloc];
}
@end
