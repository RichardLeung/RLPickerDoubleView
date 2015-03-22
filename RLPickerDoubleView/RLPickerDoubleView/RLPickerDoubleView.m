//
//  RLPickerDoubleView.m
//  CococProject
//
//  Created by tempus-MAC on 14-10-30.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "RLPickerDoubleView.h"
#import "RLPickerDoubleTableViewCell.h"
#import "RLHotelAreaCell.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ColorButtonBlue RGB(29,95,196)
#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight ((iOS7)?([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20))
#define iOS7 [[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0 ? YES : NO

@interface RLPickerDoubleView()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *blurView;

@end

@implementation RLPickerDoubleView

- (IBAction)buttonCancelClick:(id)sender {
    [self dismiss];
}

- (IBAction)buttonSureClick:(id)sender {
    self.block(self.selectSection,self.selectRow);
    [self dismiss];
}

- (void)initWithTitle:(NSString *)title
            arrayData:(NSArray *)array
              mainkey:(NSString *)mainKey
            detailKey:(NSString *)detailKey
        selectSection:(NSInteger)selectSection
            selectRow:(NSInteger)selectRow
             callback:(RLPickerDoubleViewRowSelectionBlock)block
{
    //获取数据
    self.title = title;
    self.array = array;
    NSLog(@"%@",array);
    self.mainKey =mainKey;
    self.detailKey =detailKey;
    self.selectSection = selectSection;
    self.selectRow =selectRow;
    _tableViewMain.backgroundColor =RGB(235, 235, 235);
    _tableViewMain.delegate =self;
    _tableViewMain.dataSource =self;
    _tableViewDetail.delegate =self;
    _tableViewDetail.dataSource =self;
    if (block) {
        self.block = block;
    }
    [self refreshView];
}

-(void)refreshView{
    _labelTitle.text =self.title;
    [_buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_buttonSure setTitle:@"确定" forState:UIControlStateNormal];
    [_tableViewMain reloadData];
    [_tableViewDetail reloadData];
}

- (UIView *)blurView
{
    if(_blurView ==nil){
        _blurView =[[UIView alloc]init];
        _blurView.backgroundColor = RGBA(10, 10, 10, 0.4);
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        [_blurView addGestureRecognizer:tap];
    }
    return _blurView;
}



-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self.blurView setFrame:window.bounds];
    [window addSubview:self.blurView];
    self.blurView.alpha =0;
    //self.blurView.alpha =0.8;
    self.frame =CGRectMake(0, ScreenHeight, ScreenWidth,ScreenHeight/2);
    self.alpha = 0;
    [_tableViewMain selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectSection inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [_tableViewDetail selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectRow inSection:0] animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [window addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.blurView.alpha = 1;
        self.alpha =1;
        [self setFrame:CGRectMake(0, ScreenHeight-self.frame.size.height, self.frame.size.width, self.frame.size.height)];
    }];
}



-(void)dismiss{
    __weak RLPickerDoubleView * weakself =self;
    
    [UIView animateWithDuration:0.3 animations:^{
        [weakself setFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenWidth)];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.blurView.alpha =0;
        }completion:^(BOOL finished) {
            [self.blurView removeFromSuperview];
            self.blurView =nil;
        }];
    }];
}

#pragma mark -UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView ==self.tableViewMain) {
        return self.array.count;
    }else{
        return [(NSArray*)[[self.array objectAtIndex:self.selectSection] objectForKey:@"sub"] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView ==_tableViewMain) {
        static NSString * cellMainID = @"cellMainID";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellMainID];
        if (cell ==nil) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellMainID];
        }
        cell.textLabel.text =[[self.array objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.textLabel.font =[UIFont systemFontOfSize:16];
        cell.textLabel.textColor =RGB(90, 90, 90);
        cell.textLabel.textAlignment =NSTextAlignmentCenter;
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor =[UIColor whiteColor];
        cell.backgroundColor =[UIColor clearColor];

        NSLog(@"%ld~~~~~~~~~~~~%@",indexPath.row,[[self.array objectAtIndex:indexPath.row] objectForKey:@"name"]);
        return cell;
    }
    else if (tableView == _tableViewDetail){
        static NSString * cellDetailID = @"cellDetailID";
        RLHotelAreaCell *cell =[tableView dequeueReusableCellWithIdentifier:cellDetailID];
        if (cell == nil) {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"RLHotelAreaCell" owner:self options:nil]lastObject];
        }
        cell.labelTitle.text =[[[[self.array objectAtIndex:self.selectSection] objectForKey:self.detailKey] objectAtIndex:indexPath.row] objectForKey:@"name"];
        NSLog(@"%@",[[[[self.array objectAtIndex:self.selectSection] objectForKey:self.detailKey] objectAtIndex:indexPath.row] objectForKey:@"name"]);
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableViewMain) {
        self.selectSection =indexPath.row;
        [self.tableViewDetail reloadData];
    }
    else if (tableView == _tableViewDetail){
        self.selectRow =indexPath.row;
        
        //[tableView deselectRowAtIndexPath:tableView.indexPathForSelectedRow animated:YES];
    }
}

@end
