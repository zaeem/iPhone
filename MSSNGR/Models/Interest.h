//
//  Interest.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Interest : NSObject{
    NSNumber *_Id;
    NSString *_name;
    BOOL _selected;
}
@property(nonatomic,readwrite) BOOL selected;
@property(nonatomic,retain) NSNumber *Id;
@property(nonatomic,retain) NSString *name;
+(Interest *)dictionaryToObject :(NSDictionary *)dictionary;
@end
