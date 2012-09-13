//
//  ExerciseRepository.h
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseRepository : NSObject

@property (nonatomic, strong) NSArray *data;

+ (ExerciseRepository *)sharedRepository;

- (NSArray *)getRandomExercises:(NSUInteger)amount;

- (void)removeExerciseAtIndex:(NSUInteger)index;

@end
