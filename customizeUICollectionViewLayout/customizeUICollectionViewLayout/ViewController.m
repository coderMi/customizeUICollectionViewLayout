//
//  ViewController.m
//  customizeUICollectionViewLayout
//
//  Created by mali on 2018/4/12.
//  Copyright © 2018年 DreamBlue. All rights reserved.
//

#import "ViewController.h"
#import "MLCollectionView.h"
#import "MLWaterflowLayout.h"

@interface ViewController () <MLWaterflowLayoutDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
        for (int i = 0; i < 41; i ++) {
            [_dataArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d", i]]];
        }
    }
    return _dataArray;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    MLWaterflowLayout *layout = [[MLWaterflowLayout alloc] init];
    layout.delegate = self;
    layout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.numberOfColumns = 3;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    MLCollectionView *collectionView = [[MLCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    collectionView.dataArray = self.dataArray;
    [self.view addSubview:collectionView];
}



#pragma mark - MLWaterflowLayoutDelegate
- (CGFloat)heightForItemWithWidth:(CGFloat)width AtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = self.dataArray[indexPath.row];
    
    CGFloat w = CGImageGetWidth(image.CGImage);
    CGFloat h = CGImageGetHeight(image.CGImage);
    
    return width * h / w;
}

@end
