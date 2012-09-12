//
//  NSArray+Helpers.m
//  GAExerciseDemo
//
//  Created by Chris Linseman on 12/09/2012.
//  Copyright (c) 2012 Chris Linseman. All rights reserved.
//

#import "NSArray+Helpers.h"

@implementation NSArray (Helpers)

- (id)randomElement
{
    int index = arc4random() % [self count];
    id temp = [self objectAtIndex:index];
    return temp;
}

@end
