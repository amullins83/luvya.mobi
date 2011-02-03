//
//  LYTextMessage.m
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LYTextMessage.h"


@implementation LYTextMessage

@synthesize LastUsed;
@synthesize FirstUsed;
@synthesize Text;

#pragma mark -
#pragma mark Text Initializers

//-initWithID:numUses:lastUsed:firstUsed:text:

-(LYTextMessage *)initWithID:(NSUInteger *)txtId numUses:(NSUInteger *)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first text:(NSString *)msg {
	[super init];
	TextID = txtId;
	Uses = uses;
	LastUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:last] retain];
	FirstUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:first] retain];
	Text = [[[NSString alloc] initWithString:msg] retain];
	return self;
}

-(LYTextMessage *)initWithText:(NSString *)msg {
	[super init];
	Text = [[[NSString alloc] initWithString:msg] retain];
	TextID = 0;
	Uses = 0;
	LastUsed = NULL;
	FirstUsed = NULL;
	return self;
}

-(LYTextMessage *)initWithMessage:(LYTextMessage *)other {
	self = [super init];
	TextID = [other TextID];
	Uses = [other Uses];
	LastUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:[other LastUsed]] retain];
	FirstUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:[other FirstUsed]] retain];
	Text = [[[NSString alloc] initWithString:[other Text]] retain];	
	return self;
}

-(NSUInteger *)TextID { return [self TextID]; }
-(NSUInteger *)Uses   { return [self Uses]; }

-(void)setTextID:(NSUInteger *)newID { TextID = newID; }
-(void)setUses:(NSUInteger *)newUses { Uses = newUses; }



-(void) dealloc {
	[LastUsed release];
	[FirstUsed release];
	[Text release];
	[super dealloc];
  }
				
@end
