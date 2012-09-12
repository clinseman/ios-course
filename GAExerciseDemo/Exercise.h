//
//  Exercise.h
//  SampleConsole
//
//  Created by Chris Linseman on 08/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exercise : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *steps;
@property (nonatomic) int difficultyLevel;

+ (id)pushUp;

+ (id)squat;

+ (id)randomExercise;

- (id)initWithName:(NSString *)name steps:(NSArray *)steps difficultyLevel:(int)difficultyLevel;

- (NSString *)description;

@end


