//
//  TAFriendVKCell.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 31.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TABirthday, TAFriend;
@protocol  TAFriendVKCellDelegate;

@interface TAFriendVKCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthDateLabel;
@property (weak, nonatomic) IBOutlet UIButton *addRemoveButton;
@property (assign, nonatomic) BOOL checked;
@property (weak, nonatomic) id <TAFriendVKCellDelegate> delegate;
- (void) initWithFriend:(TAFriend*)friend;

@end

@protocol TAFriendVKCellDelegate <NSObject>

- (void) wasCheckedFriendCell:(TAFriendVKCell*)cell;

@end