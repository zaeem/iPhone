//
//  UserMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
#import "User.h"
#import "API.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@protocol UserMapperCallBacks
@optional
- (void)createNewUserSucceeded:(Result *)result;
- (void)createNewUserFailed:(Result *)result;
- (void)checkInUserSucceeded:(Result *)result;
- (void)checkInUserFailed:(Result *)result;
- (void)checkOutUserSucceeded:(Result *)result;
- (void)checkOutUserFailed:(Result *)result;
@end
@interface UserMapper : NSObject{
    ASIFormDataRequest *newUserAPI;
    ASIFormDataRequest *userCheckInAPI;
    ASIFormDataRequest *userCheckOutAPI;
    id _target;
}
@property(nonatomic,assign) id target;
-(void) newUser;
-(void) checkIn :(NSString *)token :(NSNumber * )property_id;
-(void) checkOut :(NSString *)token :(NSNumber * )property_id;
-(void) createNewUserSucceeded:(ASIFormDataRequest *)request;
-(void) createNewUserFailed:(ASIFormDataRequest *)request;
-(void) checkInUserSucceeded:(ASIFormDataRequest *)request;
-(void) checkInUserFailed:(ASIFormDataRequest *)request;
-(void) checkOutUserSucceeded:(ASIFormDataRequest *)request;
-(void) checkOutUserFailed:(ASIFormDataRequest *)request;
@end
