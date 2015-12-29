//
//  TabViewController.h
//  lightapp
//
//  Created by Ming on 15/12/26.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"
//#import "TabContentView.h"
#import "TabView.h"

@interface TabViewController : UIViewController<ClickDelegate, TabContentDelegate>

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) TestView *tabContentView;
@property (nonatomic, strong) TabView *tabView;



- (instancetype)initWithItems:(NSArray *)items andControllers:(NSArray *)controllers;


@end
