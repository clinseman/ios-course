//
//  ExerciseRepository.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseRepository : NSObject

// a property that represents our data
@property (nonatomic, strong) NSArray *data;

// this will always return the same repository using the singleton pattern
+ (ExerciseRepository *)sharedRepository;

// return 'amount' number of random exercises
- (NSArray *)getRandomExercises:(NSUInteger)amount;

// delete an exercise
- (void)removeExerciseAtIndex:(NSUInteger)index;

// persist our data
- (void)saveData;

@end
