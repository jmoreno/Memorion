//
//  ZNKViewController.m
//  Memorion
//
//  Created by Javi on 07/05/13.
//  Copyright (c) 2013 zinkinapps.com. All rights reserved.
//

#import "ZNKViewController.h"
#import "ZNKMemoryCell.h"

@interface ZNKViewController ()

@end

@implementation ZNKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)levelChanged:(id)sender {
    
    [_collectionView reloadData];
    
}

#pragma mark - UICollectionView Data Source Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return pow((_levelControl.selectedSegmentIndex + 1) * 2, 2);
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
    
    return cell;
    
}

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int screenWidth = _collectionView.bounds.size.width;
    
    NSInteger width = screenWidth / ((_levelControl.selectedSegmentIndex + 1) * 2);
    
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

}


@end
