//
//  UINavigationBar+HDFNavigationBarTransluent.h
//  JiaHao
//
//  Created by huangyibiao on 15/8/24.
//  Copyright © 2015年 Jerry. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 设置导航条的透明度及设置导航Y轴方向变相（可用于动态改变导航条高度）
 *
 * @author huangyibiao
 */
@interface UINavigationBar (HDFNavigationBarTransluent)

/**
 * 修改导航背景颜色，如果要透明化，传clearColor
 * 
 * @param backgroundColor 背景色
 */
- (void)hdf_setBackgroundColor:(UIColor *)backgroundColor;

/**
 * 修改导航上的元素的透明度
 *
 * @param alpha 透明度
 */
- (void)hdf_setElementsAlpha:(CGFloat)alpha;

/**
 * 修改导航条的高度（0-44之间变化）
 *
 * @param translationY 变相系数
 */
- (void)hdf_setTranslationY:(CGFloat)translationY;

/**
 * 在需要清除之前的设置的地方，调用此API还原
 */
- (void)hdf_reset;

@end
