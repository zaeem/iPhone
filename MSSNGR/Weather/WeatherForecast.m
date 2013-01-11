//
//  WeatherForecast.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "WeatherForecast.h"
#import "ForecastConditions.h"
@implementation WeatherForecast
@synthesize condition=_condition,temp_c=_temp_c,temp_f=_temp_f,wind_condition=_wind_condition,icon=_icon,humidity=_humidity,day1=_day1,day2=_day2,day3=_day3;
-(void)dealloc{
    [_condition release];
    [_wind_condition release];
    [_icon release];
    [_humidity release];
    [_day1 release];
    [_day2 release];
    [_day3 release];
    _day1 = nil;
    _day2 = nil;
    _day3 = nil;
    _humidity = nil;
    _condition=nil;
    _wind_condition=nil;
    _icon=nil;
}
+(WeatherForecast *)objectFromDictionary :(NSDictionary *)data{
    WeatherForecast *obj = [[[WeatherForecast alloc]init] autorelease];
    data = [[data objectForKey:@"xml_api_reply"] objectForKey:@"weather"];
    NSDictionary *currentConditios = [data objectForKey:@"current_conditions"];
    
    obj.condition = [[currentConditios objectForKey:@"condition"] objectForKey:@"@data"];
    obj.temp_f = [[[currentConditios objectForKey:@"temp_f"] objectForKey:@"@data"] floatValue];
    obj.temp_c = [[[currentConditios objectForKey:@"temp_c"] objectForKey:@"@data"] floatValue];
    obj.humidity = [[currentConditios objectForKey:@"humidity"] objectForKey:@"@data"];
    NSString *iconVal = [[currentConditios objectForKey:@"icon"] objectForKey:@"@data"];
    iconVal = [[iconVal stringByReplacingOccurrencesOfString:@"/ig/images/weather/" withString:@""] stringByReplacingOccurrencesOfString:@".gif" withString:@""];
    obj.icon = iconVal;
    obj.wind_condition = [[currentConditios objectForKey:@"wind_condition"] objectForKey:@"@data"];
    NSArray *forecastConditions = [data objectForKey:@"forecast_conditions"];
    obj.day1 = [ForecastConditions objectFromDictionary:[forecastConditions objectAtIndex:0]];
    obj.day2 = [ForecastConditions objectFromDictionary:[forecastConditions objectAtIndex:1]];
    obj.day3 = [ForecastConditions objectFromDictionary:[forecastConditions objectAtIndex:2]];
    return obj;
}
@end
