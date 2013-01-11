//
//  DefineIntrests.m
//  MSSNGR
//
//  Created by uraan on 11/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DefineInterestsViewController.h"
#import "ParticipatingHotelsViewController.h"
#import "Interest.h"
#import "TermsOfServiceViewController.h"
#import "Singleton.h"
#import "DefineInterestCutomCell.h"
#import "Utility.h"
#import "InterestGroup.h"
@implementation UINavigationBar (UINavigationBarCategory)
- (void)drawRect:(CGRect)rect
{
	UIImage *image = [UIImage imageNamed:@"nav-bg"];
	[image drawInRect:rect];
}
@end
@implementation DefineInterestsViewController
@synthesize all_interest_groups=_all_interest_groups;
@synthesize userToken;
@synthesize userInterest=_userInterest;
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
-(void)viewWillAppear:(BOOL)animated{
    [lblPleaseDefine setText:NSLocalizedString(@"Please indicate your areas of interest:", @"Please indicate your areas of interest:")];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:self.navigationItem.hidesBackButton addBackButton:!self.navigationItem.hidesBackButton addSearchButton:FALSE title:NSLocalizedString(@"My Interests", @"My Interests")];
	mapper=[[InterestMapper alloc]init];
	mapper.target=self;
    [mapper getAllInterests];
}
-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    mapper.target=nil;
    [mapper updateUserInterests:[Singleton sharedSingleton].appUser.token :self.all_interest_groups];
}
-(IBAction)nextButtonAction{
    for (InterestGroup *interestGroup in self.all_interest_groups){
        for (Interest *interest in interestGroup.interests) {
            if (interest.selected) {
                TermsOfServiceViewController *controller=[[TermsOfServiceViewController alloc]init];
                controller.navigationItem.hidesBackButton = YES;
                [self.navigationController pushViewController:controller animated:YES];
                [controller release];
                return;
            }
        }
    }
    UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Invalid:" message:@"Atleast one interest must be selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [servicesDisabledAlert show];
    [servicesDisabledAlert release];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.all_interest_groups.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 
{
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)] autorelease];
    [headerView setBackgroundColor:[UIColor darkGrayColor]];
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10,0, tableView.bounds.size.width,30)] autorelease];
    InterestGroup *group = [self.all_interest_groups objectAtIndex:section];
    label.text = group.name;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label];
    return headerView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    InterestGroup *group = [self.all_interest_groups objectAtIndex:section];
    NSLog(@"group interests count = %d",group.interests.count);
	return [group.interests count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	DefineInterestCutomCell *cell = (DefineInterestCutomCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil)
         {
             // create cell if non are reusable
             cell= [[[NSBundle mainBundle] loadNibNamed:@"DefineInterestCustomCell" owner:self options:nil]objectAtIndex:0];
             cell.parent = self;
         }
    InterestGroup *group = [self.all_interest_groups objectAtIndex:indexPath.section];
    Interest *interest_obj = [group.interests objectAtIndex:indexPath.row];
    cell.interestText.text = interest_obj.name;
    cell.interest = interest_obj;
    [cell.interestSwitch setOn:interest_obj.selected];
    return cell;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)getAllInterestsSucceeded:(Result *)result{
	[result retain];
	self.all_interest_groups=(NSMutableArray *)result.object;
    [mapper getUserInterests:[Singleton sharedSingleton].appUser.token];
    [result release];

}
-(void)getAllInterestsFailed:(Result *)result{
    
}
- (void)getUserInterestsSucceeded:(Result *)result
{
	[result retain];
	self.userInterest=(NSMutableArray *)result.object;
    for(InterestGroup *group in self.all_interest_groups){
    for(Interest *allInterest in group.interests){
        if ([self.userInterest count]==0) {
            allInterest.selected=TRUE;
        }else{
            for(Interest *interest in self.userInterest)
                {
                    if ([interest.Id intValue] == [allInterest.Id intValue]) {
                        allInterest.selected=TRUE;
                        break;
                    }
                }
            }
        }
    }
    [loader stopAnimating];
	[tblInterest reloadData];
}
- (void)getUserInterestsFailed:(Result *)result
{
	[loader stopAnimating];
}
- (void)dealloc {
    [super dealloc];
}
@end
