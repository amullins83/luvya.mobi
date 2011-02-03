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

typedef enum {
	sortLastUsed,
	sortFirstUsed,
	sortNumUses,
	sortAlpha
}  LYSortRule ;

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> {

	
	UITableViewController *LYTextTableController;
	NSArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
	LYSortRule *thisRule;
}

- (IBAction)showInfo:(id)sender;
- (IBAction)sendMessage:(id)sender;
- (IBAction)sortTextArray:(NSMutableArray *)texts by:(LYSortRule *)rule ascending:(BOOL *)asc;
- (LYTextMessage *)getNextText;

@property (nonatomic, retain) NSArray *LYTexts;
@property (nonatomic, retain) IBOutlet UITableViewController *LYTextTableController;
@property (nonatomic, retain) LYTextMessage *ActiveText;

@end
