//
//  ParticipatingHotelsViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "ParticipatingHotelsViewController.h"
#import "PropertyCell.h"
#import "HotelDetailViewController.h"
#import "User.h"
#import "Hotel.h"
#import "Singleton.h"
#import "WhatsGoingOnViewController110.h"
#import "Utility.h"
#import "Helper.h"
@implementation ParticipatingHotelsViewController
@synthesize loadData=_loadData;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
-(void)viewWillAppear:(BOOL)animated
{
    [tblHotels deselectRowAtIndexPath:tblHotels.indexPathForSelectedRow animated:YES];
    [participatingHotelsMessage setText: NSLocalizedString(@"You can use MSSNGR here:", @"")];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[Singleton sharedSingleton] setTarget:nil];
    [[Singleton sharedSingleton].locationManager stopUpdatingLocation];
}
-(void)viewDidAppear:(BOOL)animated{
    [[Singleton sharedSingleton] setTarget:self];
    if (_loadData) {
        [loader startAnimating];
        [[Singleton sharedSingleton].locationManager startUpdatingLocation];
    }else{
        if ([Singleton sharedSingleton].nearByHotels.count <= 0) {
            [loader startAnimating];
            [[Singleton sharedSingleton] getAllHotels];
        }
    }
    _loadData = TRUE;
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:!self.navigationItem.hidesBackButton addSearchButton:NO title:NSLocalizedString(@"Participating hotels",@"Participating hotels")];
    _searchedNearByHotels = [[NSMutableArray alloc]init];
    _searchedAllHotels = [[NSMutableArray alloc]init];
    sectionTitles = [[NSMutableArray alloc]init];
    [self refillArrays];
    [searchBar setTintColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(void)refillArrays{
    [_searchedNearByHotels removeAllObjects];
    [_searchedAllHotels removeAllObjects];
    [sectionTitles removeAllObjects];
    [_searchedNearByHotels addObjectsFromArray:[[Singleton sharedSingleton] nearByHotels]];
    [_searchedAllHotels addObjectsFromArray:[[Singleton sharedSingleton] allHotels]];
    if (_searchedNearByHotels.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Nearby",@"Nearby"),_searchedNearByHotels.count];
        [sectionTitles addObject:sectionTitle];
    }
    if (_searchedAllHotels.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Other",@"Other"),_searchedAllHotels.count];
        [sectionTitles addObject:sectionTitle];
    }
}
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return [sectionTitles count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{	
    return [sectionTitles objectAtIndex:section];
}
 
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *sectionTitle = [sectionTitles objectAtIndex:section];
    NSString *sectionTitle1 = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Nearby",@"Nearby"),_searchedNearByHotels.count];
    NSString *sectionTitle2 = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Other",@"Other"),_searchedAllHotels.count];
    if ([sectionTitle isEqualToString:sectionTitle1]) {
        return [_searchedNearByHotels count];
    }
    if ([sectionTitle isEqualToString:sectionTitle2]) {
        return [_searchedAllHotels count];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
    NSString *sectionTitle1 = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Nearby",@"Nearby"),_searchedNearByHotels.count];
    NSString *sectionTitle2 = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Other",@"Other"),_searchedAllHotels.count];
    if ([sectionTitle isEqualToString:sectionTitle1]) {
        PropertyCell *cell=(PropertyCell *)[tableView dequeueReusableCellWithIdentifier:@"propertyCustomCell"];
		if(cell==nil)
		{
			cell= [[[NSBundle mainBundle] loadNibNamed:@"PropertyCell" owner:self options:nil]objectAtIndex:0];	
			cell.parent=self;
            [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
		}
		Hotel *hotel=[_searchedNearByHotels objectAtIndex:indexPath.row];
		cell.hotel=hotel;
		cell.cell_Text.text=hotel.name;
		return cell;
    }
    if ([sectionTitle isEqualToString:sectionTitle2]) {
        PropertyCell *cell = (PropertyCell *)[tableView dequeueReusableCellWithIdentifier:@"propertyCustomCell"];
		if (cell == nil)
		{
			cell = [[[NSBundle mainBundle] loadNibNamed:@"PropertyCell" owner:self options:nil] objectAtIndex:0];
			cell.parent = self;
			//cell.checkIn.hidden = YES;
		}
		Hotel *hotel=[_searchedAllHotels objectAtIndex:indexPath.row];
		cell.hotel=hotel;
        if (![hotel.name isKindOfClass:[NSNull class]]) {
            cell.cell_Text.text=hotel.name;
        }
		return cell;
    }
	return nil;
}
-(void)detailHotels:(Hotel *)hotel{
	
	HotelDetailViewController *hotelDetail=[[[HotelDetailViewController alloc]init]autorelease];
	hotelDetail.hotelObj=hotel;
	[self.navigationController pushViewController:hotelDetail animated:YES];
}
-(void)checkInHotel:(Hotel *)hotel
{
    [loader startAnimating];
    if (usermapper == nil) {
        usermapper=[[UserMapper alloc]init];
    }
	usermapper.target=self;
	[usermapper checkIn:[Singleton sharedSingleton].appUser.token :hotel.Id];
    [Singleton sharedSingleton].checkedInHotel =hotel;
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(IBAction)nextButtonAction{
    
}

- (void)dealloc {
    [super dealloc];
    [_searchedAllHotels release];
    [_searchedNearByHotels release];
}
- (void)checkInUserSucceeded:(Result *)result
{
    [loader stopAnimating];
   [Helper writeFileToDisk:[[Singleton sharedSingleton].checkedInHotel objectToDisctionary] :@"checkedInHotel"];
	UITabBarController *tabBarController = [Utility configureMessagesTabBArController];
    [Utility pushAtRootViewControllerOfMainViewController:tabBarController];
}
- (void)checkInUserFailed:(Result *)result
{
    [loader stopAnimating];
    [[Singleton sharedSingleton] releaseCheckInHotel];
}
- (void)searchBar:(UISearchBar *)bar textDidChange:(NSString *)searchText {
    if(![self.searchDisplayController.searchBar isFirstResponder]) {
        [_searchedNearByHotels removeAllObjects];
        [_searchedAllHotels removeAllObjects];
        [_searchedNearByHotels addObjectsFromArray:[[Singleton sharedSingleton] nearByHotels]];
        [_searchedAllHotels addObjectsFromArray:[[Singleton sharedSingleton] allHotels]];
    }
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchedNearByHotels removeAllObjects];
    [_searchedAllHotels removeAllObjects];
    [_searchedNearByHotels addObjectsFromArray:[[Singleton sharedSingleton] nearByHotels]];
    [_searchedAllHotels addObjectsFromArray:[[Singleton sharedSingleton] allHotels]];
}
- (void)filterContentForSearchText:(NSString*)searchText 
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"name contains[cd] %@",
                                    searchText];
    NSArray *arr  = [[[Singleton sharedSingleton] nearByHotels] filteredArrayUsingPredicate:resultPredicate];
    [_searchedNearByHotels removeAllObjects];
    [_searchedNearByHotels addObjectsFromArray:arr];
    NSArray *arr2  = [[[Singleton sharedSingleton] allHotels] filteredArrayUsingPredicate:resultPredicate];
    [_searchedAllHotels removeAllObjects];
    [_searchedAllHotels addObjectsFromArray:arr2];
    
    [sectionTitles removeAllObjects];
    if (_searchedNearByHotels.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Nearby",@"Nearby"),_searchedNearByHotels.count];
        [sectionTitles addObject:sectionTitle];
    }
    if (_searchedAllHotels.count > 0) {
        NSString *sectionTitle = [NSString stringWithFormat:@"%@ (%d)",NSLocalizedString(@"Other",@"Other"),_searchedAllHotels.count];
        [sectionTitles addObject:sectionTitle];
    }
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
- (void)reloadOnAllHotels{
    [loader stopAnimating];
    [self refillArrays];
    [tblHotels reloadData];
}
- (void)reloadOnNearHotels{
    if ([Singleton sharedSingleton].nearByHotels.count > 0) {
        [loader stopAnimating];
        [self refillArrays];
        [tblHotels reloadData];
    }else{
        [[Singleton sharedSingleton] getAllHotels];
    }
}
-(void)reloadOnLocationUpdate{
    [loader startAnimating];
    [[Singleton sharedSingleton] getNearByHotels];
}
@end
