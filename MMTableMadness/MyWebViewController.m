//
//  MyWebViewController.m
//  MMTableMadness
//
//  Created by Don Bora on 11/12/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "MyWebViewController.h"

@interface MyWebViewController ()<UIWebViewDelegate>
{
    IBOutlet UIWebView* oWebView;
    IBOutlet UIActivityIndicatorView* activityIndicatorView;
    IBOutlet UITextField*   oWebAddressTextField;
}
-(IBAction)back:(id)sender;
-(IBAction)go:(id)sender;

@end

@implementation MyWebViewController

@synthesize urlRequest = _urlRequest;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [oWebView loadRequest:_urlRequest];
    oWebView.delegate = self;
    // Do any additional setup after loading the view.
}

-(IBAction)back:(id)sender
{
    [oWebView goBack];
}

-(IBAction)go:(id)sender
{
    NSString* url = oWebAddressTextField.text;
    NSRange isRange = [url rangeOfString:@"http://" options:NSCaseInsensitiveSearch];
    
    if(isRange.location != 0) {
        url = [NSString stringWithFormat:@"http://%@", url];
    }
    
    [oWebAddressTextField resignFirstResponder];
    [oWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIWebViewDelegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [activityIndicatorView stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [activityIndicatorView startAnimating];
}
@end
