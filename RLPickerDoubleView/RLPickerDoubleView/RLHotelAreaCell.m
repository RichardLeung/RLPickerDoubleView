//
//  RLHotelAreaCell.m
//  CococProject
//
//  Created by tempus-MAC on 14-10-4.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "RLHotelAreaCell.h"

#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define ColorButtonBlue RGB(29,95,196)

@implementation RLHotelAreaCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected ==YES) {
        self.labelTitle.textColor =ColorButtonBlue;
        self.imageViewMark.hidden =NO;
    }else{
        self.labelTitle.textColor =RGB(60, 60, 60);
        self.imageViewMark.hidden =YES;
    }
    // Configure the view for the selected state
}

@end
