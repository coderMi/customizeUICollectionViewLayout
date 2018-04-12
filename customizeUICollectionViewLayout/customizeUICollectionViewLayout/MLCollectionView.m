//
//  MLCollectionView.m
//  customizeUICollectionViewLAyout
//
//  Created by mali on 2018/4/12.
//  Copyright © 2018年 DreamBlue. All rights reserved.
//

#import "MLCollectionView.h"
#import "MLCollectionViewCell.h"

@interface MLCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation MLCollectionView

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[MLCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MLCollectionViewCell class])];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MLCollectionViewCell class]) forIndexPath:indexPath];
    
    cell.image = _dataArray[indexPath.row];
    
    return cell;
}


@end
