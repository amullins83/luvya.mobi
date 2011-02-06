//
//  LYTextMessage.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYTextMessage : NSObject {
	int _TextID;
	int _Uses;
	NSDate * FirstUsed;
	NSDate * LastUsed;
	NSString * Text;
	
}

-(LYTextMessage *)initWithID:(int)txtId numUses:(int)uses lastUsed:(NSDate *)last firstUsed:(NSDate *)first text:(NSString *)msg;
-(LYTextMessage *)initWithText:(NSString *)msg;
-(LYTextMessage *)initWithMessage:(LYTextMessage *)other;

@property int TextID;
@property int Uses;
@property (nonatomic, retain) NSDate *FirstUsed;
@property (nonatomic, retain) NSDate *LastUsed; 
@property (nonatomic, retain) NSString *Text;
@end
