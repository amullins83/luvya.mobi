//
//  MainViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlipsideViewController.h"
#import "LYTextMessage.h"
#import "LYTextTableCell.h"
#import "MessageUI/MessageUI.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	UITableViewController *LYTextTableController;
	NSArray *LYTexts;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)sendMessage:(id)sender;

@property (nonatomic, retain) NSArray *LYTexts;
@property (nonatomic, retain) IBOutlet UITableViewController *LYTextTableController;

@end
