//
//  CJTagsFlowLayoutView.m
//  CommonProject
//
//  Created by ZhuMac on 2017/5/17.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import "CJTagsFlowLayoutView.h"

#define kScreenWidth  ([UIScreen mainScreen].bounds.size.width)

static CGFloat CJStringWidth(NSString *string, UIFont *font, CGFloat height) {
    if (!string) return 0.f;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}


@implementation CJTagsFlowLayoutView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(!self) return nil;
    
    [self initParameters];
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(!self) return nil;
    
    [self initParameters];

    return self;
}



-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self cj_tagsViewLayout];
}

-(void)initParameters {
    self.cj_margin = 10.f;
    self.cj_space_horizontal = 10.f;
    self.cj_space_vertical   = 10.f;
    self.cj_padding          = 10.f;
    self.tagsFlowLayoutType  = CJTagsFlowLayoutTypeAuto;
}

-(void)sizeToFit {
    CGRect frame = self.frame;
    frame.size   = [self sizeThatFits:CGSizeZero];
    self.frame   = frame;
}

-(CGSize)sizeThatFits:(CGSize)size {
    return [self cj_tagsViewLayout];
}

#pragma mark --- private method
-(CGSize)cj_tagsViewLayout {
    
    NSArray<NSNumber *> *subTitleWidths = [self cj_subViewsWidth];
    
    CGRect previousFrame = CGRectMake(_cj_margin, 0, 0, 0);
    for (NSUInteger i = 0, l = subTitleWidths.count; i < l; i++) {
        UIView *tagView = self.subviews[i];
        
        CGFloat tagView_x = 0;
        CGFloat tagView_y = 0;
        CGFloat totalLength = i == 0?((CGRectGetMaxX(previousFrame) + subTitleWidths[i].floatValue)):(CGRectGetMaxX(previousFrame) + _cj_space_horizontal + subTitleWidths[i].floatValue);
        if (totalLength >= kScreenWidth) {
            
            tagView_x = _cj_margin;
            tagView_y = CGRectGetMaxY(previousFrame) + _cj_space_vertical;
            
        }else {
            
            tagView_x = i == 0?_cj_margin:(CGRectGetMaxX(previousFrame) + _cj_space_horizontal);
            tagView_y = previousFrame.origin.y;
            
        }
        
        CGFloat tagView_w = [subTitleWidths[i] floatValue];
        CGFloat tagView_h = _cj_tagHeight;
        tagView.frame     = CGRectMake(tagView_x, tagView_y, tagView_w, tagView_h);
        previousFrame     = tagView.frame;
    }
    
    return CGSizeMake(self.frame.size.width, CGRectGetMaxY(previousFrame));
}

-(NSArray<NSNumber *> *)cj_subViewsWidth {
    
    NSMutableArray<NSNumber *> *subtitleWidths = @[].mutableCopy;
    if (_tagsFlowLayoutType == CJTagsFlowLayoutTypeOriginal) {
        NSAssert(_cj_tagWidth, @"cj_tagWidth = 0！！！必须设置每个子控件的宽度");
        CGFloat titleWidth  = _cj_tagWidth;
        int tag_count = floor((self.frame.size.width + _cj_space_horizontal)/(_cj_tagWidth+_cj_space_horizontal));
        _cj_margin    = (self.frame.size.width + _cj_space_horizontal - tag_count*((_cj_tagWidth+_cj_space_horizontal)))/2.f;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
        for (UIView *tagView in self.subviews) {
            [subtitleWidths addObject:@(titleWidth)];
        }
#pragma clang diagnostic pop
        return subtitleWidths;
    }
    
    for (NSUInteger i = 0, l = self.subviews.count; i < l ; i++) {
        
        if (![self.subviews[i] isKindOfClass:[UIButton class]]) {
            NSAssert(_cj_tagWidth, @"cj_tagWidth = 0！！！你的tagView是非Button类型，所以这个时候，必须要设置cj_tagWidth。不然没法获取高度");
            [subtitleWidths addObject:@(_cj_tagWidth)];
            
        }else {
            UIButton *subBtn   = (UIButton *)self.subviews[i];
            NSString *title    = subBtn.titleLabel.text;
            
            CGFloat titleWidth = 0.f;
            titleWidth = CJStringWidth(title, subBtn.titleLabel.font, _cj_tagHeight);
            [subtitleWidths addObject:[NSNumber numberWithFloat:(titleWidth + _cj_padding*2)]];
        }
    }
    return subtitleWidths;
}

@end
