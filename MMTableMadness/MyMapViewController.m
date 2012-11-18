//
//  MyMapViewController.m
//  MMTableMadness
//
//  Created by Don Bora on 11/12/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "MyMapViewController.h"
#import "MMStudent.h"
#import <MapKit/MapKit.h>

@interface MyMapViewController ()
{
    IBOutlet MKMapView* oMapView;
}
-(void)refreshMap;
@end

@implementation MyMapViewController


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMap) name:@"CoordinatesDidLoadNotification" object:nil];
    }
    return self;
}



-(void)refreshMap
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([self.student.latitude doubleValue], [self.student.longitude doubleValue]);
    MKCoordinateSpan coordinateSpan = MKCoordinateSpanMake(0.5f, 0.5f);
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(location, coordinateSpan);
    
    oMapView.region = coordinateRegion;
    [oMapView setCenterCoordinate:location animated:YES];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshMap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
