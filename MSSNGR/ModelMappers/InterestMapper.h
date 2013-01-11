//
//  InterestMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
#import "Interest.h"
#import "API.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@protocol InterestMapperCallBacks
@optional
- (void)updateUserInterestsSucceeded:(Result *)result;
- (void)updateUserInterestsFailed:(Result *)result;
- (void)getUserInterestsSucceeded:(Result *)result;
- (void)getUserInterestsFailed:(Result *)result;
- (void)getAllInterestsSucceeded:(Result *)result;
- (void)getAllInterestsFailed:(Result *)result;
@end

@interface InterestMapper : NSObject{
    ASIFormDataRequest *updateUserInterestAPI;
    ASIHTTPRequest *getUserInterestsAPI;
    ASIHTTPRequest *getAllInterestsAPI;
    id _target;
}
@property(nonatomic,assign) id target;
-(void) updateUserInterests :(NSString *)token :(NSArray *)interests;
-(void) getUserInterests :(NSString *)token;
-(void) getAllInterests;


-(void) updateUserInterestsSucceeded:(ASIFormDataRequest *)request;
-(void) updateUserInterestsFailed:(ASIFormDataRequest *)request;
-(void) getUserInterestsSucceeded:(ASIHTTPRequest *)request;
-(void) getUserInterestsFailed:(ASIHTTPRequest *)request;
-(void) getAllInterestsSucceeded:(ASIHTTPRequest *)request;
-(void) getAllInterestsFailed:(ASIHTTPRequest *)request;
@end
