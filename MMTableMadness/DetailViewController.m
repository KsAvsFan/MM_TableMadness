//
//  DetailViewController.m
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import "DetailViewController.h"
#import "MMPopupViewController.h"
#import "PopupDelegate.h"
#import "AppDelegate.h"
#import "MMClass.h"
#import "MMStudent.h"
#import "MMStudentDetailViewController.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate, PopupDelegate>
{
    IBOutlet UITableView*   oTableView;
}
- (void)configureView;
@end

@implementation DetailViewController


- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(MMClass*)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        //[self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
/*
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"name"] description];
    }
 */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
   
    
    [self configureView];
}


- (void)insertNewObject:(id)sender
{
    [self showMMClassPopup];
}


-(void)showMMClassPopup
{
    MMPopupViewController* mmPopupViewController = [[MMPopupViewController alloc] initWithNibName:nil bundle:nil];
    
    mmPopupViewController.delegate = self;
    [[[UIApplication sharedApplication] keyWindow] addSubview:mmPopupViewController.view];
    // [self.view addSubview:mmClassPopupViewController.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"DetailViewReuseIdentifier"];
    NSArray* students = [self.detailItem.students allObjects];
                        //((NSSet*)[self.detailItem valueForKey:@"students"]) allObjects];

    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailViewReuseIdentifier"];
    }
    
    tableViewCell.textLabel.text = ((MMStudent*)[students objectAtIndex:indexPath.row]).name;
    return tableViewCell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"StudentDetailSeque" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"StudentDetailSeque"]) {
        NSIndexPath *indexPath = [oTableView indexPathForSelectedRow];
        MMStudent* student = [[self.detailItem.students allObjects] objectAtIndex:indexPath.row];
        
       // MMClass* mmClass = (MMClass*)[[self fetchedResultsController] objectAtIndexPath:indexPath];
        ((MMStudentDetailViewController*)[segue destinationViewController]).student = student;
    }
}


#pragma mark UITableViewDataSoure

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.detailItem.students count];
}


#pragma mark PopupDelegate

-(void)didCloseWithText:(NSString*)text
{
    AppDelegate* myAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext* context = myAppDelegate.managedObjectContext;
    MMStudent* mmStudent = [NSEntityDescription insertNewObjectForEntityForName:@"MMStudent" inManagedObjectContext:context];
    
    mmStudent.name = text;
    
    [self.detailItem addStudentsObject:mmStudent];

    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [oTableView reloadData];
    //NSMutableArray* students = [(NSSet*)[self.detailItem valueForKey:@"students"] mutableCopy];
    

}
@end
