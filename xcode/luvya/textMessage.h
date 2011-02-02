//
//  LYTextMessage.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYTextMessage : NSObject {
	-(long int)_TextID;
	-(long int)_Uses;
	-(NSDate *)_FirstUsed;
	-(NSDate *)_LastUsed;
	-(NSString *)_Text;
	
	+(long int)TextID { return _TextID; }
    +(long int)Uses { return _Uses; }
	+(NSDate *)FirstUsed { return [[NSDate alloc] initWithTimeInterval:0 sinceDate:_FirstUsed]; }
	+(NSDate *)LastUsed { return [[NSDate alloc] initWithTimeInterval:0 sinceDate:_LastUsed]; }
	+(NSString *)Text { return [[NSString alloc] initWithString:_Text]; }
}

@end
