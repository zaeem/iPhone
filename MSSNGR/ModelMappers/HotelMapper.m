//
//  HotelMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "HotelMapper.h"
#import "Utility.h"
@implementation HotelMapper
@synthesize target=_target;
-(void)dealloc{
    _target = nil;
    if (getAllHotelsAPI) {
        [getAllHotelsAPI clearDelegatesAndCancel];
    }
    getAllHotelsAPI = nil;
    if (getNearByHotelsAPI) {
        [getNearByHotelsAPI clearDelegatesAndCancel];
    }
    getNearByHotelsAPI = nil;
}
-(void) getAllHotels:(float)lat lng:(float)lng{
    if (getAllHotelsAPI) {
        if ([getAllHotelsAPI isExecuting]) {
            return;
        }
    }
    getAllHotelsAPI = [API getAllHotels:self lat:lat lng:lng FinishSelector:@selector(getAllHotelsSucceeded:) FailSelector:@selector(getAllHotelsFailed:)];
    [getAllHotelsAPI startAsynchronous];
}

-(void) getNearByHotels:(float)lat lng:(float)lng{
    if (getNearByHotelsAPI) {
        if ([getNearByHotelsAPI isExecuting]) {
            return;
        }    
    }
    getNearByHotelsAPI = [API getNearByHotels:self lat:lat lng:lng FinishSelector:@selector(getNearByHotelsSucceeded:) FailSelector:@selector(getNearByHotelsFailed:)];
    [getNearByHotelsAPI startAsynchronous];
}

-(void) getAllHotelsSucceeded:(ASIHTTPRequest *)request{
	getAllHotelsAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    if ([data isKindOfClass:[NSDictionary class]]) {
        Result *result = [[[Result alloc]init] autorelease];
        result.object = nil;
        result.status=[Utility checkNullValues:[data valueForKey:@"status"]];        result.message=[Utility checkNullValues:[data valueForKey:@"message"]];
        [_target getAllHotelsFailed:result];
        
    }else{
    NSMutableArray *hotels = [[NSMutableArray alloc]init];
    for (NSDictionary *obj in data) {
        [hotels addObject:[Hotel dictionaryToObject:[obj valueForKey:@"property"]]];
    }
        Result *result = [[[Result alloc]init] autorelease];
        result.object = hotels;
        [hotels release];
        result.status=@"success";
        result.message=@"";
        [_target getAllHotelsSucceeded:result];
    }
}
-(void) getAllHotelsFailed:(ASIHTTPRequest *)request{
	getAllHotelsAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status=@"failed";
    result.message=@"";
    [_target getAllHotelsFailed:result];
}

-(void) getNearByHotelsSucceeded:(ASIHTTPRequest *)request{
	getNearByHotelsAPI = nil;
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
        [_target getNearByHotelsFailed:result];

    }else{
        NSMutableArray *hotels = [[NSMutableArray alloc]init];
        for (NSDictionary *obj in data) {
            [hotels addObject:[Hotel dictionaryToObject:[obj valueForKey:@"property"]]];
        }
        Result *result = [[[Result alloc]init] autorelease];
        result.object = hotels;
        [hotels release];
        result.status=@"success";
        result.message=@"";
        [_target getNearByHotelsSucceeded:result];
    }
}
-(void) getNearByHotelsFailed:(ASIHTTPRequest *)request{
	getNearByHotelsAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status=@"error";
    result.message=@"";
    [_target getNearByHotelsFailed:result];
}

@end
