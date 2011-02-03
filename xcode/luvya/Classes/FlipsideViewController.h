//
//  FlipsideViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	bool doShowUserTexts;
	UITableViewController *LYUserTextEditTableController;
	NSArray *LYTexts;
	uint CurrentLYTextsIndex;
	LYTextMessage *ActiveText;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableViewController *LYUserTextEditTableController;
@property (nonatomic, retain) NSArray *LYTexts;
@property (nonatomic, retain) LYTextMessage *ActiveText;

- (IBAction)done:(id)sender;
- (IBAction)addUserText:(id)sender;
- (IBAction)removeUserText:(id)sender;
- (LYTextMessage *)getNextText;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

