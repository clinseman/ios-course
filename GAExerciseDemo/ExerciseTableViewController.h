//
//  ExerciseTableViewController.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpViewController.h"

// We are subclassing the UITableViewController and implementing two protocols
// UISearchDisplayDelegate to display the search bar on top of the table
// HelpViewControllerDelegate to dissmis the help view when the 'Done' button is pressed
// ⌘ + Click on the HelpViewControllerDelegate protocol to see where and how its defined
@interface ExerciseTableViewController : UITableViewController <UISearchDisplayDelegate, HelpViewControllerDelegate>

@end
