//
//  WhatsGoingOnViewController110.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/20/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "WhatsGoingOnViewController110.h"
#import "ConventionalMessageDetailViewController.h"
#import "SearchViewController500.h"
#import "WeatherViewController.h"
#import "Utility.h"

#define kMyActivitiesIndex 0
#define kStarredActivitiesIndex 1
#define kAllActivitiesIndex 2

@implementation WhatsGoingOnViewController110
@synthesize navTitle;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:@"Activities" image:[UIImage imageNamed:@"tab-01-activities"] tag:0];
        [self setTabBarItem:item];
        [item release];
        self.title = NSLocalizedString(@"Activities",@"Activities");
    }
    return self;
}

-(void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{ 
    [messageSegmentControll setTitle:NSLocalizedString(@"My Activities", @"") forSegmentAtIndex:kMyActivitiesIndex];
    [messageSegmentControll setTitle:NSLocalizedString(@"All", @"") forSegmentAtIndex:kAllActivitiesIndex];
    [messagesTableView deselectRowAtIndexPath:messagesTableView.indexPathForSelectedRow animated:YES];
    [Utility addNavigationAnimation:self.navTitle];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[Singleton sharedSingleton] setTarget:nil];
}
-(void)viewDidAppear:(BOOL)animated{
    [[Singleton sharedSingleton] setTarget:self];
    [[Singleton sharedSingleton] getUserMessages];
    [[Singleton sharedSingleton] getHotelMessages];
    [self reloadStarMessages];
    [weatherController reloadWeather];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //NSString *title=[NSString stringWithFormat:@"Activities - %@",[MySingleton sharedSingleton].checkedInHotel.name];
    NSString *title=[NSString stringWithFormat:@"%@",[Singleton sharedSingleton].checkedInHotel.name];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:NO addSearchButton:YES title:title];
    [[Singleton sharedSingleton] setTarget:self];
	_tomorrowArray = [[NSMutableArray alloc] init];
    _agendaArray = [[NSMutableArray alloc] init];
    _favouriteMessages = [[NSMutableArray alloc] init]; 
    myMessagesArray = [[NSMutableArray alloc] init]; 
    //[messageSegmentControll setWidth:90 forSegmentAtIndex:0];
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
-(void)dealloc{
    [weatherController release];
    [_tomorrowArray release];
    [_agendaArray release];
    [_favouriteMessages release];
    [messagesTableView release];
    [messageSegmentControll release];
    [myMessagesArray release];
    _agendaArray = nil;
    messageSegmentControll = nil;
    messagesTableView = nil;
    _favouriteMessages = nil;
    _tomorrowArray=nil;
    [super dealloc];
}
#pragma mark segmentControlAction


-(IBAction)segmentControlAction:(id)sender
{
    [messagesTableView reloadData];
}



#pragma mark UITableView Delegate

-(NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    switch (messageSegmentControll.selectedSegmentIndex) 
	{
		case kMyActivitiesIndex:
            return [[[myMessagesArray objectAtIndex:section] objectAtIndex:1] count];
			break;
		case kStarredActivitiesIndex:
            return [_favouriteMessages count];
			break;
		case kAllActivitiesIndex:{
            NSString *sectionTitle = [sectionTitles objectAtIndex:section];
            if ([sectionTitle isEqualToString:NSLocalizedString(@"Agenda",@"Agenda")]) {
                return [_agendaArray count];
            }
            if ([sectionTitle isEqualToString:NSLocalizedString(@"Tomorrow",@"Tomorrow")]) {
                return [_tomorrowArray count];
            }
            break;
        }
		default:
            return kMyActivitiesIndex;
            break;
	}
    return kMyActivitiesIndex;
}


