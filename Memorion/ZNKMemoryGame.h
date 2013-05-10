//
//  ZNKMemoryGame.h
//  Memorion
//
//  Created by Javi on 08/05/13.
//  Copyright (c) 2013 zinkinapps.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNKMemoryGame : NSObject



@property (strong, nonatomic) NSMutableArray *arrayOfItems;
@property (strong, nonatomic) NSMutableArray *arrayOfSelected;
@property (strong, nonatomic) NSMutableArray *arrayOfDiscovered;
@property (strong, nonatomic) NSString *scoreString;
@property int totalDiscovered;
@property int level;


+ (id)sharedInstance;
- (void)newGameWithLevel:(int)level;
- (BOOL)cellAtIndexPathCanBeSelected:(NSIndexPath *)indexPath;
- (BOOL)twoCellsSelected;
- (void)checkSelectionWithCompletion:(void (^)(BOOL matched, NSArray *selectedCells))completion;


@end
