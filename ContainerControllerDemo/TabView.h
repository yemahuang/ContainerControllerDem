//
//  TabView.h
//  lightapp
//
//  Created by Ming on 15/12/26.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickDelegate <NSObject>
- (void)selectedPage:(NSInteger)page;
@end

@interface TabView : UIScrollView
@property (nonatomic, assign) NSInteger selectedPage;
@property (nonatomic, weak) id<ClickDelegate>  clickDelegate;
- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items;
- (void)selectPage:(NSInteger)page;
- (void)setOffsetWithPage:(NSInteger)page andRatio:(CGFloat) ratio;

@end
