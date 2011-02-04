//
//  FlipsideViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "FlipsideViewController.h"


@implementation FlipsideViewController

@synthesize delegate;
@synthesize LYTexts;
@synthesize ActiveText;

- (NSArray *)textArrayFromPlist:(NSString *)pListName {
	NSString *appPath = [[NSBundle mainBundle] bundlePath];
	NSString *filePath = [appPath stringByAppendingPathComponent:pListName];
	NSDictionary *textDB = [[NSDictionary dictionaryWithContentsOfFile:filePath] retain];
	
	// Allocate result
	NSArray *result = [[NSArray alloc] init];
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
		LYTextMessage *newText = [[[LYTextMessage alloc]
								   initWithID:(NSUInteger *)[[dictArray objectAtIndex:i] objectForKey:@"TextID"]
								   numUses:(NSUInteger *)[[dictArray objectAtIndex:i] objectForKey:@"Uses"]
								   lastUsed:[[dictArray objectAtIndex:i] objectForKey:@"LastUsed"]
								   firstUsed:[[dictArray objectAtIndex:i] objectForKey:@"FirstUsed"]
								   text:[[dictArray objectAtIndex:i] objectForKey:@"Text"]] retain];
		
		// Append LYTextMessage to result
		[result arrayByAddingObject:newText];						  
	}
	
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

- (IBAction)toggleUserTexts:(id)sender {
	doShowUserTexts = !doShowUserTexts;
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return [LYTexts count];
}


- (LYTextEditTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"LYUserEditTableCell";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	LYTextEditTableCell *cell = (LYTextEditTableCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = (LYTextEditTableCell *)[[[LYTextEditTableCell alloc] initWithStyle:UITableViewCellEditingStyleInsert reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell.
	LYTextMessage *cellText = [LYTexts objectAtIndex:indexPath.row];
	cell.textLabel.text = cellText.Text;
	cell.LYText = cellText;
	
	return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ActiveText = [(LYTextEditTableCell *)[tableView cellForRowAtIndexPath:indexPath] LYText];
	return nil;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload {
	// Release any retained subviews of the main view.
 
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
