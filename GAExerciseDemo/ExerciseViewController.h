//
//  ExerciseViewController.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 13/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@class Exercise;

// This is our Detailed view controller used to view and edit an exercise
// We need to implment the UITextFieldDelegate to dissmiss the keyboard,
// the UIActionSheetDelegate to handle the user clickon on the alert button,
// and the MFMailComposeViewControllerDelegate for when a user tries to send an email
@interface ExerciseViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

// store the Exercise we are currently displaying
@property (nonatomic, strong) Exercise *exercise;

// link up the Labels, and other UI elements from our XIB file
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLevelLabel;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (weak, nonatomic) IBOutlet UISlider *difficultyLevelSlider;

// handle when the user slides the UISlider from our XIB file
- (IBAction)difficultyChanged:(id)sender;

@end
