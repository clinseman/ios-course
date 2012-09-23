//
//  NSArray+Helpers.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "NSArray+Helpers.h"

@implementation NSArray (Helpers)

// return a random element from the array
- (id)randomElement
{
    // get a random number from 0 to array size
    int index = arc4random() % [self count];
    
    // get and return the object at that random number
    id temp = [self objectAtIndex:index];
    return temp;
}

@end
