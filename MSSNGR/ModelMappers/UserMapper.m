//
//  UserMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "UserMapper.h"
#import "Utility.h"
#import "Singleton.h"
@implementation UserMapper
@synthesize target=_target;
-(void)dealloc{
    _target=nil;
    if (newUserAPI) {
        [newUserAPI clearDelegatesAndCancel];
    }
    newUserAPI = nil;
    if (userCheckInAPI) {
        [userCheckInAPI clearDelegatesAndCancel];
    }
    userCheckInAPI = nil;
    if (userCheckOutAPI) {
        [userCheckOutAPI clearDelegatesAndCancel];
    }
    userCheckOutAPI = nil;
}
-(void) newUser{
    if (newUserAPI) {
        if ([newUserAPI isExecuting]) {
            return;
        }
    }
    newUserAPI = nil;
    newUserAPI = [API newUserAPI:self FinishSelector:@selector(createNewUserSucceeded:) FailSelector:@selector(createNewUserFailed:)];
    [newUserAPI startAsynchronous];
}
-(void) checkIn:(NSString *)token :(NSNumber * )property_id{
    [[Singleton sharedSingleton]clearAllData];
    if (userCheckInAPI) {
        if ([userCheckInAPI isExecuting]) {
            return;
        }
    }
    userCheckInAPI = nil;
	userCheckInAPI = [API userCheckIn:self Token:token PropertyId:property_id FinishSelector:@selector(checkInUserSucceeded:) FailSelector:@selector(checkInUserFailed:)];
    [userCheckInAPI startAsynchronous];
}
-(void) checkOut:(NSString *)token :(NSNumber *)property_id{
    [[Singleton sharedSingleton]clearAllData];
    if (userCheckOutAPI) {
        if ([userCheckOutAPI isExecuting]) {
            return;
        }
    }
    userCheckOutAPI = nil;
    userCheckOutAPI = [API userCheckOut:self Token:token PropertyId:property_id FinishSelector:@selector(checkOutUserSucceeded:) FailSelector:@selector(checkOutUserFailed:)];
    [userCheckOutAPI startAsynchronous];
}
-(void) createNewUserSucceeded:(ASIFormDataRequest *)request{
    newUserAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    
    NSDictionary *userDic = [data valueForKey:@"user"];
    if (userDic!=nil) {
        User *user = [[User alloc]init];
        user.token = [Utility checkNullValues:[userDic valueForKey:@"token"]];
        Result *result = [[[Result alloc]init]autorelease];
        result.status=@"Success";
        result.message=@"";
        result.object = user;
        [user release];
        [_target createNewUserSucceeded:result];
    }else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
        result.object = nil;
        [_target createNewUserFailed:result];   
    }
}
-(void) createNewUserFailed:(ASIFormDataRequest *)request
{
    newUserAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    [contents release];
    [jsonParser release];
    
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
   [_target createNewUserFailed:result];
}

-(void) checkInUserSucceeded:(ASIFormDataRequest *)request{
    userCheckInAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    if ([[data valueForKey:@"status"] isEqualToString:@"success"]) {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=@"";
        result.object = nil;
        [_target checkInUserSucceeded:result];
    }else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
        result.object = nil;
        [_target checkInUserFailed:result];   
    }
}
-(void) checkInUserFailed:(ASIFormDataRequest *)request{
    userCheckInAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    //[_target checkInUserSucceeded:result];
    [_target checkInUserFailed:result];
}

-(void) checkOutUserSucceeded:(ASIFormDataRequest *)request{
    userCheckOutAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    if ([[data valueForKey:@"status"] isEqualToString:@"success"]) {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=@"";
        result.object = nil;
        [_target checkOutUserSucceeded:result];
    }else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
        result.object = nil;
        [_target checkOutUserFailed:result]; 
    }
}
-(void) checkOutUserFailed:(ASIFormDataRequest *)request{
    userCheckOutAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target checkOutUserFailed:result];
}

@end
