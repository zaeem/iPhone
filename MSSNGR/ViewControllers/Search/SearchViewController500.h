//
//  SearchViewController500.h
//  MSSNGR
//
//  Created by uraan on 11/23/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@interface SearchViewController500 : UIViewController <UITableViewDelegate, UITableViewDataSource,SingletonNotification>
{
	IBOutlet UITableView *searchResultsTableView;
	NSMutableArray *searchedDirectoryArray;
	NSMutableArray *searchedHotelMessages;
    NSMutableArray *sectionTitles;
    IBOutlet UISearchBar *searchBar;
    Boolean searching;
}
-(void)refillArrays;
-(void)emptyAllArrays;
@end
