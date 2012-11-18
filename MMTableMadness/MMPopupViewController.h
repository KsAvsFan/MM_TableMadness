//
//  MMClassPopupViewController.h
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupDelegate.h"

@interface MMPopupViewController : UIViewController
@property(nonatomic, strong)id<PopupDelegate> delegate;
@end
