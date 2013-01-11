//
//  SearchViewController500.m
//  MSSNGR
//
//  Created by uraan on 11/23/11.
//  Copyright 2011 Coeus Solutions. All rights reserved.
//

#import "SearchViewController500.h"
#import "User.h"
#import "MSSNMessage.h"
#import "Folder.h"
#import "Page.h"
#import "PagesViewController.h"
#import "PageDetailViewController.h"
#import "ConventionalMessageDetailViewController.h"
#import "Helper.h"
#import "Utility.h"
@implementation SearchViewController500

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

-(void)viewWillAppear:(BOOL)animated
{
    [searchResultsTableView deselectRowAtIndexPath:searchResultsTableView.indexPathForSelectedRow animated:YES];
}
-(void)viewDidAppear:(BOOL)animated{
   [[Singleton sharedSingleton] setTarget:self]; 
    [[Singleton sharedSingleton] getAllDirectories];
    [[Singleton sharedSingleton] getHotelMessages];
}
-(IBAction)backButtonAction
{
    [Singleton sharedSingleton].hideSearchButton = FALSE;
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[Singleton sharedSingleton] setTarget:nil];
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
-(void)viewWillUnload{
    [super viewWillUnload];
}
- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = NO; 
    self.navigationItem.title=NSLocalizedString(@"Search",@"Search");
    searchedDirectoryArray = [[NSMutableArray alloc] init];
	searchedHotelMessages = [[NSMutableArray alloc] init];
    sectionTitles = [[NSMutableArray alloc]init];
    [Singleton sharedSingleton].hideSearchButton = TRUE;
    [searchBar setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:NO title:NSLocalizedString(@"Search",@"Search")];
}
-(void)emptyAllArrays{
    [searchedDirectoryArray removeAllObjects];
    [searchedHotelMessages removeAllObjects];
    [sectionTitles removeAllObjects];
}
-(void)refillArrays{
    [self emptyAllArrays];
    if (searchedDirectoryArray.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:@"Directory (%d)",searchedDirectoryArray.count];
        [sectionTitles addObject:sectionTitle];
    }
    if (searchedHotelMessages.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:NSLocalizedString(@"Activities (%d)", @"Activities search header"),searchedHotelMessages.count];
        [sectionTitles addObject:sectionTitle];
    }
}
#pragma mark UITableView Delegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    [headerView setBackgroundColor:[UIColor darkGrayColor]];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10,0, tableView.bounds.size.width,30)] autorelease];
    label.text = [sectionTitles objectAtIndex:section];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [sectionTitles count];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{	
    return [sectionTitles objectAtIndex:section];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSString *sectionTitle1 = [NSString stringWithFormat:NSLocalizedString(@"Directory (%d)",@"Directories search header"),searchedDirectoryArray.count];
    NSString *sectionTitle2 = [NSString stringWithFormat:NSLocalizedString(@"Activities (%d)",@"Activities search header"),searchedHotelMessages.count];
    if ([sectionTitle isEqualToString:sectionTitle1]) {
        return [searchedDirectoryArray count];
    }
    if ([sectionTitle isEqualToString:sectionTitle2]) {
        return [searchedHotelMessages count];
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSSNMessage *msgObject=nil;
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSString *sectionTitle1 = [NSString stringWithFormat:NSLocalizedString(@"Directory (%d)",@"Directories search header"),searchedDirectoryArray.count];
    NSString *sectionTitle2 = [NSString stringWithFormat:NSLocalizedString(@"Activities (%d)",@"Activities search header"),searchedHotelMessages.count];
    if ([sectionTitle isEqualToString:sectionTitle1]) {
        UITableViewCell *directoryCell=[tableView dequeueReusableCellWithIdentifier:@"directoryCell"];
        if(directoryCell==nil)
        {
            directoryCell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"directoryCell"]autorelease];
            [directoryCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
            directoryCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            directoryCell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        NSObject *obj = [searchedDirectoryArray objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[Folder class]])
            directoryCell.textLabel.text=((Folder *)obj).name;
        else
        {
            if ([obj isKindOfClass:[Page class]]) 
                directoryCell.textLabel.text=((Page *)obj).title;
        }
        return directoryCell;
    }
    if ([sectionTitle isEqualToString:sectionTitle2]) {
        msgObject = [searchedHotelMessages objectAtIndex:indexPath.row];
    }
    UITableViewCellStyle style = UITableViewCellStyleSubtitle;
    UITableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell"]; 
    if (!messageCell) {
        messageCell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"MessageCell"] autorelease];
        [messageCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        messageCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    messageCell.textLabel.text= [NSString stringWithFormat:@"%@ %@", [msgObject getMessageTimeforTitle], msgObject.title];

    return messageCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MSSNMessage *msgObject=nil;
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSString *sectionTitle1 = [NSString stringWithFormat:NSLocalizedString(@"Directory (%d)",@"Directories search header"),searchedDirectoryArray.count];
    NSString *sectionTitle2 = [NSString stringWithFormat:NSLocalizedString(@"Activities (%d)",@"Activities search header"),searchedHotelMessages.count];
    if ([sectionTitle isEqualToString:sectionTitle1]) {
        msgObject = nil;
        NSObject *obj = [searchedDirectoryArray objectAtIndex:indexPath.row];
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
    }else{
        if ([sectionTitle isEqualToString:sectionTitle2]) {
            msgObject = [searchedHotelMessages objectAtIndex:indexPath.row];
        }
        ConventionalMessageDetailViewController *PDVC_Obj = [[ConventionalMessageDetailViewController alloc] initWithNibName:@"ConventionalMessageDetailViewController" bundle:nil];
        PDVC_Obj.message = msgObject;
        [self.navigationController pushViewController:PDVC_Obj animated:YES];
        [PDVC_Obj release];
    }
}
- (void)didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
    [searchedHotelMessages release];
	[searchedDirectoryArray release];
    [sectionTitles release];
    [super dealloc];
}
#pragma mark SearchDisplay ViewController

