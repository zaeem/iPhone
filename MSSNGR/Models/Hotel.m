//
//  Hotel.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Hotel.h"
#import "Utility.h"
@implementation Hotel
@synthesize Id=_Id,lat=_lat,lng=_lng,name=_name,street=_street,zip=_zip,description=_description,city=_city,phone=_phone,website=_website,image=_image,thumb=_thumb;
-(NSMutableDictionary *)objectToDisctionary{
    NSMutableDictionary *hotel = [[[NSMutableDictionary alloc]init]autorelease];
    [hotel setValue:self.Id forKey:@"id"];
    [hotel setValue:self.zip forKey:@"zip"];
    [hotel setValue:self.name forKey:@"name"];
    [hotel setValue:self.street forKey:@"street"];
    [hotel setValue:self.city forKey:@"city"];
    [hotel setValue:self.description forKey:@"description"];
    [hotel setValue:self.phone forKey:@"phone"];
    [hotel setValue:self.website forKey:@"website"];
    [hotel setValue:self.lat forKey:@"lat"];
    [hotel setValue:self.lng forKey:@"lng"];
    [hotel setValue:self.image forKey:@"image"];
    [hotel setValue:self.thumb forKey:@"thumb"];
    return hotel;
}
+(Hotel *)dictionaryToObject :(NSDictionary *)dictionary{
    Hotel *hotel = [[[Hotel alloc]init]autorelease];
    hotel.Id       = [Utility checkNSnumberValue:[dictionary valueForKey:@"id"]];
    hotel.name    = [Utility checkNullValues:[dictionary valueForKey:@"name"]];
    hotel.street     = [Utility checkNullValues:[dictionary valueForKey:@"street"]];
    hotel.lat      = [Utility checkNSnumberValue:[dictionary valueForKey:@"lat"]];
    hotel.lng      = [Utility checkNSnumberValue:[dictionary valueForKey:@"lng"]];
    hotel.phone    = [Utility checkNullValues:[dictionary valueForKey:@"phone"]];
    hotel.website  = [Utility checkNullValues:[dictionary valueForKey:@"website"]];
    hotel.description   = [Utility checkNullValues:[dictionary valueForKey:@"description"]];
    hotel.zip      = [Utility checkNullValues:[dictionary valueForKey:@"zip"]];
    hotel.city    = [Utility checkNullValues:[dictionary valueForKey:@"city"]];
    hotel.image    = [Utility checkNullValues:[dictionary valueForKey:@"image"]];
    hotel.thumb    = [Utility checkNullValues:[dictionary valueForKey:@"thumb"]];
    [Utility downLoadImage:hotel.image];
    [Utility downLoadImage:hotel.thumb];
    return hotel;
}
-(void)dealloc{
    [_Id release];
    [_zip release];
    [_name release];
    [_street release];
    [_city release];
    [_description release];
    [_phone release];
    [_website release];
    [_image release];
    [_thumb release];
    [_lat release];
    [_lng release];
    _thumb = nil;
    _image = nil;
    _Id=nil;
    _zip=nil;
    _name=nil;
    _street=nil;
    _city=nil;
    _description=nil;
    _phone=nil;
    _website=nil;
    [super dealloc];
}
-(BOOL)validCoordinates{
    if ([self.lat isKindOfClass:[NSNumber class]] && [self.lng isKindOfClass:[NSNumber class]]) {
        return true;
    }else{
        return false;
    }
}
@end
