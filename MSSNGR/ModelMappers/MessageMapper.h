//
//  MessageMapper.h
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
@protocol MessageMapperCallBacks
@optional
- (void)getUserMessagesSucceeded:(Result *)result;
- (void)getUserMessagesFailed:(Result *)result;
- (void)getHotelMessagesSucceeded:(Result *)result;
- (void)getHotelMessagesFailed:(Result *)result;
@end
@interface MessageMapper : NSObject{
    ASIHTTPRequest *getuserMessagesAPI;
    ASIHTTPRequest *getHotelMessagesAPI;
    id _target;
}
@property(nonatomic,retain) id target;

-(void) getUserMessages :(NSString *)token;
-(void) getHotelMessages :(NSString *)hotelId;

-(void) getUserMessagesFailed:(ASIHTTPRequest *)request;
-(void) getUserMessagesSucceeded:(ASIHTTPRequest *)request;

-(void) getHotelMessagesFailed:(ASIHTTPRequest *)request;
-(void) getHotelMessagesSucceeded:(ASIHTTPRequest *)request;
@end
