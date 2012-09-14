//
//  ExerciseRepository.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseRepository.h"
#import "Exercise.h"

@interface ExerciseRepository ()
- (NSString *)filePath;
@end

@implementation ExerciseRepository

@synthesize data = _data;

+ (ExerciseRepository *)sharedRepository
{
	static dispatch_once_t pred;
	static ExerciseRepository *repository = nil;
	dispatch_once(&pred, ^{ repository = [[self alloc] init]; });
	return repository;
}

- (NSArray *)getRandomExercises:(NSUInteger)amount
{
    
    NSData *data = [NSData dataWithContentsOfFile:[self filePath]];
    if (data) {
        self.data = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } else {
    
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:amount];
        for (int i = 0; i < amount; i++) {
            Exercise *anExercise = [Exercise randomExercise];
            [result addObject:anExercise];
        }
        
        self.data = [NSArray arrayWithArray:result];
        
        [self saveData];
    }
    
    return self.data;
    
}

- (void)removeExerciseAtIndex:(NSUInteger)index
{
    NSMutableArray *result = [self.data mutableCopy];
    [result removeObjectAtIndex:index];
    self.data = [NSArray arrayWithArray:result];
    [self saveData];
}

- (void)saveData
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.data];
    [data writeToFile:[self filePath] atomically:YES];
}

- (NSString *)filePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSString *filePath = [libraryDirectory stringByAppendingPathComponent:@"exercises.plist"];
    
    return filePath;
}

@end
