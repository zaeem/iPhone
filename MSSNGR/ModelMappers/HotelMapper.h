//
//  HotelMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Result.h"
#import "API.h"
#import "JSON.h"
#import "Hotel.h"
#import "ASIHTTPRequest.h"
@protocol HotelMapperCallBacks
@optional
- (void)getAllHotelsSucceeded:(Result *)result;
- (void)getAllHotelsFailed:(Result *)result;

- (void)getNearByHotelsSucceeded:(Result *)result;
- (void)getNearByHotelsFailed:(Result *)result;
@end
@interface HotelMapper : NSObject{
    ASIHTTPRequest *getAllHotelsAPI;
    ASIHTTPRequest *getNearByHotelsAPI;
    id _target;
}
@property(nonatomic,retain) id target;
-(void) getAllHotels:(float)lat lng:(float)lng;
-(void) getNearByHotels:(float)lat lng:(float)lng;

-(void) getAllHotelsSucceeded:(ASIHTTPRequest *)request;
-(void) getAllHotelsFailed:(ASIHTTPRequest *)request;

-(void) getNearByHotelsSucceeded:(ASIHTTPRequest *)request;
-(void) getNearByHotelsFailed:(ASIHTTPRequest *)request;
@end
