//
//  FlipsideViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "FlipsideViewController.h"
#import "MainViewController.h"

@implementation FlipsideViewController

@synthesize delegate;
@synthesize LYTexts;
@synthesize ActiveText;
@synthesize textTableViewController;
@synthesize fsSegmentedControl;

-(BOOL)thisAscending { return thisAscending; }
-(LYSortRule)thisRule { return thisRule; }
-(void)setThisRule:(LYSortRule)rule { thisRule = rule; }
-(void)setThisAscending:(BOOL)asc { thisAscending = asc; }


-(void)sortTextArray{
	
	NSString *sortKey = [[NSString alloc] init];
 	
	switch ((int)thisRule) {
		case sortAlpha:
			sortKey = @"Text";
			break;
		case sortLastUsed:
			sortKey = @"LastUsed";
			break;
		case sortFirstUsed:
			sortKey = @"FirstUsed";
			break;
		case sortNumUses:
			sortKey = @"Uses";
			break;
			
		default:
			break;
	}
	
	NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:thisAscending];
	
	[self.LYTexts sortUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
	
	[sortDesc release];
	[sortKey release];
}

- (void)textArrayFromPlist {
	NSString *filePath = [NSString stringWithFormat:@"%@/Documents/TextDB.plist", NSHomeDirectory()]; 
	
	NSDictionary *textDB = [NSDictionary dictionaryWithContentsOfFile:filePath];
	
	id NumberRule = [textDB objectForKey:@"sortRule"];
	
	thisRule = (LYSortRule)[NumberRule intValue];
	
	NSArray *dictArray;
	
	// Check whether user/common list should be selected
	if ([[textDB objectForKey:@"showUserTexts"] boolValue]) {
		//Populate array from UserTexts
		dictArray = [NSArray arrayWithArray:[textDB objectForKey:@"UserTexts"]];
		doShowUserTexts = TRUE;
	}
	else {
		//Populate array from CommonTexts
		dictArray = [NSArray arrayWithArray:[textDB objectForKey:@"CommonTexts"]];
		doShowUserTexts = FALSE;
	}
	
	int arrLength = [LYTexts count];
	for(int i = 0; i < arrLength; i++)
	{
		[LYTexts removeObjectAtIndex:0];
	}
	
	for(int i = 0; i < [dictArray count]; i++)
	{
		// Append LYTextMessage to result
		[self.LYTexts 
		 insertObject:
		 [[LYTextMessage alloc]
		  initWithID:[[[dictArray objectAtIndex:i] objectForKey:@"TextID"] intValue]
		  numUses:[[[dictArray objectAtIndex:i] objectForKey:@"Uses"] intValue]
		  lastUsed:[[dictArray objectAtIndex:i] objectForKey:@"LastUsed"]
		  firstUsed:[[dictArray objectAtIndex:i] objectForKey:@"FirstUsed"]
		  text:[[dictArray objectAtIndex:i] objectForKey:@"Text"]]
		 atIndex:i];						  
	}
	
	
	thisAscending = [[textDB objectForKey:@"sortAscending"] boolValue];
	
	// Sort LYTexts
	[self sortTextArray];	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.LYTexts = [[NSMutableArray alloc] init];
    
	self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	[self textArrayFromPlist];
	[(MainViewController *)delegate copyTextArray:LYTexts];	
	[textTableViewController.view initWithFrame:CGRectMake(0, 44, 320, 325)];
	
	[self.view addSubview:textTableViewController.view];
	
	if (doShowUserTexts) {
		[fsSegmentedControl setSelectedSegmentIndex:1];
	}
	else {
		[fsSegmentedControl setSelectedSegmentIndex:0];
	}

}



- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)toggleUserTexts:(id)sender {
	doShowUserTexts = (BOOL)[fsSegmentedControl selectedSegmentIndex];
	
	NSString *filePath = [NSString stringWithFormat:@"%@/Documents/TextDB.plist", NSHomeDirectory()]; 
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
	
	NSNumber *doShowUT = [[NSNumber alloc] initWithBool:doShowUserTexts];
	
	[textDB setObject:doShowUT forKey:@"showUserTexts"];
	
	[textDB writeToFile:filePath atomically:YES];
	
	[doShowUT release];
	
	[self textArrayFromPlist];
	[(MainViewController *)delegate copyTextArray:LYTexts];	
	[(UITableView *)textTableViewController.view reloadData];
}

- (IBAction)addUserText:(id)sender {
	NSString *filePath = [NSString stringWithFormat:@"%@/Documents/TextDB.plist", NSHomeDirectory()]; 
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    	
	NSDictionary *newText = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:(id)ActiveText.TextID, (id)ActiveText.Uses, ActiveText.LastUsed, ActiveText.FirstUsed, ActiveText.Text, nil] forKeys:[NSArray arrayWithObjects:@"TextID", @"Uses", @"LastUsed", @"FirstUsed", @"Text", nil]]; 
    
	[textDB setObject:[[textDB objectForKey:@"UserTexts"] arrayByAddingObject:newText] forKey:@"UserTexts"];
	
	[textDB writeToFile:filePath atomically:YES];
	[self textArrayFromPlist];
	[(MainViewController *)delegate copyTextArray:LYTexts];	
	[(UITableView *)textTableViewController.view reloadData];
}

- (IBAction)removeUserText:(id)sender {
	NSString *filePath = [NSString stringWithFormat:@"%@/Documents/TextDB.plist", NSHomeDirectory()]; 
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
	int TextIDtoRemove = ActiveText.TextID;
	NSArray *oldArray = [textDB objectForKey:@"UserTexts"];
	NSMutableArray *shorterArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < [oldArray count]; i++) {
		if ([[oldArray objectAtIndex:i] TextID] != TextIDtoRemove) {
			[shorterArray addObject:[oldArray objectAtIndex:i]];
		}
	}
	
	[textDB setObject:shorterArray forKey:@"UserTexts"];
	[textDB writeToFile:filePath atomically:YES];
	[self textArrayFromPlist];
	[(MainViewController *)delegate copyTextArray:LYTexts];
	[(UITableView *)textTableViewController.view reloadData];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	[(MainViewController *)delegate copyTextArray:LYTexts];
	[self.LYTexts release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