-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCellStyle style = UITableViewCellStyleSubtitle;
    UITableViewCell *cell = [aTableView
                             dequeueReusableCellWithIdentifier:@"BaseCell"]; 
    
    if (!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:style reuseIdentifier:@"BaseCell"] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    MSSNMessage *messageObject=nil;
    switch (messageSegmentControll.selectedSegmentIndex) 
	{
		case kMyActivitiesIndex:
            messageObject = [[[myMessagesArray objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
			break;
		case kStarredActivitiesIndex:
            messageObject = [_favouriteMessages objectAtIndex:indexPath.row];
			break;
		case kAllActivitiesIndex:{
            NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
            if ([sectionTitle isEqualToString:NSLocalizedString(@"Agenda",@"Agenda")]) {
                messageObject = [_agendaArray objectAtIndex:indexPath.row];
            }
            if ([sectionTitle isEqualToString:NSLocalizedString(@"Tomorrow",@"Tomorrow")]) {
                messageObject = [_tomorrowArray objectAtIndex:indexPath.row];
            }
        break;
        }
		default:{
            messageObject=nil;
            break;
        }
	}
    cell.textLabel.text= [NSString stringWithFormat:@"%@ %@", [messageObject getMessageTimeforTitle], messageObject.title];
	return cell;
}

-(void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSSNMessage *messageObject=nil;
    switch (messageSegmentControll.selectedSegmentIndex) 
	{
		case kMyActivitiesIndex:
            messageObject = [[[myMessagesArray objectAtIndex:indexPath.section] objectAtIndex:1] objectAtIndex:indexPath.row];
			break;
		case kStarredActivitiesIndex:
            messageObject = [_favouriteMessages objectAtIndex:indexPath.row];
			break;
        case kAllActivitiesIndex:
        {
            NSString *sectionTitle = [sectionTitles objectAtIndex:indexPath.section];
            if ([sectionTitle isEqualToString:NSLocalizedString(@"Agenda",@"Agenda")]) {
                messageObject = [_agendaArray objectAtIndex:indexPath.row];
            }else{
                if ([sectionTitle isEqualToString:NSLocalizedString(@"Tomorrow",@"Tomorrow")]) {
                    messageObject = [_tomorrowArray objectAtIndex:indexPath.row];
                }
            }
            break;
        }
		default:
            messageObject=nil;
            break;
	}

		ConventionalMessageDetailViewController *PDVC_Obj = [[ConventionalMessageDetailViewController alloc] initWithNibName:@"ConventionalMessageDetailViewController" bundle:nil];
    PDVC_Obj.message = messageObject;
		[self.navigationController pushViewController:PDVC_Obj animated:YES];
		[PDVC_Obj release];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (messageSegmentControll.selectedSegmentIndex == kMyActivitiesIndex) {
        return [myMessagesArray count];
    } else if (messageSegmentControll.selectedSegmentIndex == kAllActivitiesIndex) {
        return [sectionTitles count];
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 30;
    }else{
        return 0;
    }
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    NSString* title = @"";
    if(messageSegmentControll.selectedSegmentIndex == kMyActivitiesIndex) {
        title = [[myMessagesArray objectAtIndex:section] objectAtIndex:0];
        if ([title isEqualToString:NSLocalizedString(@"Agenda",@"Agenda")])
            return nil;
    }    
    else if (messageSegmentControll.selectedSegmentIndex == kAllActivitiesIndex) {
        NSString *sectionTitle = [sectionTitles objectAtIndex:section];
        if ([sectionTitle isEqualToString:NSLocalizedString(@"Agenda",@"Agenda")]) {
            return nil;
        }
        if ([sectionTitle isEqualToString:NSLocalizedString(@"Tomorrow",@"Tomorrow")]) {
            title = [sectionTitles objectAtIndex:section];
        }
    }else{
        return nil;
    }
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    [headerView setBackgroundColor:[UIColor darkGrayColor]];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10,0, tableView.bounds.size.width,30)] autorelease];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)reloadOnMessages{
    [_loader startAnimating];
    NSDate *nextMidNight = [Utility timeTillNextDayMidNight];
    NSDate *todayEndTime = [Utility dayEndTime];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"start" ascending:TRUE];
    NSPredicate *resultPredicate = [NSPredicate 
                                    predicateWithFormat:@"end => %@ && start <= %@ && start <= %@",
                                    [NSDate date],
                                    nextMidNight,todayEndTime];
    NSArray *arr  = [[Singleton sharedSingleton].hotelMessages filteredArrayUsingPredicate:resultPredicate];
    if (_tomorrowArray==nil) {
        _tomorrowArray=[[NSMutableArray alloc]init];
    }
    if (_agendaArray==nil) {
        _agendaArray=[[NSMutableArray alloc]init];
    }
    if (_favouriteMessages == nil) {
        _favouriteMessages = [[NSMutableArray alloc]init];
    }
    if (sectionTitles == nil) {
        sectionTitles = [[NSMutableArray alloc]init];
    }
    [sectionTitles removeAllObjects];
    [_tomorrowArray removeAllObjects];
    [_agendaArray removeAllObjects];
    [myMessagesArray removeAllObjects];
    [_agendaArray addObjectsFromArray:arr];
    NSArray* myToday = [[Singleton sharedSingleton].userMessages filteredArrayUsingPredicate:resultPredicate];
    if ([myToday count] > 0) {
        NSMutableArray* tmp = [NSMutableArray arrayWithArray:myToday];
        [tmp sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [myMessagesArray addObject:[NSArray arrayWithObjects:NSLocalizedString(@"Agenda",@"Agenda"), tmp, nil]];
    }
    resultPredicate = [NSPredicate 
                       predicateWithFormat:@"start > %@",
                       todayEndTime];
    arr  = [[Singleton sharedSingleton].hotelMessages filteredArrayUsingPredicate:resultPredicate];
    [_tomorrowArray addObjectsFromArray:arr];
    
    NSArray* myTomorrow = [[Singleton sharedSingleton].userMessages filteredArrayUsingPredicate:resultPredicate];
    if ([myTomorrow count] > 0) {
        NSMutableArray* tmp = [NSMutableArray arrayWithArray:myTomorrow];
        [tmp sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [myMessagesArray addObject:[NSArray arrayWithObjects:NSLocalizedString(@"Tomorrow",@"Tomorrow"), tmp, nil]];
    }
    [_tomorrowArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [_agendaArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    if ([_agendaArray count] > 0) {
        [sectionTitles addObject:NSLocalizedString(@"Agenda",@"Agenda")];
    }
    if ([_tomorrowArray count] > 0) {
        [sectionTitles addObject:NSLocalizedString(@"Tomorrow",@"Tomorrow")];
    }
    [self reloadStarMessages];
    [_loader stopAnimating];
}
-(void)reloadStarMessages{
    [_favouriteMessages removeAllObjects];
    Singleton *obj = [Singleton sharedSingleton];
    [obj resetStarMessages];
    
     NSPredicate *resultPredicate = [NSPredicate 
                       predicateWithFormat:@"favouriteMarked = %@",
                       [NSNumber numberWithBool: YES]];
    NSArray *arr  = [obj.hotelMessages filteredArrayUsingPredicate:resultPredicate];
	[_favouriteMessages addObjectsFromArray:arr];
    [messagesTableView reloadData];
}
-(void)reloadOnPushNotification{
    messageSegmentControll.selectedSegmentIndex = kMyActivitiesIndex;
}
-(void)startSpinner{
    [_loader startAnimating];
}
@end
