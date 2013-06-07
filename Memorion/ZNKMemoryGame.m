//
//  ZNKMemoryGame.m
//  Memorion
//
//  Created by Javi on 08/05/13.
//  Copyright (c) 2013 zinkinapps.com. All rights reserved.
//

#import "ZNKMemoryGame.h"

@implementation ZNKMemoryGame

#pragma mark Métodos

+ (id)sharedInstance {
    static ZNKMemoryGame *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    if (self = [super init]) {
        _level = 1;
        [self newGameWithLevel:_level];
    }
    return self;
}

#pragma mark - Metodos para la gestión de los arrays

- (void)newGameWithLevel:(int)level
{
    _level = level;
    int numberOfItems = pow(((_level + 1) * 2), 2);
    
    if (!_arrayOfDiscovered) {
        _arrayOfDiscovered = [[NSMutableArray alloc] initWithCapacity:0];
    } else {
        [_arrayOfDiscovered removeAllObjects];
    }
    for (int i = 0; i < numberOfItems; i++) {
        [_arrayOfDiscovered addObject:@"NO"];
    }
    
    if (!_arrayOfSelected) {
        _arrayOfSelected = [[NSMutableArray alloc] initWithCapacity:0];
    } else {
        [_arrayOfSelected removeAllObjects];
    }
    
    if (!_arrayOfItems) {
        _arrayOfItems = [[NSMutableArray alloc] init];
    } else {
        [_arrayOfItems removeAllObjects];
    }
    for (int i = 0; i < numberOfItems / 2 ; i++) {
        [_arrayOfItems addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%i.png", i+1]]];
    }
    [_arrayOfItems addObjectsFromArray:_arrayOfItems];
    [self shuffle];
    
    _totalDiscovered = 0;
    
    _finishedGame = NO;
    
    [self reloadScoreLabel];
}

- (void)shuffle
{
    NSUInteger count = [_arrayOfItems count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        NSInteger nElements = count - i;
        NSInteger n = (arc4random() % nElements) + i;
        [_arrayOfItems exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (BOOL)cellAtIndexPathCanBeSelected:(NSIndexPath *)indexPath
{
    if ([[_arrayOfDiscovered objectAtIndex:indexPath.row] isEqualToString:@"NO"]) {
        return YES;
    }
    return NO;
}

- (BOOL)twoCellsSelected
{
    if ([_arrayOfSelected count] == 2) {
        return YES;
    }
    return NO;
}

- (void)checkSelectionWithCompletion:(void (^)(BOOL, NSArray *, BOOL))completion
{
    if ([_arrayOfSelected count] == 2) {
        NSIndexPath *firstSelection = [_arrayOfSelected objectAtIndex:0];
        NSIndexPath *secondSelection = [_arrayOfSelected objectAtIndex:1];
        if ([[_arrayOfItems objectAtIndex:firstSelection.row] isEqual:[_arrayOfItems objectAtIndex:secondSelection.row]]) {
            _totalDiscovered += 2;
            if (_totalDiscovered == [_arrayOfItems count]) {
                _finishedGame = YES;
            }
            NSArray *selectedCells = [[NSArray alloc] initWithArray:_arrayOfSelected];
            [_arrayOfSelected removeAllObjects];
            [_arrayOfDiscovered replaceObjectAtIndex:firstSelection.row withObject:@"YES"];
            [_arrayOfDiscovered replaceObjectAtIndex:secondSelection.row withObject:@"YES"];
            [self reloadScoreLabel];
            completion(YES, selectedCells, _finishedGame);
        }
    }
    completion(NO, nil, _finishedGame);
}

- (void)reloadScoreLabel
{
    _scoreString = [NSString stringWithFormat:@"%i/%i", _totalDiscovered, [_arrayOfItems count]];
}



@end
