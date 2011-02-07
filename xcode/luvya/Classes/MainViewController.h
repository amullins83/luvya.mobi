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
#import "LYTextTableCell.h"
#import "LYTableViewController.h"



@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, MFMessageComposeViewControllerDelegate> {

	NSMutableArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
	LYSortRule thisRule;
	BOOL thisAscending;
	LYTableViewController *textTableController;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)sendMessage:(id)sender;
- (IBAction)setSortOrder:(UISegmentedControl *)sender;
- (IBAction)toggleAscending:(UIButton *)sender;
- (void)copyTextArray:(NSMutableArray *)fsArray;

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;

@property (nonatomic, retain) NSMutableArray *LYTexts;
@property (nonatomic, retain) LYTextMessage *ActiveText;
@property (nonatomic, retain) IBOutlet LYTableViewController *textTableController;


@end
