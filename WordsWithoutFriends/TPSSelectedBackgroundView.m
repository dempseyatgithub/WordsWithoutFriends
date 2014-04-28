//
//  TPSSelectedBackgroundView.m
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import "TPSSelectedBackgroundView.h"

/* This background view takes advantage of the fact that views do not clip drawing to their bounds.  The bottom divider is actually drawn below the selected cell.  For the top divider, the code uses a properly-sized view with its background color set.  For the bottom divider, it appears that the view is not drawn if it is less than 1.0 point in height.  The bottom divider is a custom view, with the view 1.0 point high.  That view draws a line that is 0.5 points on a Retina display (which draws as 1 pixel thickness).
 */

#pragma mark -

/* A little custom view class to draw the bottom separator */
@interface TPSBottomSeparatorView : UIView
@property (nonatomic, strong) UIColor *separatorColor;
@end

@implementation TPSBottomSeparatorView
- (void)drawRect:(CGRect)rect {
    CGFloat yLocation = 0.5 / self.contentScaleFactor;
    CGFloat lineThickness = 1.0 / self.contentScaleFactor;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0.0, yLocation)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width, yLocation)];
    [path setLineWidth:lineThickness];
    [self.separatorColor set];
    [path stroke];
}
@end

#pragma mark -

@interface TPSSelectedBackgroundView ()
@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, weak) UIView *topSeparatorView;
@property (nonatomic, weak) TPSBottomSeparatorView *bottomSeparatorView;
@end


@implementation TPSSelectedBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // We aren't in our window yet, too early to call self.window.scale
        CGFloat lineHeight = 1.0 / [[UIScreen mainScreen] scale];

        UIView *topSeparatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width, lineHeight)];
        topSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        [self addSubview:topSeparatorView];
        _topSeparatorView = topSeparatorView;

        // Why a custom subclass? See comment at top of file.
        TPSBottomSeparatorView *bottomSeparatorView = [[TPSBottomSeparatorView alloc] initWithFrame:CGRectMake(0.0, self.bounds.size.height, self.bounds.size.width, 1.0)];
        bottomSeparatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        bottomSeparatorView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomSeparatorView];
        _bottomSeparatorView = bottomSeparatorView;
        
        UIView *colorView = [[UIView alloc] initWithFrame:self.bounds];
        colorView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:colorView];
        _colorView = colorView;
        
    }
    
    return self;
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.topSeparatorView.backgroundColor = separatorColor;
    self.bottomSeparatorView.separatorColor = separatorColor;
}

@end
