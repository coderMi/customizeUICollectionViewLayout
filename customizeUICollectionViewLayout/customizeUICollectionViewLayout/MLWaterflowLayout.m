//
//  MLWaterflowLayout.m
//  MaliTest
//
//  Created by mali on 2018/4/12.
//  Copyright © 2018年 陈伟峰. All rights reserved.
//

#import "MLWaterflowLayout.h"

@interface MLWaterflowLayout ()

/** 存放所有item的布局属性 */
@property (nonatomic, strong) NSMutableArray *itemAttributesArray;

/** 存放所有列的高度 */
@property (nonatomic, strong) NSMutableArray *columnsHeightArray;

/** item的总数 */
@property (nonatomic, assign) NSInteger numberOfItems;

@end

@implementation MLWaterflowLayout

#pragma mark - 懒加载
- (NSMutableArray *)itemAttributesArray {
    if (!_itemAttributesArray) {
        _itemAttributesArray = [NSMutableArray array];
    }
    return _itemAttributesArray;
}
- (NSMutableArray *)columnsHeightArray {
    if (!_columnsHeightArray) {
        _columnsHeightArray = [NSMutableArray arrayWithCapacity:self.numberOfColumns];
    }
    return _columnsHeightArray;
}
- (NSInteger)numberOfItems {
    if (!_numberOfItems) {
        _numberOfItems = [self.collectionView numberOfItemsInSection:0];
    }
    return _numberOfItems;
}


#pragma mark - 重写父类的布局方法
- (void)prepareLayout {
    [self initialColumnsHeightsArray];
    [self calculateAttributesForitems];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //创建一个数组来存放显示在屏幕中的item的attributes
    NSMutableArray *tempArr = [NSMutableArray array];
    //遍历self.itemAttributesArray
    for (UICollectionViewLayoutAttributes *attributes in self.itemAttributesArray) {
        //判断item是否显示在屏幕中
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            //如果是,保存到tempArr
            [tempArr addObject:attributes];
        }
    }
    return tempArr;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, self.sectionInsets.bottom + [self.columnsHeightArray[[self getHighestColumnsIndex]] floatValue]);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}


#pragma mark - 自定义方法
/** 初始化self.columnsHeightArray */
- (void)initialColumnsHeightsArray {
    //1.避免出错,先清空self.columnsHeightArray
    [self.columnsHeightArray removeAllObjects];
    //2.根据self.numberOfColumns来初始化self.columnsHeightArray
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        //为每一个item设置初始高度
        [self.columnsHeightArray addObject:@(self.sectionInsets.top)];
    }
}

/** 计算所有item的布局属性 */
- (void)calculateAttributesForitems {
    for (NSInteger i = 0; i < self.numberOfItems; i ++) {
        //根据总列数算出每一个item的宽度
        CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width - self.sectionInsets.left - (self.numberOfColumns - 1) * self.minimumInteritemSpacing - self.sectionInsets.right) / self.numberOfColumns;
        //拿到当前高度最小的列的索引
        NSInteger shortestIndex = [self getShortestColumnsIndex];
        //计算当前item的X坐标
        CGFloat itemX = self.sectionInsets.left + (itemWidth + self.minimumInteritemSpacing) * shortestIndex;
        //通过代理获得当前item的高度
        CGFloat itemHeight = 0;
        if ([self.delegate respondsToSelector:@selector(heightForItemWithWidth:AtIndexPath:)]) {
            itemHeight = [self.delegate heightForItemWithWidth:itemWidth AtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        //计算当前item的Y坐标
        CGFloat itemY = [self.columnsHeightArray[shortestIndex] floatValue] + self.minimumLineSpacing;
        //将item的布局属性保存到数组
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        [self.itemAttributesArray addObject:attributes];
        //将高度保存到columnsHeightArray数组中
        [self.columnsHeightArray replaceObjectAtIndex:shortestIndex withObject:@(itemY + itemHeight)];
    }
}

/** 获得所有列中高度最小的那一列的索引 */
- (NSInteger)getShortestColumnsIndex {
    //创建一个变量来保存高度最小的索引
    NSInteger shortestIndex = 0;
    //创建一个变量来保存最小的高度
    CGFloat shortestHeihgt = MAXFLOAT;
    //遍历数组,获得最小的高度及其索引
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        CGFloat currentHeight = [self.columnsHeightArray[i] floatValue];
        if (currentHeight < shortestHeihgt) {
            shortestHeihgt = currentHeight;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

/** 获得所有列中高度最大的那一列的索引 */
- (NSInteger)getHighestColumnsIndex {
    //创建一个变量来保存高度最大的索引
    NSInteger highestIndex = 0;
    //创建一个变量来保存最大的高度
    CGFloat highestHeihgt = 0;
    //遍历数组,获得最小的高度及其索引
    for (NSInteger i = 0; i < self.numberOfColumns; i ++) {
        CGFloat currentHeight = [self.columnsHeightArray[i] floatValue];
        if (currentHeight > highestHeihgt) {
            highestHeihgt = currentHeight;
            highestIndex = i;
        }
    }
    return highestIndex;
}



@end
