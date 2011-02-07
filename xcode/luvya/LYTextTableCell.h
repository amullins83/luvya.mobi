//
//  LYTextTableCell.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"

@interface LYTextTableCell : UITableViewCell {
	UIView cellView;
	UILabel lblLastUsed;
	UILabel lblFirstUsed;
	UILabel lblUses;
	UILabel lblText;
	UIButton btnSend;
	LYTextMessage *LYText;
}

@property (nonatomic, retain) LYTextMessage *LYText;
@property (nonatomic, assign) IBOutlet UIView *cellView;
@property (nonatomic, retain) IBOutlet UILabel *lblLastUsed;
@property (nonatomic, retain) IBOutlet UILabel *lblFirstUsed;
@property (nonatomic, retain) IBOutlet UILabel *lblUses;
@property (nonatomic, retain) IBOutlet UILabel *lblText;
@property (nonatomic, retain) IBOutlet UIButton *btnSend;


@end
