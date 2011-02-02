//
//  textMessage.m
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "textMessage.h"


@implementation textMessage

- (void)initWithID:(long int)txtId numUses:(int)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first (NSString *)msg {
	[super init];
	self.TextID = txtId;
	self.Uses = numUses;
	self.LastUsed = last;
	self.FirstUsed = first;
	self.Text = msg;
}


@end
