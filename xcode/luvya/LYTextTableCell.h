//
//  LYTextTableCell.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"
#import "MainViewController.h"

@interface LYTextTableCell : UITableViewCell {
	LYTextMessage *LYText;
	MainViewController *delegate;
}

@property (nonatomic, retain) IBOutlet LYTextMessage *LYText;
@property (nonatomic, assign) IBOutlet MainViewController *delegate;

@end
