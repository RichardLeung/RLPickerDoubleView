//
//  RLPickerDoubleTableViewCell.m
//  CococProject
//
//  Created by tempus-ota-client on 14-10-5.
//  Copyright (c) 2014年 tempus. All rights reserved.
//

#import "RLPickerDoubleTableViewCell.h"
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@implementation RLPickerDoubleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsZero;
        self.textLabel.font =[UIFont systemFontOfSize:14.0f];
        self.textLabel.textColor = RGB(60, 60, 60);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.backgroundColor =[UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        UIImage * image = [UIImage imageNamed:@"dest_activity_redPoint"];
        
        _markImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, (55 - image.size.height)/2, image.size.width, image.size.height)];
        _markImageView.image = image;
        [self.contentView addSubview:_markImageView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
