//
//  ConventionMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ConventionMapper.h"
#import "Convention.h"
#import "Utility.h"
@implementation ConventionMapper

@synthesize target=_target;

-(void)dealloc
{
    _target = nil;
    if (joiningConventionAPI) 
	{
        [joiningConventionAPI clearDelegatesAndCancel];
    }
    joiningConventionAPI = nil;
	
	if (checkOutConventionAPI)
	{
		[checkOutConventionAPI clearDelegatesAndCancel];
	}
	checkOutConventionAPI = nil;
	
	if (showUserConventionAPI)
	{
		[showUserConventionAPI clearDelegatesAndCancel];
	}
	showUserConventionAPI = nil;
}

-(void)joiningConvention :(NSString *)token :(NSString *)convention_code
{
	if (joiningConventionAPI)
	{
        if ([joiningConventionAPI isExecuting]) {
            return;
        }  
    }
    joiningConventionAPI = [API joiningConventionAPI:self Token:token ConventionCode:convention_code FinishSelector:@selector(joiningConventionSucceeded:) FailSelector:@selector(joiningConventionFailed:)];
    [joiningConventionAPI startAsynchronous];
}

-(void)checkOutConvention :(NSString *)token Code:(NSString *)code 
{
	if (checkOutConventionAPI)
	{
		if ([checkOutConventionAPI isExecuting]) {
            return;
        } 
	}
	
	checkOutConventionAPI = [API checkOutConventionAPI:self Token:token Code:code FinishSelector:@selector(checkOutConventionSucceeded:) FailSelector:@selector(checkOutConventionFailed:)];
	[checkOutConventionAPI startAsynchronous];
}

-(void)showUserConvention :(NSString *)token
{
	if (showUserConventionAPI)
	{
		if ([showUserConventionAPI isExecuting]) {
            return;
        } 
	}
	
	showUserConventionAPI = [API showUserConventionAPI:self Token:token FinishSelector:@selector(showUserConventionSucceeded:) FailSelector:@selector(showUserConventionFailed:)];
	[showUserConventionAPI startAsynchronous];
}


-(void)joiningConventionSucceeded:(ASIFormDataRequest *)request
{
	joiningConventionAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    
	if ([[data valueForKey:@"status"] isEqualToString:@"success"]) 
	{
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data valueForKey:@"status"];
        result.message=@"";
        result.object = nil;
        [_target joiningConventionSucceeded:result];
    }
	else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data valueForKey:@"status"];
        result.message=[data valueForKey:@"message"];
        result.object = nil;
        [_target joiningConventionFailed:result];   
    }
}

-(void)joiningConventionFailed:(ASIFormDataRequest *)request
{
	joiningConventionAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target joiningConventionFailed:result];
}

-(void)checkOutConventionSucceeded:(ASIHTTPRequest *)request
{
	checkOutConventionAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    
	if ([[data valueForKey:@"status"] isEqualToString:@"success"]) 
	{
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data valueForKey:@"status"];
        result.message=@"";
        result.object = nil;
        [_target checkOutConventionSucceeded:result];
    }
	else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data valueForKey:@"status"];
        result.message=[data valueForKey:@"message"];
        result.object = nil;
        [_target checkOutConventionFailed:result];   
    }
}


-(void)checkOutConventionFailed:(ASIHTTPRequest *)request
{
	checkOutConventionAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target checkOutConventionFailed:result];
}


-(void)showUserConventionSucceeded:(ASIHTTPRequest *)request
{
    showUserConventionAPI=nil;
	SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
	if ([data isKindOfClass:[NSArray class]]) 
	{
         NSMutableArray *conventions = [[NSMutableArray alloc]init];
        for (NSDictionary *dictionary in data) {
            if ([dictionary isKindOfClass:[NSDictionary class]]) {
                if ([dictionary valueForKey:@"convention"]) {
                    [conventions addObject:[Convention dictionaryToObject:[dictionary valueForKey:@"convention"]]];
                }
            }
        }
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data valueForKey:@"status"];
        result.message=@"";
        result.object = conventions;
        [_target showUserConventionSucceeded:result];
        [conventions release];
    }
	else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
        result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
        result.object = nil;
        [_target showUserConventionFailed:result];   
    }	
}

-(void)showUserConventionFailed:(ASIHTTPRequest *)request
{
	showUserConventionAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    Result *result = [[[Result alloc]init]autorelease];
    result.status=[Utility checkNullValues:[data valueForKey:@"status"]];
    result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
    result.object = nil;
    [_target showUserConventionFailed:result];
}

@end
