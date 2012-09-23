//
//  HelpViewController.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 14/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

// ask the compiler to create our getters/setters
@synthesize delegate = _delegate;
@synthesize versionLabel = _versionLabel;
@synthesize nameLabel = _nameLabel;

// we don't have any custom initialization
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
    
    // look in the NSUserDefaults to see if the user has set a name value in the settings app
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"nameField"];
    self.nameLabel.text = name;
    
    // read the version from the info.plist so we can display it
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
}

- (void)viewDidUnload
{
    // nill out our properties
    [self setVersionLabel:nil];
    [self setNameLabel:nil];
    [super viewDidUnload];
}

// respond to the done button being pressed, will forward to our delegate
- (IBAction)actionDone:(id)sender {
    // we can't dismiss ourselves, so we ask our delegate to handle it for us
    [self.delegate helpViewControllerDidFinish:self];
}

@end
