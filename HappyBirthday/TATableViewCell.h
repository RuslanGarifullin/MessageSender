//
//  TATableViewCell.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 30.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TATableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageCounterLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;

@end
