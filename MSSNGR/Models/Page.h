//
//  Directory.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Page : NSObject{
    NSNumber *_Id;
    NSString *_title;
    NSString *_text;
    NSNumber *_lat;
    NSNumber *_lng;
    NSString *_phone;
    NSString *_website;
    NSString *_image;
    NSString *_thumb;
    
    NSDate *_created_at;
    NSString *_folder_id;
    NSString *_property_id;
    NSDate *_updated_at;
    Boolean _favouriteMarked;
}
@property(nonatomic,retain) NSDate *created_at;
@property(nonatomic,retain) NSString *folder_id;
@property(nonatomic,retain) NSNumber *Id;
@property(nonatomic,retain) NSString *image;
@property(nonatomic,retain) NSString *thumb;
@property(nonatomic,retain) NSNumber *lat;
@property(nonatomic,retain) NSNumber *lng;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *property_id;
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSDate *updated_at;
@property(nonatomic,retain) NSString *website;
@property(nonatomic,readwrite) Boolean favouriteMarked;

-(BOOL)validCoordinates;
-(NSDictionary *)objectToDisctionary;
-(NSString*)name;
+(Page *)dictionaryToObject :(NSDictionary *)dictionary;
@end
