//
//  MessageMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "MessageMapper.h"
#import "Utility.h"
@implementation MessageMapper
@synthesize target=_target;
-(void)dealloc{
    _target = nil;
    if (getuserMessagesAPI) {
        [getuserMessagesAPI clearDelegatesAndCancel];
    }
    getuserMessagesAPI = nil;
    if (getHotelMessagesAPI) {
        [getHotelMessagesAPI clearDelegatesAndCancel];
    }
    getHotelMessagesAPI = nil;
}
-(void) getUserMessages :(NSString *)token{
    if (getuserMessagesAPI) {
        if ([getuserMessagesAPI isExecuting]) {
            return;
        }
    }
    getuserMessagesAPI = [API getUserMessages:self Token:token FinishSelector:@selector(getUserMessagesSucceeded:) FailSelector:@selector(getUserMessagesFailed:)];
    [getuserMessagesAPI startAsynchronous];
}

-(void) getHotelMessages :(NSString *)token{
    if (getHotelMessagesAPI) {
        if ([getHotelMessagesAPI isExecuting]) {
            return;
        }
    }
    getHotelMessagesAPI = [API getHotelMessages:self Token:token FinishSelector:@selector(getHotelMessagesSucceeded:) FailSelector:@selector(getHotelMessagesFailed:)];
    [getHotelMessagesAPI startAsynchronous];
}

-(void) getUserMessagesFailed:(ASIHTTPRequest *)request{
    getuserMessagesAPI=nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target getUserMessagesFailed:result];
}
-(void) getUserMessagesSucceeded:(ASIHTTPRequest *)request{
    getuserMessagesAPI=nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
	if ([data isKindOfClass:[NSDictionary class]]) {
        Result *result = [[[Result alloc]init] autorelease];
        result.object = nil;
        result.status=[data valueForKey:@"status"];
        result.message=[data valueForKey:@"message"];
        [_target getUserMessagesFailed:result];
        
    }else{
        NSMutableArray *messages = [[NSMutableArray alloc]init];   
        for (NSDictionary *obj in data) {
            [messages addObject:[MSSNMessage dictionaryToObject:[obj valueForKey:@"message"]]];
        }
        Result *result = [[[Result alloc]init] autorelease];
        result.object = messages;
        [messages release];
        result.status=@"success";
        result.message=@"";
        result.didUseCachedData = request.didUseCachedResponse;
        [_target getUserMessagesSucceeded:result];
    }
}

-(void) getHotelMessagesFailed:(ASIHTTPRequest *)request{
    getHotelMessagesAPI=nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target getHotelMessagesFailed:result];
}
-(void) getHotelMessagesSucceeded:(ASIHTTPRequest *)request{
    getHotelMessagesAPI=nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
	if ([data isKindOfClass:[NSDictionary class]]) {
        Result *result = [[[Result alloc]init] autorelease];
        result.object = nil;
        result.status=[data valueForKey:@"status"];
        result.message=[data valueForKey:@"message"];
        [_target getHotelMessagesFailed:result];
        
    }else{
        NSMutableArray *messages = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in data) {
            [messages addObject:[MSSNMessage dictionaryToObject:[obj valueForKey:@"message"]]];
        }
        Result *result = [[[Result alloc]init] autorelease];
        result.object = messages;
        [messages release];
        result.status=@"success";
        result.message=@"";
        result.didUseCachedData = request.didUseCachedResponse;
        [_target getHotelMessagesSucceeded:result];
    }
}

@end
