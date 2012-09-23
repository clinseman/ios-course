//
//  AppDelegate.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "AppDelegate.h"
#import "ExerciseTableViewController.h"
#import "ExerciseRepository.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create an instance of our ExerciseTableViewController
    ExerciseTableViewController *exerciseTableViewController = [[ExerciseTableViewController alloc] initWithNibName:@"ExerciseTableViewController" bundle:nil];
    
    // Create a UINavigationController and set it as our RootViewController so that it gets displayed when the app lauches
    // tell the navController that our exerciseTableViewController should be the top most (root) view controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:exerciseTableViewController];
    
    [self.window setRootViewController:navController];
        
    self.window.backgroundColor = [UIColor whiteColor];
    
    // Tell the window object to make its self visible
    [self.window makeKeyAndVisible];
    
    // Use NSUserDefaults to remember how many times this application has been opened.
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{ @"timesOpened" : @0 }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    // before we move from the active state, lets save any data changes we've made
    [[ExerciseRepository sharedRepository] saveData];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // we're keeping tack of how many times the app has been opened, so read it from NSUserDefaults
    int timesOpened = [[[NSUserDefaults standardUserDefaults] valueForKey:@"timesOpened"] intValue];
    
    // increase it, set the value, and make sure it's saved (synchronized)
    [[NSUserDefaults standardUserDefaults] setValue:@(++timesOpened) forKey:@"timesOpened"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
