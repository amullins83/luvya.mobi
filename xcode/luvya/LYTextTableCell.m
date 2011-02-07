//
//  LYTextTableCell.m
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "LYTextTableCell.h"


@implementation LYTextTableCell

@synthesize LYText;
@synthesize lblLastUsed;
@synthesize lblFirstUsed;
@synthesize lblUses;
@synthesize lblText;
@synthesize btnSend;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
