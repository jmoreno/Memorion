//
//  ZNKViewController.h
//  Memorion
//
//  Created by Javi on 07/05/13.
//  Copyright (c) 2013 zinkinapps.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNKViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UISegmentedControl *levelControl;
@property (strong, nonatomic) IBOutlet UIButton *mainButton;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

- (IBAction)levelChanged:(id)sender;
- (IBAction)restartGame:(id)sender;

@end
