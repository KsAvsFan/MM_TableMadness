//
//  DetailViewController.h
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMClass;


@interface DetailViewController : UIViewController

@property (strong, nonatomic) MMClass* detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
