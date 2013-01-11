//
//  Folder.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Page;
@interface Folder : NSObject{
    NSNumber *_Id;
    NSString *_name;
    NSString *_title;
    NSMutableArray *_pages;
    NSString *_text;
    NSString *_thumb;
}
@property(nonatomic,retain) NSNumber *Id;
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) NSString *thumb;
@property(nonatomic,retain) NSMutableArray *pages;
@end
