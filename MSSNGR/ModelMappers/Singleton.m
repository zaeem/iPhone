//
//  SharedModel.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Singleton.h"
#import "User.h"
#import "Helper.h"
#import "Utility.h"
#import "API.h"
#import "AppDelegate.h"
@implementation Singleton
@synthesize allHotels=_allHotels,nearByHotels=_nearByHotels,target=_target,appUser=_appUser,currentLat,currentLng,appNotUsedForLAst2Days,checkedInHotel=_checkedInHotel,userMessages=_userMessages,hotelMessages=_hotelMessages,directories=_directories,locationManager=_locationManager,enableApplicationActivityDataLoading=_enableApplicationActivityDataLoading,curent_city=_curent_city,device_token=_device_token,hideSearchButton=_hideSearchButton,reloadUserMessagesFirstTime=_reloadUserMessagesFirstTime,reloadHotelMessagesFirstTime=_reloadHotelMessagesFirstTime,reloadDirectoriesFirstTime=_reloadDirectoriesFirstTime,reloadAllHotelsFirstTime=_reloadAllHotelsFirstTime;
+ (Singleton *)sharedSingleton
{
    static Singleton *sharedSingleton;
    @synchronized(self)
    {
        if (!sharedSingleton){
            sharedSingleton = [[Singleton alloc] init];
            sharedSingleton.enableApplicationActivityDataLoading=FALSE;
            User *user=[[User alloc]init];
            sharedSingleton.appUser = user;
            [user release];
            sharedSingleton.currentLat=52.506975;
            sharedSingleton.currentLng=13.391175;
            //sharedSingleton.currentLat=31.50988;
            //sharedSingleton.currentLng=74.3454;
            sharedSingleton.appNotUsedForLAst2Days=FALSE;
            CLLocationManager *manager = [[CLLocationManager alloc] init];
            sharedSingleton.locationManager = manager;
            sharedSingleton.locationManager.delegate = sharedSingleton;
            sharedSingleton.device_token=nil;
            sharedSingleton.hideSearchButton = FALSE;
            sharedSingleton.reloadUserMessagesFirstTime = TRUE;
            sharedSingleton.reloadHotelMessagesFirstTime = TRUE;
            sharedSingleton.reloadDirectoriesFirstTime = TRUE;
            sharedSingleton.reloadAllHotelsFirstTime = TRUE;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            if ([userDefaults valueForKey:@"last_city"]) {
                sharedSingleton.curent_city=[userDefaults valueForKey:@"last_city"];
            }else{
                sharedSingleton.curent_city=@"New%20York";
            }
            [manager release];
        }
        return sharedSingleton;
    }
}
-(void)dealloc{
    if (getAddressApi) {
        [getAddressApi clearDelegatesAndCancel];
    }
    [super dealloc];
}
-(void)clearAllData{
    [[ASIDownloadCache sharedCache] clearCachedResponsesForStoragePolicy:ASICachePermanentlyCacheStoragePolicy];
    self.hideSearchButton = FALSE;
    self.reloadUserMessagesFirstTime = TRUE;
    self.reloadHotelMessagesFirstTime = TRUE;
    self.reloadDirectoriesFirstTime = TRUE;
    self.reloadAllHotelsFirstTime = TRUE;
    [self.hotelMessages removeAllObjects];
    [self.userMessages removeAllObjects];
    [self.directories removeAllObjects];
    [self.allHotels removeAllObjects];
    [self.nearByHotels removeAllObjects];
}
-(void)getNearByHotels{
    if (!mapper) {
        mapper = [[HotelMapper alloc]init];
        mapper.target = self;
    }
    [mapper getNearByHotels:self.currentLat lng:self.currentLng];
}
-(void)getAllHotels{
    if (!mapper) {
        mapper = [[HotelMapper alloc]init];
        mapper.target = self;
    }
    [mapper getAllHotels:self.currentLat lng:self.currentLng];
}
-(void)getAllHotelsSucceeded:(Result *)result{
    [result retain];
    if (!result.didUseCachedData || self.reloadAllHotelsFirstTime) {
        [_allHotels release];
        _allHotels = (NSMutableArray *)result.object;
        [_allHotels retain];
        if (_target) {
            if ([_target respondsToSelector:@selector(reloadOnAllHotels)]) {
                [_target reloadOnAllHotels];
                self.reloadAllHotelsFirstTime = FALSE;
            }
        }
    }
    [result release];
}
-(void)getAllHotelsFailed:(Result *)result{
}
-(void)getNearByHotelsSucceeded:(Result *)result{
    [result retain];
    [_nearByHotels release];
    _nearByHotels = (NSMutableArray *)result.object;
    [_nearByHotels retain];
    if (self.nearByHotels.count > 0) {
        [self.allHotels removeAllObjects];
    }
    [result release];
    if (_target) {
        if ([_target respondsToSelector:@selector(reloadOnNearHotels)]) {
            [_target reloadOnNearHotels];
        }
    }
}
-(void)getNearByHotelsFailed:(Result *)result{

}
-(void)logUserActivityTime{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDate *lastUsedDate = (NSDate *)[userDefaults objectForKey:@"lastUsedDate"];
    if (lastUsedDate == nil) {
        // first time app
        self.appNotUsedForLAst2Days = FALSE;
    }else{
        NSDate *today = [NSDate date];
        NSDateComponents *components;
        NSInteger days;
        components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit 
                                                     fromDate: lastUsedDate toDate: today options: 0];
        days = [components day];
        if (days > 2) {
            self.appNotUsedForLAst2Days = TRUE;
        }else{
            self.appNotUsedForLAst2Days = FALSE;
        }
    }
    //self.appNotUsedForLAst2Days = TRUE;
    [userDefaults setObject:[NSDate date] forKey:@"lastUsedDate"];
    [userDefaults synchronize];
}
-(void)getUserMessages{
    if (self.appUser!=nil) {
        if (!messagesMapper) {
            messagesMapper = [[MessageMapper alloc]init];
            messagesMapper.target = self;
        }
        [messagesMapper getUserMessages:self.appUser.token];
    }
}
-(void)getHotelMessages{
    if (self.checkedInHotel !=nil) {
        if (!messagesMapper) {
            messagesMapper = [[MessageMapper alloc]init];
            messagesMapper.target = self;
        }
        [messagesMapper getHotelMessages:self.appUser.token];
    }
}
-(void)getAllDirectories{
    if (!directoryMapper) {
        directoryMapper = [[DirectoryMapper alloc]init];
        directoryMapper.target = self;
    }
    [directoryMapper getUserDirectories:self.appUser.token];
}
-(void)getUserDirectoriesSucceeded:(Result *)result{
    [result retain];
    if (!result.didUseCachedData || self.reloadDirectoriesFirstTime) {
        [_directories release];
        _directories = (NSMutableArray *)result.object;
        [_directories retain];
        if (_target) {
            if ([_target respondsToSelector:@selector(reloadOnDirectories)]) {
                [_target reloadOnDirectories];
                self.reloadDirectoriesFirstTime = FALSE;
            }
        }
    }
    [result release];
}
-(void)getUserDirectoriesFailed:(Result *)result{

}
-(void)getUserMessagesSucceeded:(Result *)result{
    [result retain];
    if (!result.didUseCachedData || self.reloadUserMessagesFirstTime) {
        self.userMessages = (NSMutableArray *)result.object;
        if (_target) {
            if ([_target respondsToSelector:@selector(reloadOnMessages)]) {
                [_target reloadOnMessages];
                self.reloadUserMessagesFirstTime = FALSE;
            }
        }
    }
    [result release];
}
-(void)getUserMessagesFailed:(Result *)result{

}
-(void)getHotelMessagesSucceeded:(Result *)result{
    [result retain];
    if (!result.didUseCachedData || self.reloadHotelMessagesFirstTime) {
        [_hotelMessages release];
        _hotelMessages = (NSMutableArray *)result.object;
        [_hotelMessages retain];
        if (_target) {
            if ([_target respondsToSelector:@selector(reloadOnMessages)]) {
                [_target reloadOnMessages];
                self.reloadHotelMessagesFirstTime = FALSE;
            }
        }
    }
    [result release];
}
-(void)getHotelMessagesFailed:(Result *)result{

}
-(void)resetStarMessages{
    NSMutableArray *starIds = [Helper readStarMessages];
    [starIds retain];
    Boolean found=FALSE;
    for (MSSNMessage *message in self.hotelMessages) {
        found=FALSE;
        for(NSString *messageId in starIds){
            if ([messageId intValue] == [message.Id intValue]) {
                message.favouriteMarked = TRUE;
                found = TRUE;
                break;
            }
        }
        if (!found) {
            message.favouriteMarked = FALSE;
        }
    }
    for (MSSNMessage *message in self.userMessages) {
        found=FALSE;
        for(NSString *messageId in starIds){
            if ([messageId intValue] == [message.Id intValue]) {
                message.favouriteMarked = TRUE;
                found = TRUE;
                break;
            }
        }
        if (!found) {
            message.favouriteMarked = FALSE;
        }
    }
    [starIds release];
}
-(void)resetStarPages{
    NSMutableArray *starIds = [Helper readStarPages];
    [starIds retain];
    Boolean found=FALSE;
    for (id object in self.directories) {
        if ([object isKindOfClass:[Page class]]) {
            found=FALSE;
            Page *page = (Page *)object;
           for(NSString *messageId in starIds){
               if ([messageId intValue] == [page.Id intValue]) {
                   page.favouriteMarked = TRUE;
                   found = TRUE;
                   break;
               }
           }
            if (!found) {
                page.favouriteMarked = FALSE;
            }
        }else{
            Folder *folder = (Folder *)object;
            for (Page *page in folder.pages) {
                found=FALSE;
                for(NSString *messageId in starIds){
                    if ([messageId intValue] == [page.Id intValue]) {
                        page.favouriteMarked = TRUE;
                        found = TRUE;
                        break;
                    }
                }
                if (!found) {
                    page.favouriteMarked = FALSE;
                }
            }
        }
    }
    [starIds release];
}
#pragma usermapper call backs
-(void)createNewUserSucceeded:(Result *)result{
    [result retain];
    User *user = (User *)result.object;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults]; 
    [userDefaults setObject:user.token forKey:@"token"];
    [userDefaults setBool:FALSE forKey:@"returningUser"];
	_appUser.token=user.token;
    _appUser.returningUser=FALSE;
    [userDefaults synchronize];
    [result release];
}
-(void)createNewUserFailed:(Result *)result{
    
}
#pragma location manager
- (void) locationManager: (CLLocationManager *) manager
     didUpdateToLocation: (CLLocation *) newLocation
            fromLocation: (CLLocation *) oldLocation{
    [[Singleton sharedSingleton].locationManager stopUpdatingLocation];
    [Singleton sharedSingleton].currentLat = newLocation.coordinate.latitude;
    [Singleton sharedSingleton].currentLng = newLocation.coordinate.longitude;
    if (_target) {
        if ([_target respondsToSelector:@selector(reloadOnLocationUpdate)]) {
            [_target reloadOnLocationUpdate];
        }
    }
}
- (void) locationManager: (CLLocationManager *) manager
        didFailWithError: (NSError *) error {
    [[Singleton sharedSingleton].locationManager stopUpdatingLocation];
    if (_target) {
        if ([_target respondsToSelector:@selector(reloadOnLocationUpdate)]) {
            [_target reloadOnLocationUpdate];
        }
    }
}
-(void)releaseCheckInHotel{
    [Helper deleteFile:@"checkedInHotel"];
    [_checkedInHotel release];
    _checkedInHotel=nil;
    [[Singleton sharedSingleton].hotelMessages removeAllObjects];
    [[Singleton sharedSingleton].userMessages removeAllObjects];
    [[Singleton sharedSingleton].directories removeAllObjects];
}
-(void)getAddress{
    if (getAddressApi) {
        if ([getAddressApi isExecuting]) {
            return;
        } 
    }
    getAddressApi=nil;
    getAddressApi = [API getAddressFromLatLng:self Lat:currentLat Lng:currentLng FinishSelector:@selector(onGetAddressSucceeded:) FailSelector:@selector(onGetAddressFailed:)];
    [getAddressApi startAsynchronous];
}
-(void)onGetAddressSucceeded :(ASIHTTPRequest *)request{
    getAddressApi=nil;
    NSString *contents = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
    SBJSON *jsonParser = [SBJSON new];
    NSDictionary *data = [jsonParser objectWithString:contents error:NULL];
    [jsonParser release];
    [contents release];
    NSArray *data1=nil;
    if ([data isKindOfClass:[NSDictionary class]]) {
        data1 = [data valueForKey:@"results"];
        if ([data1 isKindOfClass:[NSArray class]]) {
            if ([data1 count] >=1) {
                data1 = [[data1  objectAtIndex:0] valueForKey:@"address_components"];
                if ([data1 isKindOfClass:[NSArray class]]) {
                    for (NSDictionary *dict in data1) {
                        if ([dict isKindOfClass:[NSDictionary class]]) {
                            if ([[dict valueForKey:@"types"] isKindOfClass:[NSArray class]]) {
                                if ([[dict valueForKey:@"types"] count]>=1) {
                                    if ([[[dict valueForKey:@"types"] objectAtIndex:0] isEqualToString:@"administrative_area_level_2"]) {
                                        self.curent_city = [dict valueForKey:@"long_name"];
                                        self.curent_city = [self.curent_city stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                        [userDefaults setValue:self.curent_city forKey:@"last_city"];
                                        break;
                                        [userDefaults synchronize];
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if (_target) {
        if ([_target respondsToSelector:@selector(reloadOnAddress:)]) {
            [_target reloadOnAddress:data1];
        }
    }
}
-(void)onGetAddressFailed :(ASIHTTPRequest *)request{
    getAddressApi=nil;
}
- (void)imageDownloadeSucceeded:(ASIHTTPRequest*)req
{
    //NSLog(@"image downloaded = %@",[req url].path);
}

- (void)imageDownloadFailed:(ASIHTTPRequest*)req
{

}
+(NSMutableDictionary *)imagesQueue{
    static  NSMutableDictionary *imagesQueue;
    if (imagesQueue == nil) {
        imagesQueue = [[NSMutableDictionary alloc]init];
    }
    return imagesQueue;
}
@end
