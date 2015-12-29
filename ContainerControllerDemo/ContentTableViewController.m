//
//  ContentTableViewController.m
//  ContainerControllerDemo
//
//  Created by Ming on 15/12/29.
//  Copyright © 2015年 Ming. All rights reserved.
//

#import "ContentTableViewController.h"

@implementation ContentTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        NSString *text = [NSString stringWithFormat:@"第%d行",indexPath.row];
        
        cell.textLabel.text = text;
    }
    return cell;
}

@end
