//
//  Result.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/13/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject{
    NSObject *_object;
    NSString *_status;
    NSString *_message;
    Boolean _didUseCachedData;
}
@property(nonatomic,readwrite) Boolean didUseCachedData;
@property(nonatomic,retain) NSObject *object;
@property(nonatomic,retain) NSString *status;
@property(nonatomic,retain) NSString *message;
@end
