//
//  ConventionMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
#import "API.h"
#import "JSON.h"
#import "MSSNMessage.h"
#import "ASIHTTPRequest.h"


@protocol ConventionMapperCallBacks
@optional

-(void)joiningConventionSucceeded:(Result *)result;
-(void)joiningConventionFailed:(Result *)result;

-(void)checkOutConventionSucceeded:(Result *)result;
-(void)checkOutConventionFailed:(Result *)result;

-(void)showUserConventionSucceeded:(Result *)result;
-(void)showUserConventionFailed:(Result *)result;

@end

@interface ConventionMapper : NSObject
{
	ASIFormDataRequest *joiningConventionAPI;
	ASIHTTPRequest *checkOutConventionAPI;
	ASIHTTPRequest *showUserConventionAPI;
	id _target;
}

@property(nonatomic,retain) id target;

-(void)joiningConvention :(NSString *)token :(NSString *)convention_code;
-(void)checkOutConvention :(NSString *)token Code:(NSString *)code;
-(void)showUserConvention :(NSString *)token;


-(void)joiningConventionSucceeded:(ASIFormDataRequest *)request;
-(void)joiningConventionFailed:(ASIFormDataRequest *)request;

-(void)checkOutConventionSucceeded:(ASIHTTPRequest *)request;
-(void)checkOutConventionFailed:(ASIHTTPRequest *)request;

-(void)showUserConventionSucceeded:(ASIHTTPRequest *)request;
-(void)showUserConventionFailed:(ASIHTTPRequest *)request;

@end
