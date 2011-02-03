//
//  MainViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "FlipsideViewController.h"
#import "LYTextMessage.h"
#import "MessageUI/MessageUI.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {
	UITableViewController *LYTextTableController;
	NSArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)sendMessage:(id)sender;
- (LYTextMessage *)getNextText;

@property (nonatomic, retain) NSArray *LYTexts;
@property (nonatomic, retain) IBOutlet UITableViewController *LYTextTableController;
@property (nonatomic, retain) LYTextMessage *ActiveText;

@end
