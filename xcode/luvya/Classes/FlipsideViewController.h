//
//  FlipsideViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"
#import "LYEditTableViewController.h"

typedef enum {
	sortLastUsed,
	sortFirstUsed,
	sortNumUses,
	sortAlpha
}  LYSortRule ;

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController  <UITableViewDelegate> {
	id <FlipsideViewControllerDelegate> delegate;
	bool doShowUserTexts;
	NSMutableArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
	LYEditTableViewController *textTableViewController;
	LYSortRule thisRule;
	bool thisAscending;
	UISegmentedControl *fsSegmentedControl;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *LYTexts;
@property (nonatomic, retain) LYTextMessage *ActiveText;
@property (nonatomic, retain) IBOutlet LYEditTableViewController *textTableViewController;
@property (nonatomic, retain) IBOutlet UISegmentedControl *fsSegmentedControl;
@property LYSortRule thisRule;
@property BOOL thisAscending;

- (IBAction)done:(id)sender;
- (IBAction)addUserText:(id)sender;
- (IBAction)removeUserText:(id)sender;
- (IBAction)toggleUserTexts:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

