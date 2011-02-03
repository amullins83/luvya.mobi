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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];      
}


- (IBAction)done:(id)sender {
	[self.delegate flipsideViewControllerDidFinish:self];	
}

- (IBAction)addUserText:(id)sender {
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TextDB.plist"];
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    LYTextMessage *newLYText = [sender LYText];
    	
	NSDictionary *newText = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:(id)newLYText.TextID, (id)newLYText.Uses, newLYText.LastUsed, newLYText.FirstUsed, newLYText.Text, nil] forKeys:[NSArray arrayWithObjects:@"TextID", @"Uses", @"LastUsed", @"FirstUsed", @"Text", nil]]; 
    
	[textDB setObject:[[textDB objectForKey:@"UserTexts"] arrayByAddingObject:newText] forKey:@"UserTexts"];
	
	[textDB writeToFile:path atomically:NO];
}

- (IBAction)removeUserText:(id)sender {
	NSString *path = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"TextDB.plist"];
	NSMutableDictionary *textDB = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	NSUInteger *TextIDtoRemove = [[sender LYText] TextID];
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
