//
//  TabView.m
//  lightapp
//
//  Created by Ming on 15/12/26.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import "TabView.h"
#define BUTTON_TAG_START 100
@implementation TabView{
    NSMutableArray *labelArray;
    CGFloat smallFont;
    CGFloat bigFont;
    
}
@synthesize selectedPage,clickDelegate;

- (instancetype)initWithFrame:(CGRect)frame andItems:(NSArray *)items {
   self =  [super initWithFrame:frame];
    if (self) {
        selectedPage = 0;
        CGFloat x = 0;
        smallFont = 15;
        bigFont = 20;
        labelArray = [[NSMutableArray alloc]init];
        for (NSInteger i=0; i<items.count; i++) {

            UILabel *label = [[UILabel alloc]init];
            NSString *title = [items objectAtIndex:i];
            label.text = title;
            label.userInteractionEnabled = YES;
            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:bigFont] constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:NSLineBreakByCharWrapping];
            label.frame = CGRectMake(x, 0, size.width, frame.size.height);
            if (selectedPage == i) {
                [label setTextColor:[UIColor colorWithHue:1 saturation:0.6 brightness:0.6 alpha:1]];
                label.font = [UIFont systemFontOfSize:bigFont];

            }else{
                [label setTextColor:[UIColor colorWithHue:1 saturation:0.4 brightness:0.4 alpha:1]];
                label.font = [UIFont systemFontOfSize:smallFont];
   
            }
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClick:)];
            [label addGestureRecognizer:singleTap];
            label.tag = BUTTON_TAG_START + i;
            [self addSubview:label];
            [labelArray addObject:label];
            
            if (i < items.count-1) {
                x += size.width +20;
            }else{
                x += size.width;
            }
            
            [self setContentSize:CGSizeMake(x, frame.size.height)];
            
            [self setShowsVerticalScrollIndicator:NO];
            [self setShowsHorizontalScrollIndicator:NO];
            
        }
        
    }
    return self;
}

- (void)onClick:(UITapGestureRecognizer *)sender {
    UILabel *label = (UILabel *)sender.view;
    NSInteger page = label.tag - BUTTON_TAG_START;
    if (selectedPage != page) {
        [self selectPage:page];
    }
}

- (void)selectPage:(NSInteger)page {
    if (selectedPage != page) {
        [self setLabelDefault:page];
        [self animationWithselectPage:page];
        
        selectedPage = page;
        CGRect lineRC = [self viewWithTag:selectedPage+BUTTON_TAG_START].frame;
        if (clickDelegate != nil && [clickDelegate respondsToSelector:@selector(selectedPage:)]) {
            [clickDelegate selectedPage:page];
        }
     
        if (lineRC.origin.x - self.contentOffset.x > self.frame.size.width*2/3) {
            if (selectedPage + 2 < labelArray.count) {
                page = selectedPage + 2;
            }else if (selectedPage + 1 < labelArray.count){
                page = selectedPage + 1;
            }
            CGRect rc = [self viewWithTag:page + BUTTON_TAG_START].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        
        if (lineRC.origin.x - self.contentOffset.x < self.frame.size.width/3) {
            if (selectedPage - 2 >= 0) {
                page = selectedPage - 2;
            }else if(selectedPage -1 >= 0){
                page = selectedPage - 1;
            }
            CGRect rc = [self viewWithTag:page + BUTTON_TAG_START].frame;
            [self scrollRectToVisible:rc animated:YES];
            
        }
        
        
        
        
    }
}

- (void)setOffsetWithPage:(NSInteger)page andRatio:(CGFloat)ratio {

    UILabel *label1 = [self viewWithTag:page + BUTTON_TAG_START];
    UILabel *label2 = [self viewWithTag:page + 1 + BUTTON_TAG_START];

    label1.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
    label2.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleRightMargin;
//    label1.frame = CGRectMake(label1.frame.origin.x+ratio*0.2, label1.frame.origin.y+ratio*0.2, label1.frame.size.width-0.4*(1-ratio), label1.frame.size.height-0.4*(1-ratio));
//   
//    label2.frame = CGRectMake(label2.frame.origin.x-ratio*0.2, label2.frame.origin.y-0.2*ratio, label2.frame.size.width+0.4*ratio, label2.frame.size.height+0.4*ratio);
    
    label1.font = [UIFont systemFontOfSize:smallFont+2*(1-ratio)];
    label2.font = [UIFont systemFontOfSize:smallFont+2*(ratio)];
    
    if (ratio < 0.4) {
        ratio = 0.4;
    }
    if (ratio>0.6) {
        ratio = 0.6;
    }
    
    [label1 setTextColor:[UIColor colorWithHue:1 saturation:1-ratio brightness:1-ratio alpha:1]];
    
    [label2 setTextColor:[UIColor colorWithHue:1 saturation:ratio brightness:ratio alpha:1]];
}

- (void)animationWithselectPage:(NSInteger)page {
    UILabel *label1 = [labelArray objectAtIndex:page];
    UILabel *label2 = [labelArray objectAtIndex:selectedPage];
    [UIView animateWithDuration:0.5 animations:^{

        [label1 setTransform:CGAffineTransformScale(label1.transform, 1.05, 1.05)];
        
        [label2 setTransform:CGAffineTransformScale(label2.transform, 0.95, 0.95)];
    }];
}

- (void)setLabelDefault:(NSInteger)page {
    for (NSInteger i=0; i<labelArray.count; i++) {
        if (i == page)continue;
        UILabel *label = [labelArray objectAtIndex:i];
        [label setTextColor:[UIColor colorWithHue:1 saturation:0.4 brightness:0.4 alpha:1]];
        label.font = [UIFont systemFontOfSize:smallFont];
    }
}


@end
