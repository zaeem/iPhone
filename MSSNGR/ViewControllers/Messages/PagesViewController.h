//
//  PagesViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Folder;
@interface PagesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    Folder *_folder;
    IBOutlet UITableView *tblPages;
}
@property(nonatomic,retain) Folder *folder;
-(IBAction)backButtonAction;
@end
