//
//  Hotel.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Hotel : NSObject{
    NSNumber *_Id;
    NSString *_name;
    NSString *_street;
    NSString *_zip;
    NSString *_city;
    NSNumber *_lat;
    NSNumber *_lng;
    NSString *_description;
    NSString *_phone;
    NSString *_website;
    NSString *_image;
    NSString *_thumb;
}
@property(nonatomic,retain) NSNumber *Id;
@property(nonatomic,retain) NSString *zip;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *street;
@property(nonatomic,retain) NSString *city;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *phone;
@property(nonatomic,retain) NSString *website;
@property(nonatomic,retain) NSNumber *lat;
@property(nonatomic,retain) NSNumber *lng;
@property(nonatomic,retain) NSString *image;
@property(nonatomic,retain) NSString *thumb;
-(NSDictionary *)objectToDisctionary;
+(Hotel *)dictionaryToObject :(NSDictionary *)dictionary;
-(BOOL)validCoordinates;
@end
