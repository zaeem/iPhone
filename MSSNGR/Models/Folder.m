//
//  Folder.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "Folder.h"
#import "Page.h"
@implementation Folder
@synthesize Id=_Id,title=_title,pages=_pages,name=_name,text=_text,thumb=_thumb;
-(void)dealloc{
    [_Id release];
    [_title release];
    [_name release];
    [_pages release];
    [_text release];
    _text = nil;
    _Id=nil;
    _title=nil;
    _pages=nil;
    _name=nil;
    [super dealloc];
}
@end
