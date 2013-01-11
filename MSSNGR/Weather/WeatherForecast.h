//
//  WeatherForecast.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ForecastConditions;
@interface WeatherForecast : NSObject{
    NSString *_condition;
    float _temp_f;
    float _temp_c;
    NSString *_humidity;
    NSString *_icon;
    NSString *_wind_condition;
    ForecastConditions *_day1;
    ForecastConditions *_day2;
    ForecastConditions *_day3;
}
@property(nonatomic,retain) NSString *condition;
@property(nonatomic,readwrite) float temp_f;
@property(nonatomic,readwrite) float temp_c;
@property(nonatomic,retain) NSString *humidity;
@property(nonatomic,retain) NSString *icon;
@property(nonatomic,retain) NSString *wind_condition;
@property(nonatomic,retain) ForecastConditions *day1;
@property(nonatomic,retain) ForecastConditions *day2;
@property(nonatomic,retain) ForecastConditions *day3;
+(WeatherForecast *)objectFromDictionary :(NSDictionary *)data;
@end
