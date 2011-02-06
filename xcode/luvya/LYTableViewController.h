//
//  LYTableViewController.h
//  luvya
//
//  Created by Austin Mullins on 2/4/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"
#import "LYTextTableCell.h"

@interface LYTableViewController : UITableViewController {
	id delegate;
}

@property (nonatomic, assign) id delegate;

@end
