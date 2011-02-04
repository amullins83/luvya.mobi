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

typedef enum {
	sortLastUsed,
	sortFirstUsed,
	sortNumUses,
	sortAlpha
}  LYSortRule ;

@interface MainViewController : UITableViewController <FlipsideViewControllerDelegate> {

	NSMutableArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
	LYSortRule *thisRule;
	BOOL *thisAscending;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)sendMessage:(id)sender;
- (IBAction)setSortOrder:(UISegmentedControl *)sender;
- (IBAction)toggleAscending:(UIButton *)sender;

@property (nonatomic, retain) NSArray *LYTexts;
@property (nonatomic, retain) LYTextMessage *ActiveText;

@end
