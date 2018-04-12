//
//  MLCollectionViewCell.m
//  customizeUICollectionViewLAyout
//
//  Created by mali on 2018/4/12.
//  Copyright © 2018年 DreamBlue. All rights reserved.
//

#import "MLCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface MLCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation MLCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
    return self;
}


- (void)setImage:(UIImage *)image {
    _image = image;
    
    _imageView.image = image;
}


@end
