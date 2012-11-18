//
//  MasterViewController.h
//  MMTableMadness
//
//  Created by Don Bora on 11/5/12.
//  Copyright (c) 2012 Don Bora. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PopupDelegate.h"

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, PopupDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
