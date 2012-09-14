//
//  ExerciseViewController.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 13/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseViewController.h"
#import "Exercise.h"



#define kShareViaEmailButton 0

@interface ExerciseViewController ()
- (void)updateDisplay;
- (void)shareViaEmail;
@end

@implementation ExerciseViewController

@synthesize exerciseNameLabel = _exerciseNameLabel;
@synthesize difficultyLevelLabel = _difficultyLevelLabel;
@synthesize exerciseNameTextField = _exerciseNameTextField;
@synthesize difficultyLevelSlider = _difficultyLevelSlider;
@synthesize exercise = _exercise;

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
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"view loaded with exercise: %@", self.exercise);
    [self updateDisplay];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionShare:)];
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *toolBarItems = @[flexibleSpaceButtonItem, shareButtonItem];

    self.toolbarItems = toolBarItems;

}

- (void)viewDidUnload
{
    [self setExerciseNameLabel:nil];
    [self setDifficultyLevelLabel:nil];
    [self setExerciseNameTextField:nil];
    [self setDifficultyLevelSlider:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setToolbarHidden:YES animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    self.exerciseNameTextField.hidden = !editing;
    self.difficultyLevelSlider.hidden = !editing;
    
    self.exerciseNameLabel.hidden = editing;
    self.difficultyLevelLabel.hidden = editing;
    
    if (editing) {
        self.exerciseNameTextField.text = self.exercise.name;
        self.difficultyLevelSlider.value = self.exercise.difficultyLevel;
        
    } else {
        [self.exerciseNameTextField resignFirstResponder];
        self.exercise.name = self.exerciseNameTextField.text;
        int result = roundf(self.difficultyLevelSlider.value);
        self.exercise.difficultyLevel = result;
        
        [self updateDisplay];
    }
    
}

- (void)updateDisplay
{
    self.title = self.exercise.name;
    self.exerciseNameLabel.text = self.exercise.name;
    
    NSString *difficulty = @"Easy";
    
    if (self.exercise.difficultyLevel > 8) {
        difficulty = @"Hard";
    } else if (self.exercise.difficultyLevel > 4) {
        difficulty = @"Average";
    }
    
    self.difficultyLevelLabel.text = difficulty;
}

- (void)shareViaEmail
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Great Exercise"];
        
        NSMutableString *text = [NSMutableString string];
        
        [text appendString:@"<p>Thought you'd like this:</p>"];
        [text appendFormat:@"<p>Exercise: %@</p>", self.exercise.name];
        
        [mailViewController setMessageBody:text isHTML:YES];
        
        [self presentModalViewController:mailViewController animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email"
                                                        message:@"Can't send an email, check your settings."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)actionShare:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Exercise"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Email", nil];
    
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - MFMailComposeViewController Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSLog(@"result: %d", result);
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked: %d", buttonIndex);
    switch (buttonIndex) {
        case kShareViaEmailButton:
            [self shareViaEmail];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITextField Delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)difficultyChanged:(id)sender {
//    int result = roundf(self.difficultyLevelSlider.value);
//    NSLog(@"value: %d", result);
}

@end
