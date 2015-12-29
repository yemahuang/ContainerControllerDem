//
//  TestView.h
//  lightapp
//
//  Created by Ming on 15/12/28.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TabContentDelegate <NSObject>

- (void)scrollOffset:(CGPoint)offset;
- (void)contentSelectedPage:(NSInteger)page;

@end

@interface TestView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, weak) id<TabContentDelegate> tabContentDelegate;

@property (nonatomic, strong) NSMutableArray *contentArray;

- (void)selectPage:(NSInteger)page;
- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray*)array;

@end
