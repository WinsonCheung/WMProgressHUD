//
//  ViewController.m
//  WMProgressHUDDemo
//
//  Created by Winson Cheung on 2016/11/11.
//  Copyright © 2016年 Winson Cheung. All rights reserved.
//

#import "ViewController.h"
#import "WMProgressHUD.h"


static NSString *const cell_identifier = @"cell";


@interface WMExample : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) SEL selector;

@end


@implementation WMExample

+ (instancetype)exampleWithTitle:(NSString *)title selector:(SEL)selector {
    WMExample *example = [[self class] new];
    example.title = title;
    example.selector = selector;

    return example;
}

@end

@interface ViewController ()<UITableViewDataSource, UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *hud_tableView;
@property (nonatomic, copy) NSArray<WMExample *> *exampleArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

-(void) initData {

    // register cell
    [self.hud_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cell_identifier];

    // prepare data

    self.exampleArray = @[[WMExample exampleWithTitle:@"Indeterminate mode" selector:@selector(indeterminate)],
                     [WMExample exampleWithTitle:@"With label" selector:@selector(withLabel)],
                     [WMExample exampleWithTitle:@"With details label" selector:@selector(withDetailsLabel)],
                     [WMExample exampleWithTitle:@"Determinate mode" selector:@selector(determinateMode)],
                     [WMExample exampleWithTitle:@"text only at bottom" selector:@selector(textOnlyAtBottom)],
                     [WMExample exampleWithTitle:@"text only at center" selector:@selector(textOnlyAtCenter)],
                     [WMExample exampleWithTitle:@"custom view" selector:@selector(customView)]
                     ];
}

- (void)initView {

    self.hud_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.hud_tableView.tableFooterView = [UIView new];
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _exampleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_identifier forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor purpleColor];
    cell.textLabel.text = _exampleArray[indexPath.row].title;

    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];

    WMExample *example = _exampleArray[indexPath.row];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:example.selector];
#pragma clang diagnostic pop
}



- (void) indeterminate {
    // show
    [WMProgressHUD showIn:self.view animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) withLabel {

    [WMProgressHUD showIn:self.view text:@"加载中" animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) withDetailsLabel {

    [WMProgressHUD showIn:self.view text:@"加载中" detail:@"请耐心等待" animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        // do something

        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES after:2.5f];
        });
    });
}

- (void) determinateMode {

    [WMProgressHUD showIn:self.view text:@"加载中" HUDModel:WMProgressHUDModeDeterminate animated:YES];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        float progress = 0.0f;
        while (progress < 1.0f) {
            progress += 0.01f;
            dispatch_async(dispatch_get_main_queue(), ^{

                [WMProgressHUD setupProgress:progress];
            });
            usleep(50000);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [WMProgressHUD dismissAnimated:YES];
        });
    });
}

- (void) textOnlyAtBottom {

    [WMProgressHUD showIn:self.view text:@"I'm Winson at bottom" position:WMProgressHUDPositionBottom];
    [WMProgressHUD dismissAnimated:YES after:2.5f];
}

- (void) textOnlyAtCenter {

    [WMProgressHUD showIn:self.view text:@"I'm Winson at center"];
    [WMProgressHUD dismissAnimated:YES after:2.5f];
}

- (void) customView {

    NSMutableArray *animations = [@[] mutableCopy];
    for (int i = 1; i < 4; i++) {
        NSString *animation = [NSString stringWithFormat:@"dropdown_loading_0%zd", i];
        [animations addObject:animation];
    }

    [WMProgressHUD showIn:self.view animaitions:animations text:@"吃包子"];

    [WMProgressHUD dismissAnimated:YES after:3.f];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
