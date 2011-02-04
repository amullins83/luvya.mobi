//
//  LYTextTableViewController.m
//  luvya
//
//  Created by Austin Mullins on 2/4/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "LYTextTableViewController.h"


@implementation LYTextTableViewController

@synthesize ActiveText;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// There is only one section.
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of time zone names.
	return [timeZoneNames count];
}


- (LYTextTableCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil) {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell.
	NSString *timeZoneName = [timeZoneNames objectAtIndex:indexPath.row];
	cell.textLabel.text = timeZoneName;
	
	return cell;
}

/*
 To conform to Human Interface Guildelines, since selecting a row would have no effect (such as navigation), make sure that rows cannot be selected.
 */
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return indexPath;
}

- (IBAction)sendMessage:(id)sender {
	NSString *theText = [self.ActiveText Text];
	MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] initWithRootViewController:self];
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	controller.body = theText;
	
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

- (void)dealloc {
    [super dealloc];
}


@end
