//
//  TPSSelectedBackgroundView.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 /Users/presenter/Desktop/WordListSelectedBackgroundView.hTapas Software. All rights reserved.
//

#import "TPSSelectedBackgroundView.h"

@interface TPSSelectedBackgroundView ()
@property (nonatomic, weak) UIView *colorView;
@property (nonatomic, weak) UIView *topSeparatorView;
@property (nonatomic, weak) UIView *bottomSeparatorView;
@end


@implementation TPSSelectedBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topSeparatorView = [[UIView alloc] init];
        topSeparatorView.frame = CGRectMake(0.0, 0.0, self.bounds.size.width, 1.0);
        topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:topSeparatorView];
        _topSeparatorView = topSeparatorView;
        
        UIView *bottomSeparatorView = [[UIView alloc] init];
        bottomSeparatorView.frame = CGRectMake(0.0, self.bounds.size.height, self.bounds.size.width, 1.0);
        bottomSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:bottomSeparatorView];
        _bottomSeparatorView = bottomSeparatorView;
        
        UIView *colorView = [[UIView alloc] init];
        colorView.bounds = self.frame;
        colorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:colorView];
        _colorView = colorView;
        
    }
    
    return self;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.topSeparatorView.backgroundColor = separatorColor;
    self.bottomSeparatorView.backgroundColor = separatorColor;
}

@end
