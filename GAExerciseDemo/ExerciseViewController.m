//
//  ExerciseViewController.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 13/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseViewController.h"
#import "Exercise.h"

@interface ExerciseViewController ()

@end

@implementation ExerciseViewController

@synthesize exerciseNameLabel = _exerciseNameLabel;
@synthesize difficultyLevelLabel = _difficultyLevelLabel;
@synthesize exercise = _exercise;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Some Exercise Detail";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"view loaded with exercise: %@", self.exercise);
    self.exerciseNameLabel.text = self.exercise.name;
    
    NSString *difficulty = @"Easy";
    
    if (self.exercise.difficultyLevel > 8) {
        difficulty = @"Hard";
    } else if (self.exercise.difficultyLevel > 4) {
        difficulty = @"Average";
    }
    
    self.difficultyLevelLabel.text = difficulty;
    
}

- (void)viewDidUnload
{
    [self setExerciseNameLabel:nil];
    [self setDifficultyLevelLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
