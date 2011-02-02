//
//  MainViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "MainViewController.h"


@implementation MainViewController



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad {
	[super viewDidLoad];
	self.LYTextTableController = [[UITableViewController alloc] initWithNibName:@"LYTextTable" bundle:nil];
	self.LYTexts = [[self textArrayFromPlist:@"TextDB.plist"] retain];
}

- (NSArray *)textArrayFromPlist:(NSString *)pListName {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [appPath stringByAppendingPathComponent:pListName];
	NSDictionary *textDB = [[NSDictionary dictionaryWithContentsOfFile:filePath] retain];

	// Allocate result
	NSArray *result = [NSArray alloc];
	
		// Check whether user/common list should be selected
	if ([textDB objectForKey:@"showUserTexts"]) {
		//Populate array from UserTexts
		NSArray *dictArray = [[NSArray alloc] arrayWithArray:[textDB objectForKey:@"UserTexts"]];
	}
	else {
		//Populate array from CommonTexts
		NSArray *dictArray = [[NSArray alloc] arrayWithArray:[textDB objectForKey:@"CommonTexts"]];
	}
	
	for(int i = 0; i < [dictArray length]; i++)
	{
		// allocate new LYTextMessage
		// init new LYTextMessage from plist table
		LYTextMessage *newText = [[[LYTextMessage alloc] initWithID:[dictArray[i] TextID] numUses:[dictArray[i] Uses] lastUsed:[dictArray[i] LastUsed] firstUsed:[dictArray[i] FirstUsed] text:[dictArray[i] Text] retain];
			// Append LYTextMessage to result
		[result arrayByAddingObject:newText];						  
	}

		[dictArray release]
								  
	    // Return result
		return result
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

- (IBAction)sendMessage:(id)sender {
	NSString *theText = [[sender LYText] Text];
	MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] initWithRootViewController:self];
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	controller.body = theText;
	
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
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
