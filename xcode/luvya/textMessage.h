//
//  textMessage.h
//  luvya
//
//  Created by Austin Mullins on 2/2/11.
//  Copyright 2011 LuvYa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface textMessage : NSObject {
	long int TextID;
	long int Uses;
	NSDate FirstUsed;
	NSDate LastUsed;
	NSString Text;
}

@end
