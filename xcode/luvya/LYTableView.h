//
//  LYTableView.h
//  luvya
//
//  Created by Austin Mullins on 2/4/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYTextMessage.h"
#import "LYTextTableCell.h"

@interface LYTableView : UITableView {
	
}

- (LYTextTableCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;            // returns nil if cell is not visible or index path is out of range
- (LYTextTableCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.

@end
