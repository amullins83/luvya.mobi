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

-(int)TextID { return _TextID; }
-(int)Uses { return _Uses; }

-(void)setTextID:(int)tid { _TextID = tid; }
-(void)setUses:(int)uses { _Uses = uses; }

#pragma mark -
#pragma mark Text Initializers

//-initWithID:numUses:lastUsed:firstUsed:text:

-(LYTextMessage *)initWithID:(int)txtId numUses:(int)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first text:(NSString *)msg {
	[super init];
	_TextID = txtId;
	_Uses = uses;
	LastUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:last] retain];
	FirstUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:first] retain];
	Text = [[[NSString alloc] initWithString:msg] retain];
	return self;
}

-(LYTextMessage *)initWithText:(NSString *)msg {
	[super init];
	Text = [[[NSString alloc] initWithString:msg] retain];
	_TextID = 0;
	_Uses = 0;
	LastUsed = NULL;
	FirstUsed = NULL;
	return self;
}

-(LYTextMessage *)initWithMessage:(LYTextMessage *)other {
	self = [super init];
	_TextID = other.TextID;
	_Uses = other.Uses;
	LastUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:[other LastUsed]] retain];
	FirstUsed = [[[NSDate alloc] initWithTimeInterval:0 sinceDate:[other FirstUsed]] retain];
	Text = [[[NSString alloc] initWithString:[other Text]] retain];	
	return self;
}

-(void) dealloc {
	[LastUsed release];
	[FirstUsed release];
	[Text release];
	[super dealloc];
  }
				
@end
