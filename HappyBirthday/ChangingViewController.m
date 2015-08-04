//
//  ChangingViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "ChangingViewController.h"
#import "TABirthday.h"
#import "TAFriend.h"
#import "TASubscriber.h"
#import "TAServiceLocator.h"
#import "TAStorageService.h"
#import "TANavigationBar.h"
#import "TAChangingCell.h"
#import "TimeModelViewController.h"
#import "FriendsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ChangingViewController () <TANavigationBarDelegate, UITableViewDataSource, UITableViewDelegate, TimeModelViewControllerDelegate>

@property (strong, nonatomic) UIAlertController *alertController;
@property (strong, nonatomic) IBOutlet TANavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UITableView *optionsTableView;
@property (weak, nonatomic) UISwitch *enableSwitch;
@property (strong, nonatomic) UITextField *generalTitleTextField;
@property (strong, nonatomic) NSMutableArray *friendsAvatars;

@end

@implementation ChangingViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    //Initialize navigation bar
    [self.navBar.doneButton setHidden:NO];
    [self.navBar.backButton setHidden:NO];
    [self.navBar.deleteButton setHidden:NO];
    self.navBar.navBarLabel.text = @"Редактор";
    [self.navBar setDelegate:self];
    
    [self.optionsTableView setDelegate: self];
    [self.optionsTableView setDataSource:self];
    
    UINib *nib = [UINib nibWithNibName:@"TAChangingCell" bundle:nil];
    [self.optionsTableView registerNib:nib forCellReuseIdentifier:@"TAChangingCell"];
}


- (void) viewWillAppear:(BOOL)animated
{
    [self.optionsTableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated
{
    for (int i = 0; i < self.friendsAvatars.count; i++) {
        UIImageView *image = [self.friendsAvatars objectAtIndex:i];
        [UIView animateWithDuration:0.3f delay:0.15f*i options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [image setCenter:CGPointMake(55+i*35, image.center.y)];
            [image setAlpha:1.f];
        } completion:^(BOOL finished) {
            //come code
        }];
    }
}

- (void) viewDidDisappear:(BOOL)animated
{
    for (int i = 0; i < self.friendsAvatars.count; i++) {
        UIImageView *image = [self.friendsAvatars objectAtIndex:i];
        [image removeFromSuperview];
    }
}


- (NSString*)removeAllDoubleSpaces:(NSString*)line
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@" +" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *lineForReturn = [regex stringByReplacingMatchesInString:line options:0 range:NSMakeRange(0, [line length]) withTemplate:@" "];
    if ([lineForReturn length] == 0) {
        return @"";
    }
    if ([lineForReturn characterAtIndex:0] == ' ') {
        lineForReturn = [lineForReturn substringFromIndex:1];
    }
    return lineForReturn;
}

#pragma mark - TANavigationBarDelegate

- (void) navigationBar:(TANavigationBar *)navBar doneButtonClicked:(UIButton *)button
{
    TABirthday *birthday = [[self storageService] changingBirthday];
    birthday.title = [self removeAllDoubleSpaces: self.generalTitleTextField.text];
    birthday.enable = [self.enableSwitch isOn];
    if ([birthday.title isEqual:@""]) {
        UIAlertController *someAlertController = [UIAlertController alertControllerWithTitle:@"Ошибка" message:@"Введите заголовок" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [someAlertController addAction:action];
        [self presentViewController:someAlertController animated:YES completion:nil];
        return;
    }
    [[self storageService] accessChanging];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar deleteButtonClicked:(UIButton *)button
{
    [[self storageService] removeCurrentBirthday];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) navigationBar:(TANavigationBar *)navBar backButtonClicked:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TAChangingCell";
    TABirthday *birthday = [[self storageService] changingBirthday];
    TAChangingCell *cell = [self.optionsTableView dequeueReusableCellWithIdentifier:identifier];
    switch (indexPath.row) {
        case 0:
            self.generalTitleTextField = cell.generalTextField;
            [self.generalTitleTextField setHidden:NO];
            [self.generalTitleTextField setText:birthday.title];
            [cell.titleLabel setHidden:YES];
            [cell.rightImageView setHidden:YES];
            [cell.descriptionLabel setHidden:YES];
            [cell.leftImageView setImage:[UIImage imageNamed:@"ic_bookmark_border"]];
            break;
        case 1:
            [cell.titleLabel setText:@"Дата"];
            cell.descriptionLabel.text = [birthday stringDate];
            cell.leftImageView.image = [UIImage imageNamed:@"ic_access_time"];
            break;
        case 2:
            [cell.titleLabel setText:@"Получатели"];
            [cell.descriptionLabel setText:[NSString stringWithFormat:@"%d",birthday.subscribers.count]];
            [cell.leftImageView setImage:[UIImage imageNamed:@"ic_face"]];
            self.friendsAvatars = [[NSMutableArray alloc] init];
            for (int i = 0; i < birthday.subscribers.count; i++) {
                TASubscriber *subscr = [birthday.subscribers objectAtIndex:i];
                TAFriend *friend = [[self storageService] friendAtId:subscr.userId];
                if (friend == nil) {
                    continue;
                }
                UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(cell.frame.size.width - 32, 40, 32, 32)];
                [image sd_setImageWithURL:[friend imgUrl] placeholderImage:[UIImage imageNamed:@"default-user-avatar"] completed:nil];
                image.layer.cornerRadius = image.frame.size.width/2.f;
                image.layer.masksToBounds = YES;
                [image setAlpha:0.f];
                [self.friendsAvatars addObject:image];
                [cell addSubview:image];
                if (i == 7) {
                    break;
                }
            }
            break;
        case 3:
            self.enableSwitch = cell.enableSwitch;
            [cell.enableSwitch setHidden:NO];
            [cell.enableSwitch setOn:birthday.enable];
            [cell.descriptionLabel setHidden:YES];
            [cell.rightImageView setHidden:YES];
            [cell.leftImageView setImage: [UIImage imageNamed:@"ic_power_settings_new"]];
            [cell.titleLabel setText:@"Разрешить отправку"];
            break;
        case 4:
            [cell.titleLabel setText:@"Сообщение"];
            [cell.descriptionLabel setHidden:YES];
            [cell.leftImageView setImage: [UIImage imageNamed:@"ic_message"]];
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 &&[[[[self storageService] changingBirthday] subscribers] count] > 0) {
            return 80;
        }
    return 50;
}

- (TAStorageService*)storageService
{
    return [[TAServiceLocator sharedServiceLocator] mainStorageService];
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[[FriendsViewController alloc] init] animated:YES];
        return;
    }
    
    if (indexPath.row == 1) {
        
        TimeModelViewController *ctrl = [TimeModelViewController new];
        ctrl.delegate = self;
        ctrl.modalPresentationStyle = UIModalPresentationCustom;
        ctrl.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:ctrl];
        [navigationController.navigationBar setHidden:YES];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}
#pragma mark - TimeModelViewControllerDelegate
- (void) timeModelViewController:(TimeModelViewController *)cancelled
{
    
}

- (void) timeModelViewController:(TimeModelViewController *)viewController doneWithDate:(NSDate *)date
{
    
}


@end