- (void)searchBar:(UISearchBar *)bar textDidChange:(NSString *)searchText 
{
    if(![self.searchDisplayController.searchBar isFirstResponder]) 
	{
        [self refillArrays];
    }
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self refillArrays];
   	[searchResultsTableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self emptyAllArrays];
    Singleton *obj = [Singleton sharedSingleton];
    NSPredicate *resultPredicate = [NSPredicate 
									predicateWithFormat:@"title contains[cd] %@ || text contains[cd] %@",
                                    searchText,searchText];
    
    NSArray *arr2  = [obj.hotelMessages filteredArrayUsingPredicate:resultPredicate];
	[searchedHotelMessages addObjectsFromArray:arr2];
    
	resultPredicate = [NSPredicate 
					   predicateWithFormat:@"title contains[cd] %@ || text contains[cd] %@",
					   searchText,searchText];
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (id object in obj.directories) {
        [temp addObject:object];
        if ([object isKindOfClass:[Folder class]]) {
            NSArray *pages = [(Folder *)object pages];
            for (Page *page in pages) {
                [temp addObject:page];
            }
        }
    }
    
    NSArray *arr  = [temp filteredArrayUsingPredicate:resultPredicate];
    [searchedDirectoryArray addObjectsFromArray:arr];
    
    [temp release];
    if (searchedDirectoryArray.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:NSLocalizedString(@"Directory (%d)",@"Directories search header"),searchedDirectoryArray.count];
        [sectionTitles addObject:sectionTitle];
    }
    if (searchedHotelMessages.count > 0) {
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"start" ascending:TRUE];
        [searchedHotelMessages sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        NSString *sectionTitle = [NSString stringWithFormat:NSLocalizedString(@"Activities (%d)",@"Activities search header"),searchedHotelMessages.count];
        [sectionTitles addObject:sectionTitle];
    }
	[searchResultsTableView reloadData];
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
#pragma mark - UISearchDisplayController delegate methods


-(BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] 
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    
    return YES;
}

- (void)reloadOnDirectories
{
    [self refillArrays];
    [searchResultsTableView reloadData];
}
- (void)reloadOnMessages{
    [self refillArrays];
    Singleton *obj = [Singleton sharedSingleton];
    [obj resetStarMessages];
    [searchResultsTableView reloadData];
}

@end
