//
//  InterestGroup.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 12/12/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface InterestGroup : NSObject{
    NSString *_name;
    NSMutableArray *_interests;
}
@property(nonatomic,retain) NSString *name;
@property(nonatomic,retain) NSMutableArray *interests;
@end
