//
//  ForecastConditions.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastConditions : NSObject{
    NSString *_day;
    float _low;
    float _high;
    NSString *_icon;
    NSString *_condition;
}
@property(nonatomic,retain) NSString *day;
@property(nonatomic,readwrite) float low;
@property(nonatomic,readwrite) float high;
@property(nonatomic,retain) NSString *icon;
@property(nonatomic,retain) NSString *condition;
+(ForecastConditions *)objectFromDictionary :(NSDictionary *)forecastDic;
@end
