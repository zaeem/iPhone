//
//  WeatherMapper.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "WeatherMapper.h"
#import "XMLReader.h"
#import "ForecastConditions.h"
#import "ASIDownloadCache.h"
#import "Helper.h"
#import "Singleton.h"
@implementation WeatherMapper
@synthesize target=_target;
-(void)dealloc{
    if (weatherAPI) {
        [weatherAPI clearDelegatesAndCancel];
    }
    weatherAPI = nil;
    _target=nil;
}
-(void) getWeatherForecast:(NSString *)city{
    if (weatherAPI) {
        [weatherAPI clearDelegatesAndCancel];
    }
    weatherAPI = nil;
    Singleton *obj = [Singleton sharedSingleton];
    NSString *lat = [NSString stringWithFormat:@"%@",obj.checkedInHotel.lat];
    NSString *lng = [NSString stringWithFormat:@"%@",obj.checkedInHotel.lng];
    
    NSArray *chunks = [lat componentsSeparatedByString: @"."];
    NSArray *chunks2 = [lng componentsSeparatedByString: @"."];
    NSString *latIntPart = [chunks objectAtIndex:0];
    NSString *latDecimalPart =@"";
    
    NSString *lngIntPart = [chunks2 objectAtIndex:0];
    NSString *lngDecimalPart =@"";
    
    if (chunks.count > 1) {
        latDecimalPart = [chunks objectAtIndex:1];
    }
    
    if (chunks2.count > 1) {
        lngDecimalPart = [chunks2 objectAtIndex:1];
    }

    if (latIntPart.length == 1) {
        latIntPart = [NSString stringWithFormat:@"0%@",latIntPart];
    }
    if (lngIntPart.length == 1) {
        lngIntPart = [NSString stringWithFormat:@"0%@",lngIntPart];
    }
    while (latDecimalPart.length < 6) {
        latDecimalPart = [NSString stringWithFormat:@"%@0",latDecimalPart];
    }
    while (lngDecimalPart.length < 6) {
        lngDecimalPart = [NSString stringWithFormat:@"%@0",lngDecimalPart];
    }
    
    latDecimalPart = [latDecimalPart substringToIndex:6];
    lngDecimalPart = [lngDecimalPart substringToIndex:6];
    NSString *latlng = [NSString stringWithFormat:@"%@%@,%@%@",latIntPart,latDecimalPart,lngIntPart,lngDecimalPart];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL,latlng]];
     weatherAPI = [ASIHTTPRequest requestWithURL:url];
    [weatherAPI setRequestMethod:@"GET"];
    [weatherAPI setDownloadCache:[ASIDownloadCache sharedCache]];
    [weatherAPI setCachePolicy:ASIAskServerIfModifiedWhenStaleCachePolicy|ASIFallbackToCacheIfLoadFailsCachePolicy];
    [weatherAPI setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    [weatherAPI setSecondsToCache:60*60*2];
    [weatherAPI setDidFinishSelector:@selector(getWeatherSucceeded:)];
    [weatherAPI setDidFailSelector:@selector(getWeatherFailed:)];
    [weatherAPI setDelegate:self];
    [weatherAPI startAsynchronous];
}
-(void)getWeatherSucceeded:(ASIHTTPRequest *)request{
    weatherAPI = nil;
    Boolean reload = FALSE;
    if (_target) {
        if ([_target respondsToSelector:@selector(reloadWeatherData)]) {
            reload = [_target reloadWeatherData]; 
        }
    }
    if ([request didUseCachedResponse] == FALSE || reload) {
        NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *data = [[XMLReader dictionaryForXMLString:contents error:&error] retain];
        [Helper writeFileToDisk:data :@"weather_data"];
        WeatherForecast *obj = [WeatherForecast objectFromDictionary:data];
        if (_target) {
            if ([_target respondsToSelector:@selector(getWeatherSucceeded:)]) {
                [_target getWeatherSucceeded:obj];
            }
        }
        [contents release];
        [data release];
    }
}
-(void)getWeatherFailed:(ASIHTTPRequest *)request{
    weatherAPI = nil;
    NSDictionary *data = [Helper readFileFromDisk:@"weather_data"];
    WeatherForecast *obj = [WeatherForecast objectFromDictionary:data];
    if (_target) {
        if ([_target respondsToSelector:@selector(getWeatherSucceeded:)]) {
            [_target getWeatherSucceeded:obj];
        }
    }
}
@end
