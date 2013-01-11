//
//  WeatherViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/29/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherMapper.h"
@interface WeatherViewController : UIViewController<WeatherMapperCallBacks>{
    IBOutlet UILabel *lblDay1;
    IBOutlet UILabel *lblLow1;
    IBOutlet UILabel *lblHigh1;
    IBOutlet UIImageView *imgIcon1;
    
    IBOutlet UILabel *lblDay2;
    IBOutlet UILabel *lblLow2;
    IBOutlet UILabel *lblHigh2;
    IBOutlet UIImageView *imgIcon2;
    
    IBOutlet UILabel *lblDay3;
    IBOutlet UILabel *lblLow3;
    IBOutlet UILabel *lblHigh3;
    IBOutlet UIImageView *imgIcon3;
    IBOutlet UIView *backView;
    WeatherMapper *mapper;
    IBOutlet UIActivityIndicatorView *loader;
    Boolean reloadWeatherData;
}
@property(nonatomic,readonly) Boolean reloadWeatherData;
-(void)reloadWeather;
@end
