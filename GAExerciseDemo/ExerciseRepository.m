//
//  ExerciseRepository.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "ExerciseRepository.h"
#import "Exercise.h"

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
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:amount];
    for (int i = 0; i < amount; i++) {
        [result addObject:[Exercise randomExercise]];
    }
    
    self.data = [NSArray arrayWithArray:result];
    return self.data;
    
}

- (void)removeExerciseAtIndex:(NSUInteger)index
{
    NSMutableArray *result = [self.data mutableCopy];
    [result removeObjectAtIndex:index];
    self.data = [NSArray arrayWithArray:result];
}

@end
