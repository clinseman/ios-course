//
//  ExerciseViewController.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 13/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseViewController.h"
#import "Exercise.h"
#import <Twitter/Twitter.h>

// Define a few constants that are used to determin
// which alert button the user clicks on
#define kShareViaEmailButton 0
#define kShareViaTwitterButton 1

// anonymous category for helper methods
@interface ExerciseViewController ()
// update the display after the user makes some change
- (void)updateDisplay;

// handle the share via email and share via twitter actions
- (void)shareViaEmail;
- (void)shareViaTwitter;
@end

@implementation ExerciseViewController

// get the compiler to synthesize the getters and setters
@synthesize exerciseNameLabel = _exerciseNameLabel;
@synthesize difficultyLevelLabel = _difficultyLevelLabel;
@synthesize exerciseNameTextField = _exerciseNameTextField;
@synthesize difficultyLevelSlider = _difficultyLevelSlider;
@synthesize exercise = _exercise;

// this is the default init, we don't have any customization to do
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
    
    // Log which exercise is being displayed, useful for debugging purposes
    NSLog(@"view loaded with exercise: %@", self.exercise);
    
    // update the display
    [self updateDisplay];
    
    // make the right bar button the edit button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // create a share button that will be displayed in a tool bar at the bottom of the screen
    // make it call actionShare: method when it's pressed
    UIBarButtonItem *shareButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionShare:)];
    
    // we want the button to be on the right of the tool bar, so we add in space to the left
    UIBarButtonItem *flexibleSpaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    // create an array with the tool bar buttons in it
    NSArray *toolBarItems = @[flexibleSpaceButtonItem, shareButtonItem];

    // and tell the tool bar about the buttons
    self.toolbarItems = toolBarItems;

}

- (void)viewDidUnload
{
    // set our properties to be 'nil'
    [self setExerciseNameLabel:nil];
    [self setDifficultyLevelLabel:nil];
    [self setExerciseNameTextField:nil];
    [self setDifficultyLevelSlider:nil];
    
    [super viewDidUnload];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // our view just appeared, show the tool bar
    [self.navigationController setToolbarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // our view is about to dissapear, hide the tool bar
    [self.navigationController setToolbarHidden:YES animated:YES];
}

// we are entering or exisiting edit mode
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    // so make sure the UI is reflecting the right mode
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

// called when the display needs to be updated
- (void)updateDisplay
{
    // set up the labels
    self.title = self.exercise.name;
    self.exerciseNameLabel.text = self.exercise.name;
    
    // instead of displaying the difficulty as a number,
    // turn it into Easy <= 4
    // Average > 4
    // Hard > 8
    NSString *difficulty = @"Easy";
    
    if (self.exercise.difficultyLevel > 8) {
        difficulty = @"Hard";
    } else if (self.exercise.difficultyLevel > 4) {
        difficulty = @"Average";
    }
    
    self.difficultyLevelLabel.text = difficulty;
}

// handle the share via email event
- (void)shareViaEmail
{
    // verify we can send an email on this device/simulator
    if ([MFMailComposeViewController canSendMail]) {
        // create and set up the MFMailComposeViewController
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Great Exercise"];
        
        // create some default text for the user
        NSMutableString *text = [NSMutableString string];
        
        [text appendString:@"<p>Thought you'd like this:</p>"];
        [text appendFormat:@"<p>Exercise: %@</p>", self.exercise.name];
        
        // and set the message
        [mailViewController setMessageBody:text isHTML:YES];
        
        // finally display the email controller to the user
        [self presentModalViewController:mailViewController animated:YES];
    } else {
        // if we cant send email, tell the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email"
                                                        message:@"Can't send an email, check your settings."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

// handle the share via twitter event
- (void)shareViaTwitter
{
    // verify we can send a tweet
    if ([TWTweetComposeViewController canSendTweet]) {
        
        // Set up the built-in twitter composition view controller.
        TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
        
        // Set the initial tweet text. See the framework for additional properties that can be set.
        [tweetViewController setInitialText:self.exercise.name];
        
        // Create the completion handler block.
        [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {

            switch (result) {
                case TWTweetComposeViewControllerResultCancelled:
                    // The cancel button was tapped.
                    NSLog(@"Tweet cancelled.");
                    break;
                case TWTweetComposeViewControllerResultDone:
                    // The tweet was sent.
                    NSLog(@"Tweet sent.");
                    break;
                default:
                    break;
            }
            
            // Dismiss the tweet composition view controller.
            [self dismissModalViewControllerAnimated:YES];
        }];
        
        // Present the tweet composition view controller modally.
        [self presentModalViewController:tweetViewController animated:YES];
        
    } else {
        // can't tweet, tell the user
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Can't send a tweet, check your settings."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)actionShare:(id)sender
{
    // display an Action Sheet asking the user how they wan tto share
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share Exercise"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Email", @"Twitter", nil];
    
    // and display it from the toolbar
    [actionSheet showFromToolbar:self.navigationController.toolbar];
}

#pragma mark - MFMailComposeViewController Delegate
// handle the MFMailComposeViewController delegate callbacks
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    NSLog(@"result: %d", result);
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

#pragma mark - UIActionSheet Delegate
// handle the action sheet button presses
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"Clicked: %d", buttonIndex);
    
    // user our defined constants and call the appropriate method
    switch (buttonIndex) {
        case kShareViaEmailButton:
            [self shareViaEmail];
            break;

        case kShareViaTwitterButton:
            [self shareViaTwitter];
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

// handle when the user slides the UISlider from our XIB file
- (IBAction)difficultyChanged:(id)sender {
    // this is commented out, but it will log out the value of the slider
    // as the user changes it
//    int result = roundf(self.difficultyLevelSlider.value);
//    NSLog(@"value: %d", result);
}

@end
