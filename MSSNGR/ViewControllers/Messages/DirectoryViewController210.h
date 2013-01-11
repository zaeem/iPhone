//
//  DirectoryViewController210.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@class WeatherViewController;
@interface DirectoryViewController210 : UIViewController<UITableViewDelegate,UITableViewDataSource,SingletonNotification>{
    IBOutlet UITableView *tblDirectory;
    WeatherViewController *weatherController;
    IBOutlet UIActivityIndicatorView *_loader;
}
@property(nonatomic,retain) UILabel *navTitle;
@property (nonatomic, assign) UIActivityIndicatorView *loader;
- (void)reloadOnDirectories;
@end
