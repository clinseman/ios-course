//
//  HelpViewController.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 14/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HelpViewControllerDellegate;

@interface HelpViewController : UIViewController

@property (nonatomic, weak) id<HelpViewControllerDellegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

- (IBAction)actionDone:(id)sender;

@end

@protocol HelpViewControllerDellegate
-(void)helpViewControllerDidFinish:(HelpViewController *)controller;
@end
