//
//  HelpViewController.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 14/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>

// forward declaration of our custom protocol
// defined later in this file
@protocol HelpViewControllerDelegate;

@interface HelpViewController : UIViewController

// set up our properties
// the delegate proerty is 'weak' because we don't own the delegate
// we mearly want a reference to it, we are not responsible for it
// in fact, we will be destroyed before the delegate, so we definitely don't
// want to own it or we'll create a retain cycle
@property (nonatomic, weak) id<HelpViewControllerDelegate> delegate;

// the other ones are weak as they are owned by our XIB filee
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

// respond to the done button being pressed, will forward to our delegate
- (IBAction)actionDone:(id)sender;

@end

// define our custom protocol
@protocol HelpViewControllerDelegate
// only one method, which will get called when the user presses the 'done' button
-(void)helpViewControllerDidFinish:(HelpViewController *)controller;
@end
