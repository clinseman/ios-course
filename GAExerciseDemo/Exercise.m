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

@synthesize name = _name;
@synthesize steps = _steps;
@synthesize difficultyLevel = _difficultyLevel;

+ (id)pushUp
{
    NSArray *steps = @[@"Place your toes and hands on the floor", @"Inhale as you lower yourself to the floor", @"Exhale and push yourself away from the floor"];
    
    Exercise *e1 = [[Exercise alloc] initWithName:@"Push Up"
                                            steps:steps
                                  difficultyLevel:3];
    
    return e1;
}

+ (id)squat
{
    NSArray *steps = @[@"Plant your feet shoulder width apart", @"Sit back and down like you're sitting into an imaginary chair", @"Lower down so your thighs are as parallel to the floor as possible", @"Keep your body tight and push through your heels to bring yourself back to the starting position"];

    Exercise *e1 = [[Exercise alloc] initWithName:@"Squat"
                                            steps:steps
                                  difficultyLevel:2];
    
    return e1;
}

+ (id)randomExercise
{
    NSArray *steps = nil;
    
    NSArray *adjectives = @[@"Ultra", @"Super", @"Crazy", @"Mega", @"Basic", @"Simple", @"Amazing", @""];
    NSArray *bodyPart = @[@"Arm", @"Leg", @"Ab", @"Back", @"Elbow"];
    NSArray *name = @[@"Push Up", @"Squat", @"Press", @"Jump", @"Throw"];
    
    NSString *tempName = [NSString stringWithFormat:@"%@ %@ %@", [adjectives randomElement], [bodyPart randomElement], [name randomElement]];
    
    Exercise *e1 = [[Exercise alloc] initWithName:tempName
                                            steps:steps
                                  difficultyLevel:(arc4random() % 10) + 1];
    
    return e1;
}

- (id)initWithName:(NSString *)name steps:(NSArray *)steps difficultyLevel:(int)difficultyLevel
{
    if (self = [super init]) {
        self.name = name;
        self.steps = steps;
        self.difficultyLevel = difficultyLevel;
    }
    
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Name: %@ - difficulty: %d", self.name, self.difficultyLevel];
}

@end
