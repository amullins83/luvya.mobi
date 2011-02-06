//
//  MainViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "MainViewController.h"
#import "LYTextMessage.h"

@implementation MainViewController
@synthesize LYTexts;
@synthesize ActiveText;
@synthesize textTableController;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
	}
	else {
		//Populate array from CommonTexts
		dictArray = [NSArray arrayWithArray:[textDB objectForKey:@"CommonTexts"]];
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


-(IBAction)setSortOrder:(UISegmentedControl *)sender {
	thisRule = (LYSortRule)[sender selectedSegmentIndex];
	[self sortTextArray];

//Reload the table cells in the new order
	[(UITableView *)textTableController.view reloadData];
}

-(IBAction)toggleAscending:(UIButton *)sender {
    thisAscending = !thisAscending;
	[self sortTextArray];
	[(UITableView *)textTableController.view reloadData];
	UIImage *arrowImg;
	
	if (thisAscending) {
		arrowImg = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ArrowDownTransparent.png"]];
	}
	else {
		arrowImg = [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"ArrowUpTransparent.png"]];
	}

	[sender setImage:arrowImg forState:UIControlStateNormal];
	[sender setImage:arrowImg forState:UIControlStateHighlighted];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.LYTexts = [[[NSMutableArray alloc] init] retain];

	[self textArrayFromPlist];
	[(UITableView *)textTableController.view reloadData];
	[self.view addSubview:textTableController.view];
}								  
								  

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (IBAction)sendMessage:(id)sender {
	NSString *theText = [self.ActiveText Text];
	MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
	picker.messageComposeDelegate = self;

	picker.body = theText;
	
	[self presentModalViewController:picker animated:YES];

	[picker release];
	
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
		// Dismiss controller
	[self dismissModalViewControllerAnimated:YES];
}



- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[LYTexts release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
