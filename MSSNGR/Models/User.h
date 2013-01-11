//
//  User.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    NSString *_token;
    Boolean _returningUser;
}
@property(nonatomic,readwrite) Boolean returningUser;
@property(nonatomic,retain) NSString *token;
@end
