//
//  LYTextTableViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/4/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"
#import "LYTextTableCell.h"

@interface LYTextTableViewController : UITableViewController {
	LYTextMessage *ActiveText;
}

- (IBAction)sendMessage:(id)sender;

@property (nonatomic, retain) LYTextMessage *ActiveText;

@end
