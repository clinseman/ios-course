//
//  Exercise.m
//  SampleConsole
//
//  Created by Chris Linseman on 08/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "Exercise.h"
#import "NSArray+Helpers.h"

@implementation Exercise

// tell the compiler to create getters/setters for our properties
@synthesize name = _name;
@synthesize steps = _steps;
@synthesize difficultyLevel = _difficultyLevel;

// create and return an random Exercise
+ (id)randomExercise
{
    // for this demo, steps will always be nil, but you could change this and display it when viewing an exercise
    NSArray *steps = nil;
    
    // this is just a way to create random words
    NSArray *adjectives = @[@"Ultra", @"Super", @"Crazy", @"Mega", @"Basic", @"Simple", @"Amazing", @""];
    NSArray *bodyPart = @[@"Arm", @"Leg", @"Ab", @"Back", @"Elbow"];
    NSArray *name = @[@"Push Up", @"Squat", @"Press", @"Jump", @"Throw"];
    
    // we are calling randomElement which is a category that we've defined on arrays
    // look at the NSArray+Helpers.m file to see how its implemented
    NSString *tempName = [NSString stringWithFormat:@"%@ %@ %@", [adjectives randomElement], [bodyPart randomElement], [name randomElement]];
    
    // make sure there's no white space on either end of our name
    tempName = [tempName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // create an exercise using the random info by calling our default initializer
    Exercise *e1 = [[Exercise alloc] initWithName:tempName
                                            steps:steps
                                  difficultyLevel:(arc4random() % 10) + 1];
    
    // return it
    return e1;
}

// create and return an Exercise with the given name, steps, and difficultyLevel
- (id)initWithName:(NSString *)name steps:(NSArray *)steps difficultyLevel:(int)difficultyLevel
{
    if (self = [super init]) {
        self.name = name;
        self.steps = steps;
        self.difficultyLevel = difficultyLevel;
    }
    
    return self;
}

// when we print out our exercise this method gets called automatically, it's overriden from NSObject
- (NSString *)description
{
    return [NSString stringWithFormat:@"Name: %@ - difficulty: %d", self.name, self.difficultyLevel];
}

#pragma mark - NSCoding

// this is part of the NSCoding protocol to save an object
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    // we need to go through each of our properties and tell the NSCoder how to save them
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.difficultyLevel forKey:@"difficultyLevel"];
}

// this is part of the NSCoding protocol to resore an object
- (id)initWithCoder:(NSCoder *)aDecoder
{
    // we need to go through each of our properties and tell the NSCoder how to re-create them
    NSString *name = [aDecoder decodeObjectForKey:@"name"];
    int difficultyLevel = [aDecoder decodeIntForKey:@"difficultyLevel"];
    
    // we have the values, so create a new exerise using our default initializer
    return [self initWithName:name steps:nil difficultyLevel:difficultyLevel];
}

@end
