//
//  LYTextEditTableCell.m
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import "LYTextEditTableCell.h"


@implementation LYTextEditTableCell

@synthesize LYText;
@synthesize delegate;

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
	// Activate keyboard
	// Set LYText = keyboard text
	// Resign first responder
//	delegate.ActiveText = self.LYText;
}


- (void)dealloc {
    [super dealloc];
}


@end
