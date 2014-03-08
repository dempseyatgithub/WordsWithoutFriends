//
//  TPSSelectedBackgroundView.h
//  WordsWithoutFriends
//
//  Created by Presenter on 11/16/13.
//  Copyright (c) 2013 Tapas Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPSSelectedBackgroundView : UIView

@property (nonatomic, readonly) UIView *colorView;
@property (nonatomic, assign) UIEdgeInsets separatorInsets;
@property (nonatomic, strong) UIColor *separatorColor;

@end
