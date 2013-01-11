//
//  ParticipatingHotelsViewController.h
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserMapper.h"
#import "Singleton.h"
#import "Hotel.h"
@interface ParticipatingHotelsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate,UISearchBarDelegate,SingletonNotification>{
    NSMutableArray *_searchedNearByHotels;
	NSMutableArray *_searchedAllHotels;
	IBOutlet UITableView *tblHotels;
    UserMapper *usermapper;
    IBOutlet UIActivityIndicatorView *loader;
    IBOutlet UISearchBar *searchBar;
    IBOutlet UITextView *participatingHotelsMessage;	
    Boolean _loadData;
    NSMutableArray *sectionTitles;
}
@property(nonatomic,readwrite) Boolean loadData;
-(IBAction)nextButtonAction;
-(IBAction)backButtonAction;
-(void)detailHotels:(Hotel *)hotel;
-(void)checkInHotel:(Hotel *)hotel;
-(void)refillArrays;
@end
