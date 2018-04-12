//
//  MLWaterflowLayout.h
//  MaliTest
//
//  Created by mali on 2018/4/12.
//  Copyright © 2018年 陈伟峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLWaterflowLayoutDelegate <NSObject>

/**
 计算indexPath位置上的item的高度

 @param width       item的宽度
 @param indexPath   item的位置
 @return            item的高度
 */
- (CGFloat)heightForItemWithWidth:(CGFloat) width AtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MLWaterflowLayout : UICollectionViewLayout

/** 内边距 */
@property (nonatomic, assign) UIEdgeInsets sectionInsets;

/** 总列数 */
@property (nonatomic, assign) NSInteger numberOfColumns;

/** item之间的行间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/** item之间的列间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;

/** 代理属性 */
@property (nonatomic, weak) id<MLWaterflowLayoutDelegate> delegate;

@end
