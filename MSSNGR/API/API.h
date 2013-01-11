//
//  API.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASIDownloadCache.h"

@interface API : NSObject{
    
}
+(void)activateUser;
+(ASIFormDataRequest *)newUserAPI :(id)target FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIFormDataRequest *)userCheckIn :(id)target Token:(NSString *)token PropertyId:(NSNumber *)property_id FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIFormDataRequest *)userCheckOut :(id)target Token:(NSString *)token PropertyId:(NSNumber *)property_id FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;

+(ASIFormDataRequest *)updateUserInterests :(id)target Token:(NSString *)token Interests:(NSArray *)interests FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)getUserInterests :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)getAllInterests :(id)target FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;

+(ASIHTTPRequest *)getUserMessages :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)getHotelMessages :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;

+(ASIHTTPRequest *)getUserDirectories :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;

+(ASIHTTPRequest *)getAllHotels :(id)target lat:(float)lat lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)getNearByHotels :(id)target lat:(float)lat lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;

+(ASIFormDataRequest *)joiningConventionAPI :(id)target Token:(NSString *)token ConventionCode:(NSString *)convention_code FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)checkOutConventionAPI :(id)target Token:(NSString *)token Code:(NSString *)code FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *)showUserConventionAPI :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
+(ASIHTTPRequest *) getAddressFromLatLng :(id)target Lat:(float)lat Lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector;
@end
