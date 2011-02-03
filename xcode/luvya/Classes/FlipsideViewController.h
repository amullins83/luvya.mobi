//
//  FlipsideViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextEditTableCell.h"
#import "LYTextMessage.h"

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController {
	id <FlipsideViewControllerDelegate> delegate;
	bool doShowUserTexts;
	UITableViewController *LYUserTextEditTableController;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITableViewController *LYUserTextEditTableController;

- (IBAction)done:(id)sender;
- (IBAction)addUserText:(id)sender;
- (IBAction)removeUserText:(id)sender;

@end


@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

