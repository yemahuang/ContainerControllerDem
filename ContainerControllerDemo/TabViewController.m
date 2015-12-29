//
//  TabViewController.m
//  lightapp
//
//  Created by Ming on 15/12/26.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import "TabViewController.h"

#define TAB_VIEW_HEIGHT 30
@implementation TabViewController
@synthesize currentPage,tabContentView,tabView,contentArray;

- (instancetype)initWithItems:(NSArray *)items andControllers:(NSArray *)controllers {
    self = [super init];
    if (self) {

        contentArray = controllers;
        tabView = [[TabView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TAB_VIEW_HEIGHT) andItems:items];

        tabView.clickDelegate = self;
        UIView *topView = [[UIView alloc]init];
        topView.frame = CGRectMake(0, 0, self.view.frame.size.width, TAB_VIEW_HEIGHT);
        [topView addSubview:tabView];
        self.navigationItem.titleView = topView;
        
        tabContentView = [[TestView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) andArray:controllers];
        
        tabContentView.tabContentDelegate = self;
        
        [self.view addSubview:tabContentView];
        
        if (controllers.count > 0) {
            for (UIViewController *controller in controllers) {
                [self addChildViewController:controller];
            }
        }
    
    }
    
    return self;
}

#pragma mark TabContentView delegate

- (void)contentSelectedPage:(NSInteger)page {
    currentPage = page;
    [tabView selectPage:page];
    
}

- (void)scrollOffset:(CGPoint)offset {
    CGFloat width = tabContentView.frame.size.width;
    NSInteger page = offset.x/width;
    CGFloat ratio = ((NSInteger)offset.x % (NSInteger)width)/width;
    [tabView setOffsetWithPage:page andRatio:ratio];
}

#pragma mark TabView delegate

- (void)selectedPage:(NSInteger)page{
    [tabContentView selectPage:page];
}


@end
