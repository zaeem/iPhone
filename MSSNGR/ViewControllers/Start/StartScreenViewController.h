//
//  StartScreen.h
//  MSSNGR
//
//  Created by uraan on 11/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMapper.h"
#import "Singleton.h"
@interface StartScreenViewController : UIViewController <UserMapperCallBacks,SingletonNotification>{
    IBOutlet UIActivityIndicatorView *loader;
    UserMapper *mapper;
}
-(void)nextScreen;
@end
