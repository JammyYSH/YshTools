//
//  GFButton.h
//  GoFactory
//
//  Created by 曹燕丽 on 2021/6/23.
//  Copyright © 2021 KQZK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFUICommonDefines.h"

NS_ASSUME_NONNULL_BEGIN


/// 控制图片在UIButton里的位置，默认为QMUIButtonImagePositionLeft
typedef NS_ENUM(NSUInteger, GFUIButtonImagePosition) {
    GFUIButtonImagePositionTop,             // imageView在titleLabel上面
    GFUIButtonImagePositionLeft,            // imageView在titleLabel左边
    GFUIButtonImagePositionBottom,          // imageView在titleLabel下面
    GFUIButtonImagePositionRight,           // imageView在titleLabel右边
};

@interface GFButton : UIButton

@property (nonatomic, copy  ) NSString                 *identifier;
@property (nonatomic, assign) GFUIButtonImagePosition   imagePosition;

@property (nonatomic, assign) IBInspectable CGFloat     spacingBetweenImageAndTitle;

@property (nonatomic, assign) IBInspectable CGFloat     cornerRadius UI_APPEARANCE_SELECTOR;// 默认为 0。将其设置为 QMUIButtonCornerRadiusAdjustsBounds 可自动保持圆角为按钮高度的一半。

@end

NS_ASSUME_NONNULL_END
