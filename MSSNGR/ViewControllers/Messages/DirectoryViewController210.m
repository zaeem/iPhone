//
//  DirectoryViewController210.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "DirectoryViewController210.h"
#import "Folder.h"
#import "Page.h"
#import "PageDetailViewController.h"
#import "PagesViewController.h"
#import "User.h"
#import "SearchViewController500.h"
#import "WeatherViewController.h"
#import "ImageTableRow.h"
#import "Utility.h"
@implementation DirectoryViewController210

@synthesize loader=_loader,navTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Directory",@"Directory") image:[UIImage imageNamed:@"tab-02-directory"] tag:1];
        [self setTabBarItem:item];
        [item release];
        self.title = NSLocalizedString(@"Directory",@"Directory");
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)dealloc
{
    [tblDirectory release];
    [weatherController release];
    tblDirectory=nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [tblDirectory deselectRowAtIndexPath:tblDirectory.indexPathForSelectedRow animated:YES];
    [Utility addNavigationAnimation:self.navTitle];
}
-(void)viewDidAppear:(BOOL)animated{
    [Singleton sharedSingleton].target = self;
    [[Singleton sharedSingleton] getAllDirectories];
    [[Singleton sharedSingleton] resetStarPages];
    [weatherController reloadWeather];
}
-(void)viewWillDisappear:(BOOL)animated{
    [Singleton sharedSingleton].target = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *title=[NSString stringWithFormat:@"%@",[Singleton sharedSingleton].checkedInHotel.name];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:YES title:title];
    [Singleton sharedSingleton].target = self;
     if (![Singleton sharedSingleton].hideSearchButton) {
         UIBarButtonItem *searchButton = [[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonAction)]autorelease];
         self.navigationItem.rightBarButtonItem = searchButton;
     }
    weatherController = [[WeatherViewController alloc]init];
    [weatherController.view setFrame:CGRectMake(0,325, 320,86)];
    [self.view addSubview:weatherController.view];    
}
-(IBAction)searchButtonAction
{
	SearchViewController500 *searchObject = [[SearchViewController500 alloc] initWithNibName:@"SearchViewController500" bundle:nil];
	searchObject.hidesBottomBarWhenPushed=TRUE;
    [self.navigationController pushViewController:searchObject animated:YES];
	[searchObject release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma directory tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageTableRow *directoryCell = (ImageTableRow *)[tableView dequeueReusableCellWithIdentifier:@"directoryCell"];
    if(directoryCell==nil)
    {
        directoryCell= [[[NSBundle mainBundle] loadNibNamed:@"ImageTableRow" owner:self options:nil]objectAtIndex:0];
        [directoryCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        directoryCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        directoryCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    NSObject *obj = [[Singleton sharedSingleton].directories objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[Folder class]]) {
        Folder *folder = ((Folder *)obj);
         directoryCell.textLabel.text=folder.name;
        
        if (![folder.thumb isEqualToString:@""]) 
         [directoryCell.thumbImage loadImageFromURLString:folder.thumb];
    }else{
        if ([obj isKindOfClass:[Page class]]) {
            directoryCell.textLabel.text=((Page *)obj).title;
            [directoryCell.thumbImage loadImageFromURLString:((Page *)obj).thumb];
        }
    }
    return directoryCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *obj = [[Singleton sharedSingleton].directories objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[Folder class]]) {
        PagesViewController *controller = [[PagesViewController alloc]init];
        controller.folder = (Folder *)obj;
        [self.navigationController pushViewController:controller animated:YES];
        [controller release];
    }else{
        if ([obj isKindOfClass:[Page class]]) {
            PageDetailViewController *controller = [[PageDetailViewController alloc]init];
            controller.pageDetails=(Page *)obj;
            [self.navigationController pushViewController:controller animated:YES];
            [controller release];
        }
    }

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[Singleton sharedSingleton].directories count];
}
- (void)reloadOnDirectories
{
    [[Singleton sharedSingleton] resetStarPages];    
    [tblDirectory reloadData];
}
@end
