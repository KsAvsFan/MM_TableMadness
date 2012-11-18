//
//  PopupDelegate.h
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PopupDelegate <NSObject>
-(void)didCloseWithText:(NSString*)text;
@end
