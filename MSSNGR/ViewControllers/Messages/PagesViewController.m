//
//  PagesViewController.m
//  MSSNGR
//
//  Created by Muzammil Hussain on 11/21/11.
//  Copyright (c) 2011 Coeus Solutions. All rights reserved.
//

#import "PagesViewController.h"
#import "Folder.h"
#import "Page.h"
#import "PageDetailViewController.h"
#import "SearchViewController500.h"
#import "ImageTableRow.h"
#import "Utility.h"
@implementation PagesViewController
@synthesize folder=_folder;
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
-(void)viewWillAppear:(BOOL)animated{
    [tblPages deselectRowAtIndexPath:tblPages.indexPathForSelectedRow animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [Utility setNavigationBar:self addNextButton:NO addBackButton:YES addSearchButton:YES title:_folder.name];
}

-(IBAction)backButtonAction
{
	[self.navigationController popViewControllerAnimated:YES];
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
#pragma pages tableview
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ImageTableRow *directoryCell=(ImageTableRow*)[tableView dequeueReusableCellWithIdentifier:@"pageCell"];
    if(directoryCell==nil)
    {
        directoryCell= [[[NSBundle mainBundle] loadNibNamed:@"ImageTableRow" owner:self options:nil]objectAtIndex:0];
        [directoryCell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        directoryCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        directoryCell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    Page *page = [_folder.pages objectAtIndex:indexPath.row];
    directoryCell.textLabel.text=page.title;
    [directoryCell.thumbImage loadImageFromURLString:page.thumb];
    return directoryCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Page *page = [_folder.pages objectAtIndex:indexPath.row];
    PageDetailViewController *controller = [[PageDetailViewController alloc]init];
    controller.pageDetails=page;
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_folder.pages count];
}
@end
