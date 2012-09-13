//
//  ExerciseViewController.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 13/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Exercise;

@interface ExerciseViewController : UIViewController

@property (nonatomic, strong) Exercise *exercise;
@property (weak, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *difficultyLevelLabel;

@end
