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
@synthesize LYTextTableController;
@synthesize ActiveText;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.




- (void)sortByLastUsedTextArrayAscending:(NSMutableArray *)texts {
	int i, j, minIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		minIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] LastUsed] < [[texts objectAtIndex:minIndex] LastUsed]) {
				minIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:minIndex] atIndex:i];
		[texts removeObjectAtIndex:minIndex];
	}
}

- (void)sortByFirstUsedTextArrayAscending:(NSMutableArray *)texts {
	int i, j, minIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		minIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] FirstUsed] < [[texts objectAtIndex:minIndex] FirstUsed]) {
				minIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:minIndex] atIndex:i];
		[texts removeObjectAtIndex:minIndex];
	}
	
}

- (void)sortByNumUsesTextArrayAscending:(NSMutableArray *)texts {
	int i, j, minIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		minIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] Uses] < [[texts objectAtIndex:minIndex] Uses]) {
				minIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:minIndex] atIndex:i];
		[texts removeObjectAtIndex:minIndex];
	}
}

- (void)sortByAlphaTextArrayAscending:(NSMutableArray *)texts {
	int i, j, minIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		minIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] Text] < [[texts objectAtIndex:minIndex] Text]) {
				minIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:minIndex] atIndex:i];
		[texts removeObjectAtIndex:minIndex];
	}
	
}

- (void)sortByLastUsedTextArrayDescending:(NSMutableArray *)texts {
	int i, j, maxIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		maxIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] LastUsed] > [[texts objectAtIndex:maxIndex] LastUsed]) {
				maxIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:maxIndex] atIndex:i];
		[texts removeObjectAtIndex:maxIndex];
	}	
}

- (void)sortByFirstUsedTextArrayDescending:(NSMutableArray *)texts {
	int i, j, maxIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		maxIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] FirstUsed] > [[texts objectAtIndex:maxIndex] FirstUsed]) {
				maxIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:maxIndex] atIndex:i];
		[texts removeObjectAtIndex:maxIndex];
	}
}

- (void)sortByNumUsesTextArrayDescending:(NSMutableArray *)texts {
	int i, j, maxIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		maxIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] Uses] > [[texts objectAtIndex:maxIndex] Uses]) {
				maxIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:maxIndex] atIndex:i];
		[texts removeObjectAtIndex:maxIndex];
	}	
}

- (void)sortByAlphaTextArrayDescending:(NSMutableArray *)texts {
	int i, j, maxIndex;
	for (i = 0; i < [texts count] - 1; i++) {
		maxIndex = i;
		for (j = i + 1; j < [texts count]; j++) {
			if ([[texts objectAtIndex:j] Text] > [[texts objectAtIndex:maxIndex] Text]) {
				maxIndex = j;
			}
		}
		[texts insertObject:[texts objectAtIndex:maxIndex] atIndex:i];
		[texts removeObjectAtIndex:maxIndex];
	}
}


- (void)sortTextArray:(NSMutableArray *)texts ascending:(BOOL *)asc {
	switch ((int)&thisRule) {
		case sortAlpha:
			if (asc) {
				[self sortByAlphaTextArrayAscending:texts];
			}
			else {
				[self sortByAlphaTextArrayDescending:texts];
			}
			break;
		case sortLastUsed:
			if (asc) {
				[self sortByLastUsedTextArrayAscending:texts];
			}
			else {
				[self sortByLastUsedTextArrayDescending:texts];
			}
			break;
		case sortFirstUsed:
			if (asc) {
				[self sortByFirstUsedTextArrayAscending:texts];
			}
			else {
				[self sortByFirstUsedTextArrayDescending:texts];
			}
			break;
		case sortNumUses:
			if (asc) {
				[self sortByNumUsesTextArrayAscending:texts];
			}
			else {
				[self sortByNumUsesTextArrayDescending:texts];
			}
			break;
		default:
			break;
	}
}

- (NSArray *)textArrayFromPlist:(NSString *)pListName {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [appPath stringByAppendingPathComponent:pListName];
	NSDictionary *textDB = [[NSDictionary dictionaryWithContentsOfFile:filePath] retain];
	thisRule = (LYSortRule *)[textDB objectForKey:@"sortRule"];
	// Allocate result
	NSMutableArray *result;
	NSArray *dictArray;
	// Check whether user/common list should be selected
	if ([textDB objectForKey:@"showUserTexts"]) {
		//Populate array from UserTexts
		dictArray = [NSArray arrayWithArray:[textDB objectForKey:@"UserTexts"]];
	}
	else {
		//Populate array from CommonTexts
		dictArray = [NSArray arrayWithArray:[textDB objectForKey:@"CommonTexts"]];
	}
	
	for(int i = 0; i < [dictArray count]; i++)
	{
		// allocate new LYTextMessage
		// init new LYTextMessage from plist table
		LYTextMessage *newText = [[[LYTextMessage alloc]
								   initWithID:[[dictArray objectAtIndex:i] TextID]
								   numUses:[[dictArray objectAtIndex:i] Uses]
								   lastUsed:[[dictArray objectAtIndex:i] LastUsed]
								   firstUsed:[[dictArray objectAtIndex:i] FirstUsed]
								   text:[[dictArray objectAtIndex:i] Text]] retain];
		
		// Append LYTextMessage to result
		[result insertObject:newText atIndex:i];						  
	}
	
	[dictArray release];
	
	[self sortTextArray:result ascending:(BOOL *)[textDB objectForKey:@"sortAscending"]];
	
	// Return result
	return result;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	self.LYTextTableController = [[UITableViewController alloc] initWithNibName:@"LYTextTable" bundle:nil];
	self.LYTexts = [[self textArrayFromPlist:@"TextDB.plist"] retain];
	CurrentLYTextsIndex = 0;
}								  
								  
-(LYTextMessage *)getNextText {
	return	[LYTexts objectAtIndex:CurrentLYTextsIndex++];
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
	NSString *theText = [self.ActiveText Text];
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
