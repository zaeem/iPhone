//
//  WhatsGoingOnViewController110.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@class WeatherViewController;
@interface WhatsGoingOnViewController110 : UIViewController <UITableViewDataSource, UITableViewDelegate,SingletonNotification>
{
	IBOutlet UITableView *messagesTableView;
	NSMutableArray *_tomorrowArray;
    NSMutableArray *_agendaArray;
    NSMutableArray *_favouriteMessages;
	NSMutableArray *sectionTitles;
    NSMutableArray *myMessagesArray;
	IBOutlet UISegmentedControl *messageSegmentControll;
    WeatherViewController *weatherController;
    IBOutlet UIActivityIndicatorView *_loader;
}
@property(nonatomic,retain) UILabel *navTitle;
-(IBAction)segmentControlAction:(id)sender; 
-(void)reloadStarMessages;
-(void)reloadOnPushNotification;
-(void)startSpinner;
@end
