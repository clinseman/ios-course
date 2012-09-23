//
//  Exercise.h
//  SampleConsole
//
//  Created by Chris Linseman on 08/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import <Foundation/Foundation.h>

// we are subclassing NSObject and implementing the NSCoding protocol
// so that we can save Exercises to the file system
@interface Exercise : NSObject <NSCoding>

// Our exercises have 3 properties
// the first one is a copy, as we don't want the name to be modified by another object
@property (nonatomic, copy) NSString *name;

// the second is an array, and we own it, so its a strong reference
@property (nonatomic, strong) NSArray *steps;

// the last is a primitive, so no * and we don't specify strong/copy/weak (cause it's not an object)
@property (nonatomic) int difficultyLevel;

// create and return an random Exercise
+ (id)randomExercise;

// create and return an Exercise with the given name, steps, and difficultyLevel
// this is our default initializer
- (id)initWithName:(NSString *)name steps:(NSArray *)steps difficultyLevel:(int)difficultyLevel;

// when we print out our exercise this method gets called automatically, it's overriden from NSObject
- (NSString *)description;

@end


