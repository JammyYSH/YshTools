//
//  WMZDialogNormal.m
//  WMZDialog
//
//  Created by wmz on 2021/7/17.
//  Copyright © 2021 wmz. All rights reserved.
//

#import "WMZDialogNormal.h"
#import "WMZDialog.h"
@implementation WMZDialogNormal
@synthesize cancelBtn = _cancelBtn ;
@synthesize OKBtn = _OKBtn;
@synthesize textLabel = _textLabel;
@synthesize titleLabel = _titleLabel;
@synthesize closeBtn = _closeBtn;
@synthesize bottomView = _bottomView;
@synthesize headView = _headView;
@synthesize iconIV = _iconIV;

- (void)setParam:(WMZDialogParam *)param{
    if (param) {
        self.titleLabel.text = param.wTitle;
        self.titleLabel.font = [UIFont systemFontOfSize:param.wTitleFont];
        self.titleLabel.textColor =  param.wTitleColor;

        self.textLabel.text = param.wMessage;
        self.textLabel.font = [UIFont systemFontOfSize:param.wMessageFont];
        self.textLabel.textColor = param.wMessageColor;
           
        [self.cancelBtn addTarget:self action:@selector(cancelAction:)forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn setTitle:param.wCancelTitle forState:UIControlStateNormal];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:param.wCancelFont];
        [self.cancelBtn setTitleColor:param.wCancelColor forState:UIControlStateNormal];
        self.cancelBtn.backgroundColor = param.wMainBackColor;
           
        [self.OKBtn setTitle:param.wOKTitle forState:UIControlStateNormal];
        [self.OKBtn setTitleColor:param.wOKColor forState:UIControlStateNormal];
        self.OKBtn.titleLabel.font = [UIFont systemFontOfSize:param.wOKFont];
        self.OKBtn.backgroundColor = param.wMainBackColor;
        [self.OKBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
           
        [self.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.closeBtn setTitle:@"X" forState:UIControlStateNormal];
        [self.closeBtn setTitleColor:param.wCancelColor forState:UIControlStateNormal];
        self.closeBtn.backgroundColor = param.wMainBackColor;
        self.closeBtn.tag = 666;
        self.closeBtn.layer.borderWidth = DialogK1px;
        self.closeBtn.layer.borderColor = param.wCancelColor.CGColor;
    }
    [super setParam:param];
}

- (UIView*)addBottomView:(CGFloat)maxY{
    if (self.bottomView) {
        CGRect rect = self.bottomView.frame;
        rect.origin.y = maxY;
        self.bottomView.frame = rect;
        return self.bottomView;
    }
    
    self.bottomView = [UIView new];
    [self addSubview:self.bottomView];
    
    UIView *upLine = [UIView new];
    upLine.alpha = self.param.wLineAlpha;
    [self.bottomView addSubview:upLine];
    upLine.backgroundColor = self.param.wLineColor;
    upLine.frame = CGRectMake(0, 0, self.param.wWidth, DialogK1px);
    if (self.param.wEventCancelFinish) {
        [self.bottomView addSubview:self.cancelBtn];
        self.cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX, self.param.wWidth/2-DialogK1px/2, self.param.wMainBtnHeight);
        
        UIView *Line = [UIView new];
        Line.alpha = self.param.wLineAlpha;
        Line.tag = 11111;
        [self.bottomView addSubview:Line];
        Line.backgroundColor = self.param.wLineColor;
        Line.frame = CGRectMake(CGRectGetMaxX(self.cancelBtn.frame),  self.param.wFillBottomLine?CGRectGetMaxY(upLine.frame): self.cancelBtn.frame.origin.y, DialogK1px, self.param.wMainBtnHeight + (self.param.wFillBottomLine?self.param.wMainOffsetX * 2:0));
    }
    
    [self.bottomView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.param.wEventCancelFinish?CGRectGetMaxX(self.cancelBtn.frame)+DialogK1px:0, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX,self.param.wEventCancelFinish?self.param.wWidth/2-DialogK1px/2:self.param.wWidth, self.param.wMainBtnHeight);
    
    CGSize OKSize = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth, CGFLOAT_MAX) text:self.param.wOKTitle font:[UIFont systemFontOfSize:self.param.wOKFont]];
    CGSize cancelSize ;
    if (self.param.wEventCancelFinish)
        cancelSize = [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth, CGFLOAT_MAX) text:self.param.wCancelTitle font:[UIFont systemFontOfSize:self.param.wCancelFont]];

    if (OKSize.width > (self.OKBtn.frame.size.width - self.param.wMainOffsetX * 2) ||
        cancelSize.width > (self.OKBtn.frame.size.width - self.param.wMainOffsetX * 2)) {
        UIView *line = [self.bottomView viewWithTag:11111];
        if (self.param.wEventCancelFinish) {
            self.cancelBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            self.cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.cancelBtn.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX, self.param.wWidth  - self.param.wMainOffsetX*2, cancelSize.height);
            if (line) {
                line.frame = CGRectMake(0, CGRectGetMaxY(self.cancelBtn.frame) + (self.param.wFillBottomLine?0:self.param.wMainOffsetX), self.param.wWidth, DialogK1px);
            }
        }
        self.OKBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.OKBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.OKBtn.frame = CGRectMake(self.param.wMainOffsetX, self.param.wEventCancelFinish?(CGRectGetMaxY(line.frame) + self.param.wMainOffsetX): (CGRectGetMaxY(upLine.frame)+self.param.wMainOffsetX),self.param.wWidth - self.param.wMainOffsetX*2, OKSize.height);
    }
    
    self.bottomView.frame = CGRectMake(0, maxY, self.param.wWidth, CGRectGetMaxY(self.OKBtn.frame)+self.param.wMainOffsetX);
    
    return self.bottomView;
}

