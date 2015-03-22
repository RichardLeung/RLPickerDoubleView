//
//  RLPickerDoubleView.h
//  CococProject
//
//  Created by tempus-MAC on 14-10-30.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RLPickerDoubleView;

typedef void (^RLPickerDoubleViewRowSelectionBlock)(NSInteger selectSection,NSInteger selectRow);

@interface RLPickerDoubleView : UIToolbar
//Data
@property (strong,nonatomic)NSString * title;
//筛选项标题选择
@property (nonatomic,assign) NSInteger selectSection;
//筛选项目选择
@property (nonatomic,assign) NSInteger selectRow;
@property(nonatomic,strong)NSString *mainKey;
@property(nonatomic,strong)NSString *detailKey;
//筛选标题
@property (strong,nonatomic )NSArray * array;
@property (strong,nonatomic)RLPickerDoubleViewRowSelectionBlock block;

//View
@property (weak, nonatomic) IBOutlet UIButton *buttonCancel;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIButton *buttonSure;
@property (weak, nonatomic) IBOutlet UITableView *tableViewMain;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDetail;

- (IBAction)buttonCancelClick:(id)sender;

- (IBAction)buttonSureClick:(id)sender;


- (void)initWithTitle:(NSString *)title
            arrayData:(NSArray *)array
              mainkey:(NSString *)mainKey
            detailKey:(NSString *)detailKey
        selectSection:(NSInteger)selectSection
            selectRow:(NSInteger)selectRow
             callback:(RLPickerDoubleViewRowSelectionBlock)block;

-(void)show;

@end
