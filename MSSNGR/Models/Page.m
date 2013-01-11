//
//  Directory.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Page.h"
#import "Utility.h"
@implementation Page
@synthesize Id=_Id,folder_id=_folder_id,lat=_lat,lng=_lng,title=_title,image=_image,thumb=_thumb,text=_text,phone=_phone,website=_website,created_at=_created_at,updated_at=_updated_at,property_id=_property_id,favouriteMarked=_favouriteMarked;

-(BOOL)validCoordinates{
    if ([self.lat isKindOfClass:[NSNumber class]] && [self.lng isKindOfClass:[NSNumber class]]) {
        return true;
    }else{
        return false;
    }
}
-(void)dealloc{
    [_Id release];
    [_created_at release];
    [_title release];
    [_text release];
    [_phone release];
    [_website release];
    [_folder_id release];
    [_image release];
    [_thumb release];
    _thumb = nil;
    [_lat release];
    [_lng release];
    [_updated_at release];
    [_property_id release];
    _Id=nil;
    _image=nil;
    _title=nil;
    _text=nil;
    _phone=nil;
    _website=nil;
    _property_id=nil;
    _updated_at=nil;
    _lat=nil;
    _lng=nil;
    [super dealloc];
}

-(NSString*)name {
    return [self title];
}

-(NSMutableDictionary *)objectToDisctionary{
    NSMutableDictionary *dictionary = [[[NSMutableDictionary alloc]init]autorelease];
    return dictionary;
}
+(Page *)dictionaryToObject :(NSDictionary *)dictionary{
    Page *pageObject= [[[Page alloc]init] autorelease];
    pageObject.created_at   = [Utility stringToDate:[dictionary valueForKey:@"created_at"]];
    pageObject.folder_id    = [Utility checkNullValues:[dictionary valueForKey:@"folder_id"]];
    pageObject.Id           = [Utility checkNSnumberValue:[dictionary valueForKey:@"id"]];
    pageObject.image        = [Utility checkNullValues:[dictionary valueForKey:@"image"]];
    pageObject.thumb        = [Utility checkNullValues:[dictionary valueForKey:@"thumb"]];
    pageObject.lat          = [Utility checkNSnumberValue:[dictionary valueForKey:@"lat"]];
    pageObject.lng          = [Utility checkNSnumberValue:[dictionary valueForKey:@"lng"]];
    pageObject.phone        = [Utility checkNullValues:[dictionary valueForKey:@"phone"]];
    pageObject.property_id  = [Utility checkNullValues:[dictionary valueForKey:@"property_id"]];
    pageObject.text         = [Utility checkNullValues:[dictionary valueForKey:@"text"]];
    pageObject.title        = [Utility checkNullValues:[dictionary valueForKey:@"title"]];
    pageObject.updated_at   = [Utility stringToDate:[dictionary valueForKey:@"updated_at"]];
    pageObject.website      = [Utility checkNullValues:[dictionary valueForKey:@"website"]];
    [Utility downLoadImage:pageObject.image];
    [Utility downLoadImage:pageObject.thumb];
    return pageObject;
}
@end
