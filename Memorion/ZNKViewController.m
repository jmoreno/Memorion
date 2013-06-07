//
//  ZNKViewController.m
//  Memorion
//
//  Created by Javi on 07/05/13.
//  Copyright (c) 2013 zinkinapps.com. All rights reserved.
//

#import "ZNKViewController.h"
#import "ZNKMemoryCell.h"
#import "ZNKMemoryGame.h"

@interface ZNKViewController ()

@property (nonatomic, strong) ZNKMemoryGame *memoryGame;

@end

@implementation ZNKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _memoryGame = [ZNKMemoryGame sharedInstance];
    _levelControl.selectedSegmentIndex = _memoryGame.level;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)levelChanged:(id)sender {
    
    [self restartGame:nil];
    
}

- (IBAction)restartGame:(id)sender {

    _finishedGameImage.alpha = 0;
    [_memoryGame newGameWithLevel:_levelControl.selectedSegmentIndex];
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionView Data Source Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_memoryGame.arrayOfItems count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // we're going to use a custom UICollectionViewCell, which will hold an image and its label
    //
    ZNKMemoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    // make the cell's title the actual NSIndexPath value
    cell.coverImageView.image = [UIImage imageNamed:@"105.png"];
    cell.secretImageView.image = [_memoryGame.arrayOfItems objectAtIndex:indexPath.row];
    cell.secretImageView.alpha = 0.0;
    cell.coverImageView.alpha = 1.0;
    
    if ([[_memoryGame.arrayOfDiscovered objectAtIndex:indexPath.row] isEqualToString:@"NO"]) {
        cell.backgroundColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:255.0/255.0 alpha:1];
    } else {
        cell.backgroundColor = [UIColor redColor];
        cell.secretImageView.alpha = 1.0;
        cell.coverImageView.alpha = 0.0;
    }


    return cell;
    
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int screenWidth = _collectionView.bounds.size.width;
    
    NSInteger width = screenWidth / sqrt([_memoryGame.arrayOfItems count]);
    
    CGSize cellSize = CGSizeMake(width, width);
    
    return cellSize;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_memoryGame cellAtIndexPathCanBeSelected:indexPath]) {
        if ([_memoryGame.arrayOfSelected count] == 2) {
            for (NSIndexPath *indexPathSelected in _memoryGame.arrayOfSelected) {
                [self hideTheShowedObjectAtIndexPath:indexPathSelected];
            }
            [_memoryGame.arrayOfSelected removeAllObjects];
        } else if ([_memoryGame.arrayOfSelected count] == 1) {
            if (![indexPath isEqual:[_memoryGame.arrayOfSelected objectAtIndex:0]]) {
                [self showTheHidenObjectAtIndexPath:indexPath];
                [_memoryGame.arrayOfSelected addObject:indexPath];
            }
        } else {
            [self showTheHidenObjectAtIndexPath:indexPath];
            [_memoryGame.arrayOfSelected addObject:indexPath];
        }
    }
}

#pragma mark - Animated selections

-(void)showTheHidenObjectAtIndexPath:(NSIndexPath *)indexPath
{
    ZNKMemoryCell *cell = (ZNKMemoryCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    cell.secretImageView.alpha = 0.0;
    cell.coverImageView.alpha = 1.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.secretImageView.alpha = 1.0;
        cell.coverImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [_memoryGame checkSelectionWithCompletion:^(BOOL matched, NSArray *selectedCells, BOOL finishedGame) {
            if (matched) {
                for (NSIndexPath *cell in selectedCells) {
                    [self changeTheColorOfTheCellAtIndexPath:cell];
                }
            }
            if (finishedGame) {
                [UIView animateWithDuration:0.25 animations:^{
                    _finishedGameImage.alpha = 1;
                }];
            }
        }];
    }];
}

-(void)hideTheShowedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    ZNKMemoryCell *cell = (ZNKMemoryCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    cell.secretImageView.alpha = 1.0;
    cell.coverImageView.alpha = 0.0;
    
    [UIView animateWithDuration:0.5 animations:^{
        cell.secretImageView.alpha = 0.0;
        cell.coverImageView.alpha = 1.0;
    }];
}

-(void)changeTheColorOfTheCellAtIndexPath:(NSIndexPath *)indexPath
{
    ZNKMemoryCell *cell = (ZNKMemoryCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.25 animations:^{
        cell.backgroundColor = [UIColor redColor];
    }];    
}


@end
