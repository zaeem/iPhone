//
//  API.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "API.h"
#import "SBJSON.h"
#import "JSON.h"
#import "Interest.h"
#import "Singleton.h"
#import "InterestGroup.h"
@implementation API

+(NSString *)localizedBaseURL {
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    
    return [NSString stringWithFormat:@"%@/%@", BASE_URL, preferredLang];
}

+(void)activateUser{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];    
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/activate/%f/%f?api_key=%@",[API localizedBaseURL],[userDefaults stringForKey:@"token"],[Singleton sharedSingleton].currentLat,[Singleton sharedSingleton].currentLng,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp startAsynchronous];
}
+(ASIFormDataRequest *)newUserAPI :(id)target FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString * udid = [[[UIDevice currentDevice] uniqueIdentifier] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/new?api_key=%@",[API localizedBaseURL],api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"POST"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    [requestHttp addPostValue:udid forKey:@"device_id"];
    [requestHttp addPostValue:[Singleton sharedSingleton].device_token forKey:@"device_token"];
    return requestHttp;
}
+(ASIFormDataRequest *)userCheckIn :(id)target Token:(NSString *)token PropertyId:(NSString *)property_id FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/checkin?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"POST"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    [requestHttp addPostValue:property_id forKey:@"property_id"];
    [requestHttp addPostValue:[Singleton sharedSingleton].device_token forKey:@"device_token"];
    return requestHttp;
}
+(ASIFormDataRequest *)userCheckOut :(id)target Token:(NSString *)token PropertyId:(NSNumber *)property_id FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/checkin?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"DELETE"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    //[requestHttp addPostValue:property_id forKey:@"property_id"];
    return requestHttp;
}


+(ASIFormDataRequest *)updateUserInterests :(id)target Token:(NSString *)token Interests:(NSArray *)interests FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/interests?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"PUT"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    for(InterestGroup *interestGroup in interests){
        for(Interest *interest in interestGroup.interests)
            {
                if (interest.selected) {
                    [requestHttp addPostValue:interest.Id forKey:@"interests[]"];
                }
            }
    }
    return requestHttp;
}
+(ASIHTTPRequest *)getUserInterests :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/interests?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}
+(ASIHTTPRequest *)getAllInterests :(id)target FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/interests?api_key=%@",[API localizedBaseURL],api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)getUserMessages :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/messages?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)getHotelMessages :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/hotel/messages?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)getUserDirectories :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/directory?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)getAllHotels :(id)target lat:(float)lat lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/hotels/%f/%f?api_key=%@",[API localizedBaseURL],lat,lng,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDownloadCache:[ASIDownloadCache sharedCache]];
    [requestHttp setCachePolicy:ASIAskServerIfModifiedCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [requestHttp setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}
+(ASIHTTPRequest *)getNearByHotels :(id)target lat:(float)lat lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/hotels/location/%f/%f?api_key=%@",[API localizedBaseURL],lat,lng,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
    ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}


+(ASIFormDataRequest *)joiningConventionAPI :(id)target Token:(NSString *)token ConventionCode:(NSString *)convention_code FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector
{
	NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/conventions?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
	
	ASIFormDataRequest *requestHttp = [ASIFormDataRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"POST"];
    [requestHttp addPostValue:convention_code forKey:@"convention_code"];
    [requestHttp addPostValue:[Singleton sharedSingleton].device_token forKey:@"device_token"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)checkOutConventionAPI :(id)target Token:(NSString *)token Code:(NSString *)code FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector
{
    NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/conventions/%@?api_key=%@",[API localizedBaseURL],token,code,api_key];
	NSURL *url = [NSURL URLWithString:api];
    [api release];
	
	ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"DELETE"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}

+(ASIHTTPRequest *)showUserConventionAPI :(id)target Token:(NSString *)token FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector
{
	  NSString *api=[[NSString alloc]initWithFormat:@"%@/users/%@/conventions?api_key=%@",[API localizedBaseURL],token,api_key];
    NSURL *url = [NSURL URLWithString:api];
    [api release];
	
	ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
    [requestHttp setValidatesSecureCertificate:NO];
    [requestHttp setRequestMethod:@"GET"];
    [requestHttp setDidFinishSelector:finishselector];
    [requestHttp setDidFailSelector:failselector];
    [requestHttp setDelegate:target];
    return requestHttp;
}
+(ASIHTTPRequest *) getAddressFromLatLng :(id)target Lat:(float)lat Lng:(float)lng FinishSelector:(SEL) finishselector FailSelector:(SEL) failselector{
    if (lat != 0.0 && lng != 0.0) {        
        NSString *api = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",lat,lng];
        NSLog(@"%@",api);
        NSURL *url = [NSURL URLWithString:api];
        ASIHTTPRequest *requestHttp = [ASIHTTPRequest requestWithURL:url];
        [requestHttp setValidatesSecureCertificate:NO];
        [requestHttp setRequestMethod:@"GET"];
        [requestHttp setDidFinishSelector:finishselector];
        [requestHttp setDidFailSelector:failselector];
        [requestHttp setDelegate:target];
        return requestHttp;
    }
    return nil;
}
@end
