//
//  TAFriendVKCell.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 31.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAFriendVKCell.h"
#import "TAFriend.h"
#import "TAApplicationStorage.h"
#import "TABirthday.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface TAFriendVKCell ()

@property (weak, nonatomic) TAFriend *friend;

@end

@implementation TAFriendVKCell

- (void) initWithFriend:(TAFriend*)friend
{
    self.friend = friend;
    //NAME
    [self.nameLabel setText: friend.name];
    
    //DATE
    if (friend.birthDate) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"HH:mm dd.MM.yyyy"];
        [formatter setDateFormat:@"dd MMMM"];
        self.birthDateLabel.text = [formatter stringFromDate:friend.birthDate];
    } else {
        self.birthDateLabel.text = @"скрыто";
    }
    //IMAGE
    [self.avatarImageView sd_setImageWithURL:friend.imgUrl placeholderImage:[UIImage imageNamed:@"default-user-avatar"] completed:nil];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2.f;
    self.avatarImageView.layer.masksToBounds = YES;
    
    [self setChecked:[[[TAApplicationStorage sharedLocator] changingBirthday] existSubscriberAtIndex:friend.vkId]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)addRemoveButtonClicked:(UIButton*)sender
{
    [self setChecked:self.checked?NO:YES];
}

-(void) setChecked:(BOOL)checked
{
    if (checked) {
        //ADD
        [[[TAApplicationStorage sharedLocator]changingBirthday] addSubscriberAtIndex: self.friend.vkId];
        [self.addRemoveButton setImage:[UIImage imageNamed:@"ic_check_circle"] forState:UIControlStateNormal];
        
    } else {
        //remove
        [[[TAApplicationStorage sharedLocator]changingBirthday] removeSubscriberAtIndex:self.friend.vkId];
        [self.addRemoveButton setImage:[UIImage imageNamed:@"ic_panorama_fish_eye"] forState:UIControlStateNormal];
    }
    _checked = checked;
    [self.delegate wasCheckedFriendCell:self];
    
}

@end