- (UIView*)addTopView{
    if (self.param.wHideExistTop) {
       self.headView = nil; return self.headView;
    }
    if (self.headView) return self.headView;
    CGFloat btnWidth = 50;
    self.headView = [UIView new];
    self.headView.backgroundColor = self.param.wMainBackColor;
    self.headView.frame = CGRectMake(0, 0, self.param.wWidth, self.param.wMainBtnHeight+self.param.wMainOffsetY);
    [self addSubview:self.headView];
        
    [self.headView addSubview:self.cancelBtn];
    self.cancelBtn.frame = CGRectMake(self.param.wMainOffsetX, self.param.wMainOffsetY / 2, btnWidth, self.param.wMainBtnHeight);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
          
    [self.headView addSubview:self.OKBtn];
    self.OKBtn.frame = CGRectMake(self.param.wWidth- btnWidth - self.param.wMainOffsetX, self.param.wMainOffsetY / 2,btnWidth, self.param.wMainBtnHeight);
    self.OKBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
          
    [self.headView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(btnWidth + 2 * self.param.wMainOffsetX, self.param.wMainOffsetY / 2, self.param.wWidth - 2 * btnWidth - 4 * self.param.wMainOffsetX, self.param.wMainBtnHeight);
    
    UIView *line = [UIView new];
    line.backgroundColor = self.param.wLineColor;
    line.frame = CGRectMake(0, self.headView.frame.size.height - DialogK1px, self.headView.frame.size.width, DialogK1px );
    [self.headView addSubview:line];
    return self.headView;
}

- (CGFloat)addTopTitleView{
    [self addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(self.param.wMainOffsetX, DialogStrIsNotEmpty(self.param.wTitle) ? self.param.wMainOffsetY:0, self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth - self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.titleLabel.text font:self.titleLabel.font].height);
    [self addSubview:self.textLabel];
    self.textLabel.frame = CGRectMake(self.param.wMainOffsetX, CGRectGetMaxY(self.titleLabel.frame) +   (DialogStrIsNotEmpty(self.param.wMessage) ? self.param.wMainOffsetY : 0), self.param.wWidth - self.param.wMainOffsetX * 2, [WMZDialogUntils sizeForTextView:CGSizeMake(self.param.wWidth-self.param.wMainOffsetX * 2, CGFLOAT_MAX) text:self.textLabel.text font:self.textLabel.font].height);
    return CGRectGetMaxY(self.textLabel.frame);
}

/// 取消事件
- (void)cancelAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self]  closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventCancelFinish)
            self.param.wEventCancelFinish(@"取消",sender);
    }];
}

/// 确定事件
- (void)confirmAction:(WMZDialogButton*)sender{
    @DialogWeakify(self)
    [[WMZDialogManage.shareInstance currentDialog:self] closeView:^{
        @DialogStrongify(self)
        if (self.param.wEventOKFinish)
            self.param.wEventOKFinish(@"确定",sender);
    }];
}

///关闭事件
- (void)closeAction:(WMZDialogButton*)sender{
    [[WMZDialogManage.shareInstance currentDialog:self] closeView];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
    }
    return _textLabel;
}

-(WMZDialogButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}

-(WMZDialogButton *)OKBtn{
    if (!_OKBtn) {
        _OKBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
    }
    return _OKBtn;
}

- (WMZDialogButton *)closeBtn{
    if (!_closeBtn) {
         _closeBtn = [WMZDialogButton buttonWithType:UIButtonTypeCustom];
     }
     return _closeBtn;
}

- (UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = UIImageView.new;
    }
    return _iconIV;
}

@end