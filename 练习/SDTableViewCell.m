//
//  SDTableViewCell.m
//  练习
//
//  Created by fqq3 on 2017/9/12.
//  Copyright © 2017年 sandouchan. All rights reserved.
//

#import "SDTableViewCell.h"

@interface SDTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *view;
@property (nonatomic, strong) UIColor *btnColor;
@property (nonatomic, strong) UIColor *labelColor;
@property (nonatomic, strong) UIColor *viewColor;

@end

@implementation SDTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btnColor = self.btn.backgroundColor;
    self.labelColor = self.label.backgroundColor;
    self.viewColor = self.view.backgroundColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.btn.backgroundColor = self.btnColor;
    self.label.backgroundColor = self.labelColor;
    self.view.backgroundColor = self.viewColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    
    self.btn.backgroundColor = self.btnColor;
    self.label.backgroundColor = self.labelColor;
    self.view.backgroundColor = self.viewColor;
}

@end
