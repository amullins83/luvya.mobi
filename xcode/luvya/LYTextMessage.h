//
//  LYTextMessage.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYTextMessage : NSObject {
	NSUInteger *TextID;
	NSUInteger *Uses;
	NSDate * FirstUsed;
	NSDate * LastUsed;
	NSString * Text;
	
}

-(LYTextMessage *)initWithID:(NSUInteger *)txtId numUses:(NSUInteger *)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first text:(NSString *)msg;
-(LYTextMessage *)initWithText:(NSString *)msg;
-(LYTextMessage *)initWithMessage:(LYTextMessage *)other;

@property (nonatomic) NSUInteger *TextID;
@property (nonatomic) NSUInteger *Uses;
@property (nonatomic, retain) NSDate *FirstUsed;
@property (nonatomic, retain) NSDate *LastUsed; 
@property (nonatomic, retain) NSString *Text;
@end
