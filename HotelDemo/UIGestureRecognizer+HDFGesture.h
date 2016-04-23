//
//  UIGestureRecognizer+HDFGesture.h
//  DEMO
//
//  Created by huangyibiao on 15/6/10.
//  Copyright (c) 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HDFLongGestureBlock)(UILongPressGestureRecognizer *sender);
typedef void(^HDFGestureBlock)(UIGestureRecognizer *sender);

/**
 *  @author Huangyibiao
 *
 *  给手势添加block版本的初始化方法
 *
 *  @since v0.1
 */
@interface UIGestureRecognizer (HDFGesture)

/**
 * @author Huangyibiao
 *
 * UIGestureRecognizer点击手势的block版本回调
 *
 * @see HDFGestureBlock
 */
@property (nonatomic, copy) HDFGestureBlock hdf_gestureBlock;

/**
 * @author Huangyibiao
 *
 * UILongGestureRecognizer点击手势的block版本回调
 *
 * @see HDFLongGestureBlock
 */
@property (nonatomic, copy) HDFLongGestureBlock hdf_longGestureBlock;

@end
