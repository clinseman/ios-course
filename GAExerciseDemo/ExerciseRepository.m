//
//  ExerciseRepository.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseRepository.h"
#import "Exercise.h"

// anonymous category to hide a 'private' method
@interface ExerciseRepository ()
// return the path to where we're going to save our data
- (NSString *)filePath;
@end

@implementation ExerciseRepository

@synthesize data = _data;

// this will always return the same repository using the singleton pattern
+ (ExerciseRepository *)sharedRepository
{
    // this code ensures that the same repository is always returned
    // by only dispatching the creation of it once
	static dispatch_once_t pred;
	static ExerciseRepository *repository = nil;
	dispatch_once(&pred, ^{ repository = [[self alloc] init]; });
	return repository;
}

// return 'amount' number of random exercises
// note: amount will be ignored if the data has already been created and saved
// this isn't a real repository and only meant to help with out sample app
- (NSArray *)getRandomExercises:(NSUInteger)amount
{
    // is our data saved?
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data) {
        // if is, so use the NSCoding protocal and read it
        self.data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
        // we need to create the data
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:amount];
        for (int i = 0; i < amount; i++) {
            Exercise *anExercise = [Exercise randomExercise];
            [result addObject:anExercise];
        }
        
        // and store it in our property
        self.data = [NSArray arrayWithArray:result];
        
        // and persist it to disk
        [self saveData];
    }
    
    // return out data
    return self.data;
    
}

// delete an exercise
- (void)removeExerciseAtIndex:(NSUInteger)index
{
    NSMutableArray *result = [self.data mutableCopy];
    [result removeObjectAtIndex:index];
    self.data = [NSArray arrayWithArray:result];
    [self saveData];
}

// persist our data
- (void)saveData
{
    // use the NSCoding protocol to save out data
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.data];
    [data writeToFile:[self filePath] atomically:YES];
}

// helper method to get the right directory to save our data
- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    
    // it will be stored in a plist file called exercises
    NSString *filePath = [libraryDirectory stringByAppendingPathComponent:@"exercises.plist"];
    
    // return the complete path
    return filePath;
}

@end
