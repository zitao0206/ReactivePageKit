//
//  MDViewController.m
//  MDReactPageKit
//
//  Created by leon0206 on 09/21/2019.
//  Copyright (c) 2019 leon0206. All rights reserved.
//

#import "MDViewController.h"
#import "MDDemoPageViewController.h"
#import "MDDemoSubViewViewController.h"

@interface MDViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView  alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
     self.tableView.delegate = self;
     self.tableView.dataSource = self;
     self.tableView.backgroundColor = [UIColor lightGrayColor];
     [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!contentCell)
    {
        contentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    contentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        contentCell.textLabel.text = @"模块化页面：pageViewCtronller";
    }
    if (indexPath.row == 1) {
        contentCell.textLabel.text = @"模块化页面：pageView";
    }
    return contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MDDemoPageViewController *vc = [MDDemoPageViewController new];
        vc.title = @"模块化框架";
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        MDDemoSubViewViewController *vc = [MDDemoSubViewViewController new];
        vc.title = @"模块化框架子View";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
