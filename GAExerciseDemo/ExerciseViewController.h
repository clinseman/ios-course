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

@interface ExerciseViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) Exercise *exercise;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLevelLabel;
@property (weak, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (weak, nonatomic) IBOutlet UISlider *difficultyLevelSlider;

- (IBAction)difficultyChanged:(id)sender;

@end
