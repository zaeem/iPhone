//
//  Convention.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Convention.h"
#import "Utility.h"
@implementation Convention

@synthesize Id=_id, title= _title,start=_start, end=_end, code=_code,text=_text,website=_website,phone=_phone,lat=_lat,lng=_lng,image=_image,thumb=_thumb;
-(void)dealloc{
    [_Id release];
    [_title release];
    [_code release];
    [_start release];
    [_end release];
    [_text release];
    [_website release];
    [_phone release];
    [_lat release];
    [_lng release];
    [_image release];
    [_thumb release];
    _Id=nil;
    _title=nil;
    _code=nil;
    _start=nil;
    _end=nil;
    [super dealloc];
}
-(NSMutableDictionary *)objectToDisctionary{
    NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc]init]autorelease];
    return dictionary;
}
+(Convention *)dictionaryToObject :(NSDictionary *)dictionary{
    Convention *object = [[Convention alloc]init];
    object.Id           = [Utility checkNSnumberValue:[dictionary valueForKey:@"id"]];
    object.title        = [Utility checkNullValues:[dictionary valueForKey:@"title"]];
    object.code        = [Utility checkNullValues:[dictionary valueForKey:@"code"]];
    object.text        = [Utility checkNullValues:[dictionary valueForKey:@"text"]];
    object.start        = [Utility stringToDate:[dictionary valueForKey:@"start"]];
    object.end          = [Utility stringToDate:[dictionary valueForKey:@"end"]];
    object.website        = [Utility checkNullValues:[dictionary valueForKey:@"website"]];
    object.phone        = [Utility checkNullValues:[dictionary valueForKey:@"phone"]];
    object.lat        = [Utility checkNSnumberValue:[dictionary valueForKey:@"lat"]];
    object.lng        = [Utility checkNSnumberValue:[dictionary valueForKey:@"lng"]];
    object.image        = [Utility checkNullValues:[dictionary valueForKey:@"image"]];
    object.thumb        = [Utility checkNullValues:[dictionary valueForKey:@"thumb"]];
    return object;
}
-(BOOL)validCoordinates{
    if ([self.lat isKindOfClass:[NSNumber class]] && [self.lng isKindOfClass:[NSNumber class]]) {
        return true;
    }else{
        return false;
    }
}
@end
