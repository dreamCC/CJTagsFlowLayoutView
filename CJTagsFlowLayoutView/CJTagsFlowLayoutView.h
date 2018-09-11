//
//  CJTagsFlowLayoutView.h
//  CommonProject
//
//  Created by ZhuMac on 2017/5/17.
//  Copyright © 2017年 zhucj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJTagsFlowLayoutType) {
    CJTagsFlowLayoutTypeAuto,     // 根据tagViewContent自动适应宽度
    CJTagsFlowLayoutTypeOriginal  // 使用原始尺寸
};

@interface CJTagsFlowLayoutView : UIView

/// 每个subView的高度,必须设置。
@property(nonatomic, assign) CGFloat cj_tagHeight;

/// 每个subView的宽度， 只有当tagsFlowLayoutType 为CJTagsFlowLayoutTypeOriginal时候才有用
@property(nonatomic, assign) CGFloat cj_tagWidth;

/// 边缘距离，默认10
@property(nonatomic, assign) CGFloat cj_margin;

/// 水平方向间距，默认10
@property(nonatomic, assign) CGFloat cj_space_horizontal;

/// 数值方向间距，默认10
@property(nonatomic, assign) CGFloat cj_space_vertical;

/// 内间距， 默认10
@property(nonatomic, assign) CGFloat cj_padding;

/// 布局方式，默认CJTagsFlowLayoutTypeAuto。
// 注意：如果设置CJTagsFlowLayoutTypeOriginal，那么设置cj_margin、cj_padding属性就会失效。会根据当前tagView的宽度和CJTagsFlowLayoutView的宽度来计算出新的cj_margin。
// 如果设置CJTagsFlowLayoutTypeAuto，那么cj_tagWidth属性就会失效。会根据tagView内部内容大小来动态计算宽度。
@property(nonatomic, assign) CJTagsFlowLayoutType tagsFlowLayoutType;

@end
