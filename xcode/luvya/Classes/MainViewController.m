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


- (void)sortTextArray:(NSMutableArray *)texts by:(LYSortRule *)rule ascending:(BOOL *)asc {
	thisRule = rule;
	switch ((int)&rule) {
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



- (NSMutableArray *)textArrayFromPlist:(NSString *)pListName {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [appPath stringByAppendingPathComponent:pListName];
	NSDictionary *textDB = [[NSDictionary dictionaryWithContentsOfFile:filePath] retain];
	thisRule = (LYSortRule *)[textDB objectForKey:@"sortRule"];
	// Allocate result
	NSMutableArray *resultArray = [[NSMutableArray alloc] init];
	NSArray *dictArray = [[NSArray alloc] init];
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
		NSUInteger *newTextID = malloc(sizeof(NSUInteger));
		NSUInteger *newUses = malloc(sizeof(NSUInteger));
		newTextID = (NSUInteger *)[[dictArray objectAtIndex:i] objectForKey:@"TextID"];
		newUses = (NSUInteger *)[[dictArray objectAtIndex:i] objectForKey:@"Uses"];
		LYTextMessage *newText = [[[LYTextMessage alloc]
								   initWithID:newTextID
								   numUses:newUses
								   lastUsed:[[dictArray objectAtIndex:i] objectForKey:@"LastUsed"]
								   firstUsed:[[dictArray objectAtIndex:i] objectForKey:@"FirstUsed"]
								   text:[[dictArray objectAtIndex:i] objectForKey:@"Text"]] retain];
		
		// Append LYTextMessage to result
		[resultArray insertObject:newText atIndex:i];						  
	}
	
	[self sortTextArray:resultArray by:thisRule ascending:(BOOL *)[textDB objectForKey:@"sortAscending"]];
	
	// Return result
	return resultArray;
}

-(IBAction)setSortOrder:(UISegmentedControl *)sender {
	thisRule = (LYSortRule *)[sender selectedSegmentIndex];
	[self sortTextArray:LYTexts by:thisRule ascending:thisAscending];
	CurrentLYTextsIndex = 0;
//Reload the table cells in the new order
	//[LYTextTableController loadView];
}

-(IBAction)toggleAscending:(UIButton *)sender {
    *thisAscending = !&thisAscending;
	[self sortTextArray:LYTexts by:thisRule ascending:thisAscending];
	CurrentLYTextsIndex = 0;
	//Reload the table cells in the new order
	//[LYTextTableController loadView];
	UIImage *arrowImg;
	
	if (*thisAscending) {
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
	thisAscending = malloc(sizeof(BOOL));
	thisRule = malloc(sizeof(LYSortRule));

	self.LYTexts = [[self textArrayFromPlist:@"TextDB.plist"] retain];
	[LYTextTableController.view initWithFrame:CGRectMake(0, 0, 320, 402)];
	[self.view addSubview:LYTextTableController.view]; 
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
