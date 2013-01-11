//
//  Convention.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Convention : NSObject
{	
	NSNumber *_Id;	
	NSString *_title;
	NSString *_code;
    NSString *_text;
    NSNumber *_lat;
    NSNumber *_lng;
    NSString *_phone;
    NSString *_website;
	NSDate *_start;
	NSDate *_end;
    NSString *_image;
    NSString *_thumb;
}

@property(nonatomic,retain) NSNumber *Id;

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *code;
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) NSNumber *lat;
@property(nonatomic,retain) NSNumber *lng;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *website;
@property(nonatomic,retain) NSString *image;
@property(nonatomic,retain) NSString *thumb;

@property(nonatomic,retain) NSDate *start;
@property(nonatomic,retain) NSDate *end;
-(NSDictionary *)objectToDisctionary;
+(Convention *)dictionaryToObject :(NSDictionary *)dictionary;
-(BOOL)validCoordinates;
@end
