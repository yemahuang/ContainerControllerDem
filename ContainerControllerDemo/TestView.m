
//
//  TestView.m
//  lightapp
//
//  Created by Ming on 15/12/28.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import "TestView.h"

@implementation TestView

@synthesize contentArray,tabContentDelegate;

- (instancetype)initWithFrame:(CGRect)frame andArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.delegate = self;
        self.directionalLockEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor lightGrayColor];
        self.delaysContentTouches = NO;
        contentArray = [[NSMutableArray alloc]init];
        for (UIViewController *controller in array) {
            [contentArray addObject:controller.view];
        }
        [self loadScrollView];
    }
    return self;
}

- (void)loadScrollView {
    CGFloat width = 0;
    for (NSInteger page=0; page<contentArray.count; page++) {
        
        UIView *view = [self.contentArray objectAtIndex:page];
        CGRect frame = self.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        view.frame = frame;
        view.tag = page;
        width += frame.size.width;
        view.backgroundColor = [UIColor clearColor];
        
        CGFloat r = arc4random() % 255;
        
        CGFloat g = arc4random() % 255;
        
        CGFloat b = arc4random() % 255;
        view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        [self addSubview:view];
    }
    [self setContentSize:CGSizeMake(width, self.frame.size.height)];
}

- (void)selectPage:(NSInteger)page {
    
    CGFloat pageWidth = CGRectGetWidth(self.frame);
    [self setContentOffset:CGPointMake(pageWidth*page, self.bounds.origin.y)animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (tabContentDelegate != nil && [tabContentDelegate respondsToSelector:@selector(scrollOffset:)]) {
        [tabContentDelegate scrollOffset:self.contentOffset];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (tabContentDelegate != nil && [tabContentDelegate respondsToSelector:@selector(contentSelectedPage:)]) {
        NSInteger page = self.contentOffset.x/self.frame.size.width;
        [tabContentDelegate contentSelectedPage:page];
    }
}

@end
