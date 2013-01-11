//
//  Message.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "MSSNMessage.h"
#import "Utility.h"
@implementation MSSNMessage
@synthesize Id=_Id,lat=_lat,lng=_lng,title=_title,limit=_limit,text=_text,phone=_phone,website=_website,start=_start,end=_end,favouriteMarked=_favouriteMarked,image=_image,thumb=_thumb,show_in_agenda=_show_in_agenda;
-(void)dealloc{
    [_Id release];
    [_limit release];
    [_title release];
    [_text release];
    [_phone release];
    [_website release];
    [_start release];
    [_end release];
    [_lat release];
    [_lng release];
    [_image release];
    [_thumb release];
    _thumb = nil;
    _image=nil;
    _Id=nil;
    _limit=nil;
    _title=nil;
    _text=nil;
    _phone=nil;
    _website=nil;
    _start=nil;
    _end=nil;
    _lat=nil;
    _lng=nil;
    [super dealloc];
}
-(NSString *)getMessageTimeFormattedString{
    if (_start !=nil && _end!=nil) {
        if ([[Utility DateToString:_start :@"yyyy"] isEqualToString:[Utility DateToString:_end :@"yyyy"]] && [[Utility DateToString:_start :@"MM"] isEqualToString:[Utility DateToString:_end :@"MM"]] && [[Utility DateToString:_start :@"dd"] isEqualToString:[Utility DateToString:_end :@"dd"]]) {
            
            return [NSString stringWithFormat:@"%@.%@.%@, %@:%@ - %@:%@",[Utility DateToString:_start :@"dd"],[Utility DateToString:_start :@"MM"],[Utility DateToString:_start :@"yy"],[Utility DateToString:_start :@"HH"],[Utility DateToString:_start :@"mm"],[Utility DateToString:_end :@"HH"],[Utility DateToString:_end :@"mm"]];
        }else{
            return [NSString stringWithFormat:@"%@.%@.%@, %@:%@ - %@.%@.%@, %@:%@",[Utility DateToString:_start :@"dd"],[Utility DateToString:_start :@"MM"],[Utility DateToString:_start :@"yy"],[Utility DateToString:_start :@"HH"],[Utility DateToString:_start :@"mm"],[Utility DateToString:_end :@"dd"],[Utility DateToString:_end :@"MM"],[Utility DateToString:_end :@"yy"],[Utility DateToString:_end :@"HH"],[Utility DateToString:_end :@"mm"]];
            
        }
    }else{
        if (_start!=nil) {
            return [NSString stringWithFormat:@"%@.%@.%@, %@:%@",[Utility DateToString:_start :@"dd"],[Utility DateToString:_start :@"MM"],[Utility DateToString:_start :@"yy"],[Utility DateToString:_start :@"HH"],[Utility DateToString:_start :@"mm"]];
        }
        if (_end!=nil) {
            return [NSString stringWithFormat:@"- %@.%@.%@, %@:%@",[Utility DateToString:_end :@"dd"],[Utility DateToString:_end :@"MM"],[Utility DateToString:_end :@"yy"],[Utility DateToString:_end :@"HH"],[Utility DateToString:_end :@"mm"]];
        }
        return @"";
    }
}

-(NSString *)getMessageTimeforTitle{
    NSString *formattedStart = [Utility DateToString:_start :@"HH:mm"];
    NSString *formattedEnd = [Utility DateToString:_end :@"HH:mm"];
    return [NSString stringWithFormat:@"%@-%@", formattedStart, formattedEnd];
}
-(BOOL)validCoordinates{
    if ([self.lat isKindOfClass:[NSNumber class]] && [self.lng isKindOfClass:[NSNumber class]]) {
        return true;
    }else{
        return false;
    }
}

+(MSSNMessage *)dictionaryToObject :(NSDictionary *)dictionary{
    MSSNMessage *message = [[[MSSNMessage alloc]init] autorelease];
    message.Id       = [Utility checkNSnumberValue:[dictionary valueForKey:@"id"]];
    message.title    = [Utility checkNullValues:[dictionary valueForKey:@"title"]];
    message.text     = [Utility checkNullValues:[dictionary valueForKey:@"text"]];
    message.lat      = [Utility checkNSnumberValue:[dictionary valueForKey:@"lat"]];
    message.lng      = [Utility checkNSnumberValue:[dictionary valueForKey:@"lng"]];
    message.phone    = [Utility checkNullValues:[dictionary valueForKey:@"phone"]];
    message.website  = [Utility checkNullValues:[dictionary valueForKey:@"website"]];
    message.image =[Utility checkNullValues:[dictionary valueForKey:@"image"]]; 
    message.thumb =[Utility checkNullValues:[dictionary valueForKey:@"thumb"]]; 
    message.start = [Utility stringToDate:[dictionary valueForKey:@"start"]];
    message.end = [Utility stringToDate:[dictionary valueForKey:@"end"]];   
    message.limit    = [Utility checkNullValues:[dictionary valueForKey:@"limit"]];
    if ([dictionary valueForKey:@"show_in_agenda"]) {
        message.show_in_agenda    = [[Utility checkNullValues:[dictionary valueForKey:@"show_in_agenda"]] intValue];
    }else{
        message.show_in_agenda    = NO;
    }
    [Utility downLoadImage:message.image];
    [Utility downLoadImage:message.thumb];
    return message;
}
@end
