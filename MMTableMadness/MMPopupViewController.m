//
//  MMClassPopupViewController.m
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "MMPopupViewController.h"

@interface MMPopupViewController ()
{
    IBOutlet UITextField* oTextField;
}

-(IBAction)done:(id)sender;
@end

@implementation MMPopupViewController

@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)done:(id)sender
{
    [_delegate didCloseWithText:oTextField.text];
    [self.view removeFromSuperview];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
