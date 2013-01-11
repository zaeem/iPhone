//
//  DirectoryMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"
#import "JSON.h"
#import "Result.h"
#import "ASIHTTPRequest.h"
@protocol DirectoryMapperCallBacks
@optional
- (void)getUserDirectoriesSucceeded:(Result *)result;
- (void)getUserDirectoriesFailed:(Result *)result;
@end

@interface DirectoryMapper : NSObject{
    ASIHTTPRequest *getuserDirectoriesAPI;
    id _target;
}
@property(nonatomic,retain) id target;
-(void) getUserDirectories :(NSString *)token;

-(void) getUserDirectoriesSucceeded:(ASIHTTPRequest *)request;
-(void) getUserDirectoriesFailed:(ASIHTTPRequest *)request;
@end
