//
//  textMessage.m
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "textMessage.h"


@implementation textMessage

+ (void)initWithID:(long int)txtId numUses:(long int)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first (NSString *)msg {
	[super init];
	TextID = txtId;
	Uses = numUses;
	LastUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:last retain];
	FirstUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:first] retain];
	Text = [[[NSString alloc] initWithString:msg] retain];
	
	
}

+ (void) dealloc: {
	[LastUsed dealloc];
	[FirstUsed dealloc];
	[Text dealloc];
	[super dealloc];
  }
				
@end
