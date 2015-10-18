//
//  BookCell.m
//  DatebasePackage
//
//  Created by Mac on 15/10/18.
//  Copyright (c) 2015年 hbbdsqd. All rights reserved.
//

#import "BookCell.h"
#import "UIImageView+WebCache.h"

@interface BookCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;

@end

@implementation BookCell

- (void)setBook:(Book *)book
{
    _book = book;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:book.large] placeholderImage:[UIImage imageNamed:@"egopv_photo_placeholder"]];
    self.titleLabel.text = book.title;
    self.publisherLabel.text = book.publisher;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
