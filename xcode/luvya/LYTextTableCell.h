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
	LYTextMessage *LYText;
}

@property (nonatomic, retain) IBOutlet LYTextMessage *LYText;
 
@end
