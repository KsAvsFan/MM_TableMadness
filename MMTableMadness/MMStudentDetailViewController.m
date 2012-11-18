//
//  MMStudentDetailViewController.m
//  MMTableMadness
//
//  Created by Don Bora on 11/7/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "MMStudentDetailViewController.h"
#import "MMStudent.h"
#import "AppDelegate.h"
#import "MyWebViewController.h"
#import "MyMapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MMStudentDetailViewController ()
{
    IBOutlet UILabel*       oNameLabel;
    IBOutlet UILabel*       oAddressOneLabel;
    IBOutlet UILabel*       oAddressTwoLabel;
    IBOutlet UILabel*       oCityLabel;
    IBOutlet UILabel*       oStateLabel;
    IBOutlet UILabel*       oPostalLabel;
    IBOutlet UILabel*       oURLLabel;
    
    IBOutlet UITextField*   oAddressLineOneTextField;
    IBOutlet UITextField*   oAddressLineTwoTextField;
    IBOutlet UITextField*   oCityTextField;
    IBOutlet UITextField*   oStateTextField;
    IBOutlet UITextField*   oNameTextField;
    IBOutlet UITextField*   oPostCodeTextField;
    IBOutlet UITextField*   oURLTextField;
        
    IBOutlet UIView*        oEditView;
}
-(IBAction)edit:(id)sender;
-(IBAction)done:(id)sender;
-(IBAction)browse:(id)sender;
-(IBAction)map:(id)sender;
-(void)delayedGratification;

-(void)__saveStudentData;
-(void)__refreshViewData;
-(void)__geolocate;

@end


@implementation MMStudentDetailViewController

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
    [self __refreshViewData];
    
    for (UIView* view in oEditView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [(UITextField*)view setReturnKeyType:UIReturnKeyDone];
            [(UITextField*)view addTarget:self
                                   action:@selector(textFieldFinished:)
                         forControlEvents:UIControlEventEditingDidEndOnExit];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldFinished:(id)sender
{
    [sender resignFirstResponder];
}


-(IBAction)map:(id)sender
{
    [self performSegueWithIdentifier:@"MapSegue" sender:self];
}

-(IBAction)edit:(id)sender
{
    oNameTextField.text = self.student.name;
    oAddressLineOneTextField.text = self.student.addressLineOne;
    oAddressLineTwoTextField.text = self.student.addressLineTwo;
    oCityTextField.text = self.student.city;
    oStateTextField.text = self.student.state;
    oPostCodeTextField.text = self.student.postalCode;
    oURLTextField.text = self.student.url;
    
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         oEditView.alpha = 1.0f;
                     }];
}


-(IBAction)done:(id)sender
{
    [self __saveStudentData];
    [self __refreshViewData];
    [self __geolocate];

    [UIView animateWithDuration:0.25f
                     animations:^{
                         oEditView.alpha = 0.0f;
                     }];
}

-(IBAction)browse:(id)sender
{
    [self performSegueWithIdentifier:@"WebViewSegue" sender:self];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WebViewSegue"]) {
        MyWebViewController* myWebViewController = segue.destinationViewController;
        myWebViewController.urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:oURLLabel.text]];
    }
    else if ([segue.identifier isEqualToString:@"MapSegue"]) {
        MyMapViewController* myMapViewController = segue.destinationViewController;
        myMapViewController.student = self.student;
    }

}

#pragma mark (Hidden)


-(void)__geolocate
{
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    NSString* address = [NSString stringWithFormat:@"%@ %@ %@ %@", self.student.addressLineOne, self.student.city, self.student.state, self.student.postalCode];
    
    [geoCoder geocodeAddressString:address
                 completionHandler:^(NSArray* placemarks, NSError* error)
                     {
                         if (placemarks != nil && [placemarks count] > 0) {
                             NSManagedObjectContext* context = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
                             CLLocation* location = [[placemarks objectAtIndex:0] location];
                             CLLocationCoordinate2D locationCoordinate2D = location.coordinate;
                             NSError* _error = nil;

                             self.student.latitude = [NSNumber numberWithDouble:locationCoordinate2D.latitude];
                             self.student.longitude = [NSNumber numberWithDouble:locationCoordinate2D.longitude];
                          
                             if (![context save:&_error]) {
                                 // Replace this implementation with code to handle the error appropriately.
                                 // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                                 NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                                 abort();
                             }
                             
                             [self performSelector:@selector(delayedGratification) withObject:nil afterDelay:10.0f];
                         }
                         
                     }];
}


-(void)delayedGratification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CoordinatesDidLoadNotification" object:nil];
}


-(void)__refreshViewData
{
    oNameLabel.text = self.student.name;
    oAddressOneLabel.text = self.student.addressLineOne;
    oAddressTwoLabel.text = self.student.addressLineTwo;
    oCityLabel.text = self.student.city;
    oStateLabel.text = self.student.state;
    oPostalLabel.text = self.student.postalCode;
    oURLLabel.text = self.student.url;
}


-(void)__saveStudentData
{
    NSError* error;
    NSManagedObjectContext* context = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
    
    self.student.name = oNameTextField.text;
    self.student.addressLineOne = oAddressLineOneTextField.text;
    self.student.addressLineTwo = oAddressLineTwoTextField.text;
    self.student.city = oCityTextField.text;
    self.student.state = oStateTextField.text;
    self.student.postalCode = oPostCodeTextField.text;
    self.student.url = oURLTextField.text;
    
    if (![context save:&error]) {
        NSLog(@"something went wrong");
    }
}



@end
