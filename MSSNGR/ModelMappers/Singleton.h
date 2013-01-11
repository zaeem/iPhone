//
//  SharedModel.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelMapper.h"
#import "Hotel.h"
#import "DirectoryMapper.h"
#import "MessageMapper.h"
#import "Folder.h"
#import "Page.h"
#import "MSSNMessage.h"
#import "UserMapper.h"
#import <CoreLocation/CoreLocation.h>
@class User;
@protocol SingletonNotification
@optional
- (void)reloadOnDirectories;
- (void)reloadOnMessages;
- (void)reloadOnAllHotels;
- (void)reloadOnNearHotels;
- (void)reloadOnLocationUpdate;
- (void)reloadOnAddress :(NSArray *)data;
@end
@interface Singleton : NSObject<HotelMapperCallBacks,DirectoryMapperCallBacks,MessageMapperCallBacks,UserMapperCallBacks,CLLocationManagerDelegate>{
    HotelMapper *mapper;
    DirectoryMapper *directoryMapper;
    MessageMapper *messagesMapper;
    UserMapper *userMapper;
    User *_appUser;
    NSMutableArray *_allHotels;
    NSMutableArray *_nearByHotels;
    Boolean appNotUsedForLAst2Days;
    id _target;
    float currentLat;
    float currentLng;
    Hotel *_checkedInHotel;
    NSMutableArray *_userMessages;
    NSMutableArray *_hotelMessages;
    NSMutableArray *_directories;
    CLLocationManager *_locationManager;
    Boolean _enableApplicationActivityDataLoading;
    NSString *_curent_city;
    NSString *_device_token;
    ASIHTTPRequest *getAddressApi;
    Boolean _hideSearchButton;
    Boolean _reloadUserMessagesFirstTime;
    Boolean _reloadHotelMessagesFirstTime;
    Boolean _reloadDirectoriesFirstTime;
    Boolean _reloadAllHotelsFirstTime;
}
@property(nonatomic,readwrite) Boolean reloadAllHotelsFirstTime;
@property(nonatomic,readwrite) Boolean reloadDirectoriesFirstTime;
@property(nonatomic,readwrite) Boolean reloadUserMessagesFirstTime;
@property(nonatomic,readwrite) Boolean reloadHotelMessagesFirstTime;
@property(nonatomic,readwrite) Boolean hideSearchButton;
@property(nonatomic,retain) NSString *device_token;
@property(nonatomic,readwrite) float currentLat;
@property(nonatomic,readwrite) float currentLng;
@property(nonatomic,readwrite) Boolean enableApplicationActivityDataLoading;
@property(nonatomic,readwrite) Boolean appNotUsedForLAst2Days;
@property(nonatomic,retain) User *appUser;
@property(nonatomic,retain) NSString *curent_city;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,retain) Hotel *checkedInHotel;
@property(nonatomic,assign) id target;
@property(nonatomic,retain) NSMutableArray *allHotels;
@property(nonatomic,retain) NSMutableArray *nearByHotels;

@property(nonatomic,retain) NSMutableArray *userMessages;
@property(nonatomic,retain) NSMutableArray *hotelMessages;

@property(nonatomic,retain) NSMutableArray *directories;
-(void)getNearByHotels;
-(void)getAllHotels;
-(void)logUserActivityTime;
-(void)getHotelMessages;
-(void)getUserMessages;
-(void)getAllDirectories;
-(void)resetStarMessages;
-(void)resetStarPages;
+ (Singleton *)sharedSingleton;
-(void)releaseCheckInHotel;
-(void)getAddress;
-(void)onGetAddressSucceeded :(ASIHTTPRequest *)request;
-(void)onGetAddressFailed :(ASIHTTPRequest *)request;
-(void)clearAllData;
- (void)imageDownloadeSucceeded:(ASIHTTPRequest*)req;
- (void)imageDownloadFailed:(ASIHTTPRequest*)req;
+(NSMutableDictionary *)imagesQueue;
@end
