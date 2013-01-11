//
//  WeatherMapper.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "WeatherForecast.h"
#define URL	@"http://www.google.com/ig/api?weather=,,,"
@protocol WeatherMapperCallBacks
@optional
- (void)getWeatherSucceeded:(WeatherForecast *)weatherforecast;
- (void)getWeatherFailed:(NSString *)message;
@end
@interface WeatherMapper : NSObject{
    ASIHTTPRequest *weatherAPI;
    id _target;
}
@property(nonatomic,assign) id target;
-(void) getWeatherForecast :(NSString *)city;
-(void) getWeatherSucceeded:(ASIHTTPRequest *)request;
-(void) getWeatherFailed:(ASIHTTPRequest *)request;
@end
