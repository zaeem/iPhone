//
//  DirectoryMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "DirectoryMapper.h"
#import "Folder.h"
#import "Page.h"
#import "Utility.h"
@implementation DirectoryMapper
@synthesize target=_target;
-(void)dealloc{
    _target = nil;
    if (getuserDirectoriesAPI) {
        [getuserDirectoriesAPI clearDelegatesAndCancel];
    }
    getuserDirectoriesAPI = nil;
}
-(void) getUserDirectories :(NSString *)token{
    if (getuserDirectoriesAPI) {
        if ([getuserDirectoriesAPI isExecuting]) {
            return;
        }
    }
    getuserDirectoriesAPI = [API getUserDirectories:self Token:token FinishSelector:@selector(getUserDirectoriesSucceeded:) FailSelector:@selector(getUserDirectoriesFailed:)];
    [getuserDirectoriesAPI startAsynchronous];
}

-(void) getUserDirectoriesFailed:(ASIHTTPRequest *)request{
    getuserDirectoriesAPI = nil;
    Result *result = [[[Result alloc]init] autorelease];
    result.object = nil;
    result.status= @"error";
    result.message= @"";
    [_target getUserDirectoriesFailed:result];
}
-(void) getUserDirectoriesSucceeded:(ASIHTTPRequest *)request{
    getuserDirectoriesAPI = nil;
    SBJSON *jsonParser = [SBJSON new];
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    NSObject *data = [jsonParser objectWithString:contents];
    if ([data isKindOfClass:[NSDictionary class]]) {
        Result *result = [[[Result alloc]init] autorelease];
        result.object = nil;
        result.status= [data valueForKey:@"status"];
        result.message= [data valueForKey:@"message"];
        [_target getUserDirectoriesFailed:result];
    }else{
        if ([data isKindOfClass:[NSArray class]]) {
            NSMutableArray *directories = [[NSMutableArray alloc]init];
            for (NSDictionary *obj in (NSArray *)data) {
                if ([obj valueForKey:@"folder"]!=nil) {
                    NSDictionary *folder = [obj valueForKey:@"folder"];
                    Folder *foldderObj=[[Folder alloc]init];
                    foldderObj.name = [folder valueForKey:@"name"];
                    foldderObj.title = [folder valueForKey:@"name"];
                    foldderObj.text = @"";
                    foldderObj.thumb = [Utility checkNullValues:[folder valueForKey:@"thumb"]];
                    if (![[foldderObj thumb] isEqualToString:@""]) {
                        [Utility downLoadImage:foldderObj.thumb];
                    }
                    NSArray *pages = [folder valueForKey:@"pages"];
                    NSMutableArray *pageObjects= [[NSMutableArray alloc]init];
                    for (NSDictionary *obj2 in pages) {
                        NSDictionary *page = [obj2 valueForKey:@"page"];
                        foldderObj.Id           = [Utility checkNSnumberValue:[page valueForKey:@"id"]];
                        [pageObjects addObject:[Page dictionaryToObject:[obj2 valueForKey:@"page"]]];
                    }
                    foldderObj.pages = pageObjects;
                    [pageObjects release];
                    [directories addObject:foldderObj];
                    [foldderObj release];
                }else{
                    if ([obj valueForKey:@"page"]!=nil) {
                        [directories addObject:[Page dictionaryToObject:[obj valueForKey:@"page"]]];
                    }
                }
            }
            Result *result = [[[Result alloc]init] autorelease];
            result.object = directories;
            [directories release];
            result.status=@"success";
            result.message=@"";
            result.didUseCachedData = request.didUseCachedResponse;
            [_target getUserDirectoriesSucceeded:result];
        }
    }
    [contents release];
    [jsonParser release];
}

@end
