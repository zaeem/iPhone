//
//  InterestMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "InterestMapper.h"
#import "Singleton.h"
#import "User.h"
#import "Utility.h"
#import "InterestGroup.h"
@implementation InterestMapper
@synthesize target=_target;
-(void)dealloc{
    _target=nil;
    if (updateUserInterestAPI) {
        [updateUserInterestAPI clearDelegatesAndCancel];
    }
    updateUserInterestAPI = nil;
    
    if (getUserInterestsAPI) {
        [getUserInterestsAPI clearDelegatesAndCancel];
    }
    getUserInterestsAPI = nil;
    
    if (getAllInterestsAPI) {
        [getAllInterestsAPI clearDelegatesAndCancel];
    }
    getAllInterestsAPI = nil;
}
-(void) updateUserInterests :(NSString *)token :(NSArray *)interests{
    if (updateUserInterestAPI) {
        if ([updateUserInterestAPI isExecuting]) {
            return;
        }
    }
    updateUserInterestAPI = [API updateUserInterests:self Token:token Interests:interests FinishSelector:@selector(updateUserInterestsSucceeded:) FailSelector:@selector(updateUserInterestsFailed:)];
    [updateUserInterestAPI startAsynchronous];
}
-(void) getUserInterests :(NSString *)token{
    if (getUserInterestsAPI) {
        if ([getUserInterestsAPI isExecuting]) {
            return;
        }
    }
    getUserInterestsAPI = [API getUserInterests:self Token:token FinishSelector:@selector(getUserInterestsSucceeded:) FailSelector:@selector(getUserInterestsFailed:)];
    [getUserInterestsAPI startAsynchronous];
}

-(void) getAllInterests{
    if (getAllInterestsAPI) {
        if ([getAllInterestsAPI isExecuting]) {
            return;
        }
    }
    getAllInterestsAPI = [API getAllInterests:self FinishSelector:@selector(getAllInterestsSucceeded:) FailSelector:@selector(getAllInterestsFailed:)];
    [getAllInterestsAPI startAsynchronous];
}

-(void) updateUserInterestsSucceeded:(ASIFormDataRequest *)request{
    updateUserInterestAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSDictionary *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    if ([[data objectForKey:@"status"] isEqualToString:@"success"]) {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data objectForKey:@"status"];
        result.message=@"";
        result.object = nil;
        [_target updateUserInterestsSucceeded:result];
    }else
    {
        Result *result = [[[Result alloc]init]autorelease];
        result.status=[data objectForKey:@"status"];
        result.message=[data objectForKey:@"message"];
        result.object = nil;
        [_target updateUserInterestsFailed:result];   
    }
}
-(void) updateUserInterestsFailed:(ASIFormDataRequest *)request{
    updateUserInterestAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target updateUserInterestsFailed:result];
}
-(void) getUserInterestsSucceeded:(ASIHTTPRequest *)request{
        getUserInterestsAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    NSMutableArray *interests = [[NSMutableArray alloc]init];
    for (NSDictionary *obj in data) {
        [interests addObject:[Interest dictionaryToObject:[obj objectForKey:@"interest"]]];
    }
    Result *result = [[[Result alloc]init] autorelease];
    result.object = interests;
    result.status=@"success";
    result.message=@"";
    [interests release];
    [_target getUserInterestsSucceeded:result];
}
-(void) getUserInterestsFailed:(ASIHTTPRequest *)request{
    getUserInterestsAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target getUserInterestsFailed:result];
}
-(void) getAllInterestsSucceeded:(ASIHTTPRequest *)request{
    getAllInterestsAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSArray *data = [jsonParser objectWithString:contents];
    [contents release];
    [jsonParser release];
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)data;
        Result *result = [[[Result alloc]init] autorelease];
        result.object = nil;
        result.status=[Utility checkNullValues:[dic objectForKey:@"status"]];
        result.message=[Utility checkNullValues:[dic objectForKey:@"message"]];
        [_target getAllInterestsFailed:result];
        
    }else{
    NSMutableArray *interestsGroups = [[NSMutableArray alloc]init];
    for (NSDictionary *obj in data  ) {
        obj = [obj objectForKey:@"group"];
        InterestGroup *interestGroup = [[InterestGroup alloc]init];
        NSMutableArray *temp = [[NSMutableArray alloc]init];
        interestGroup.interests = temp;
        [temp release];
        interestGroup.name = [obj objectForKey:@"name"];
        NSArray *interestsArray = [obj objectForKey:@"interests"];
        for (NSDictionary *intrest_Dict in interestsArray  ) {
            Interest *interest = [[Interest alloc]init];
            interest.Id = [Utility checkNSnumberValue:[intrest_Dict objectForKey:@"id"]];
            interest.name = [Utility checkNullValues:[intrest_Dict objectForKey:@"name"]];
            interest.selected=![Singleton sharedSingleton].appUser.returningUser;
            [interestGroup.interests addObject:interest];
            [interest release];
        }
        [interestsGroups addObject:interestGroup];
        [interestGroup release];
    }
        Result *result = [[[Result alloc]init] autorelease];
        result.object = interestsGroups;
        [interestsGroups release];
        result.status=@"success";
        result.message=@"";
        if (_target) {
            if ([_target respondsToSelector:@selector(getAllInterestsSucceeded:)]) {
                 [_target getAllInterestsSucceeded:result];
            }
        }
    }
}
-(void) getAllInterestsFailed:(ASIHTTPRequest *)request{
    getAllInterestsAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target getAllInterestsFailed:result];
}

@end
