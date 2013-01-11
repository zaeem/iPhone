//
//  ForecastConditions.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ForecastConditions.h"
@implementation ForecastConditions
@synthesize condition=_condition,low=_low,high=_high,day=_day,icon=_icon;
-(void)dealloc{
    [_condition release];
    [_day release];
    [_icon release];
    _condition=nil;
    _day=nil;
    _icon = nil;
}
+(ForecastConditions *)objectFromDictionary :(NSDictionary *)forecastDic{
    NSMutableDictionary *weekdays = [[NSMutableDictionary alloc]initWithObjectsAndKeys:NSLocalizedString(@"Saturday",@"Saturday"),@"Sat",NSLocalizedString(@"Sunday",@"Sunday"),@"Sun",NSLocalizedString(@"Monday",@"Monday"),@"Mon",NSLocalizedString(@"Tuesday",@"Tuesday"),@"Tue",NSLocalizedString(@"Wednesday",@"Wednesday"),@"Wed",NSLocalizedString(@"Thursday","Thursday"),@"Thu",NSLocalizedString(@"Friday",@"Friday"),@"Fri", nil];
    ForecastConditions *forecast = [[[ForecastConditions alloc]init]autorelease];
    forecast.day = [weekdays objectForKey:[[forecastDic objectForKey:@"day_of_week"] objectForKey:@"@data"]];
    forecast.low = ([[[forecastDic objectForKey:@"low"] objectForKey:@"@data"] floatValue]-32)*5/9;
    forecast.high = ([[[forecastDic objectForKey:@"high"] objectForKey:@"@data"] floatValue]-32)*5/9;
    NSString *iconVal = [[forecastDic objectForKey:@"icon"] objectForKey:@"@data"];
    iconVal = [[iconVal stringByReplacingOccurrencesOfString:@"/ig/images/weather/" withString:@""] stringByReplacingOccurrencesOfString:@".gif" withString:@""];
    forecast.icon = iconVal;
    forecast.condition = [[forecastDic objectForKey:@"condition"] objectForKey:@"@data"];
    [weekdays release];
    return forecast;
}
@end
