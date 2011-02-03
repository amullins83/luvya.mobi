//
//  FlipsideViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "FlipsideViewController.h"
#import "LYTextMessage.h"


@implementation FlipsideViewController

@synthesize delegate;
@synthesize LYUserTextEditTableController;
@synthesize LYTexts;
@synthesize ActiveText;

- (NSArray *)textArrayFromPlist:(NSString *)pListName {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [appPath stringByAppendingPathComponent:pListName];
	NSDictionary *textDB = [[NSDictionary dictionaryWithContentsOfFile:filePath] retain];
	
	// Allocate result
	NSArray *result;
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
		[result arrayByAddingObject:newText];						  
	}
	
	[dictArray release];
	
	// Return result
	return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
	self.LYTexts = [[self textArrayFromPlist:@"TextDB.plist"] retain];
	CurrentLYTextsIndex = 0;
}



- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)addUserText:(id)sender {
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TextDB.plist"];
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    	
	NSDictionary *newText = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:(id)ActiveText.TextID, (id)ActiveText.Uses, ActiveText.LastUsed, ActiveText.FirstUsed, ActiveText.Text, nil] forKeys:[NSArray arrayWithObjects:@"TextID", @"Uses", @"LastUsed", @"FirstUsed", @"Text", nil]]; 
    
	[textDB setObject:[[textDB objectForKey:@"UserTexts"] arrayByAddingObject:newText] forKey:@"UserTexts"];
	
	[textDB writeToFile:path atomically:NO];
}

- (IBAction)removeUserText:(id)sender {
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TextDB.plist"];
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	NSUInteger *TextIDtoRemove = ActiveText.TextID;
	NSArray *oldArray = [textDB objectForKey:@"UserTexts"];
	NSMutableArray *shorterArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < [oldArray count]; i++) {
		if ([[oldArray objectAtIndex:i] TextID] != TextIDtoRemove) {
			[shorterArray addObject:[oldArray objectAtIndex:i]];
		}
	}
	
	[textDB setObject:shorterArray forKey:@"UserTexts"];
	[textDB writeToFile:path atomically:NO];
}

-(LYTextMessage *)getNextText {
	return	[LYTexts objectAtIndex:CurrentLYTextsIndex++];
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	[self.LYUserTextEditTableController release];
	self.LYUserTextEditTableController = nil;
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
