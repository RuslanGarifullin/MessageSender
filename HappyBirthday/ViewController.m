//
//  ViewController.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "ViewController.h"
#import "TABirthday.h"
#import "ChangingViewController.h"
#import "TANavigationBar.h"
#import "TAApplicationStorage.h"
#import "TATableViewCell.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, TANavigationBarDelegate>

@property (strong, nonatomic) IBOutlet TANavigationBar *navBar;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.birthdayTableView.dataSource = self;
    self.birthdayTableView.delegate = self;
    
    [self.navBar.addButton setHidden:NO];
    self.navBar.navBarLabel.text = @"Сообщения";
    [self.navBar setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:@"TATableViewCell" bundle:nil];
    [self.birthdayTableView registerNib:nib forCellReuseIdentifier:@"TATableViewCell"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.birthdayTableView reloadData];
}
          
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TAApplicationStorage *storage = [TAApplicationStorage sharedLocator];
    if ([[storage birthdaysArray] count] == 0) {
        [self.haveNothingNotificationView setHidden:NO];
        [self.birthdayTableView setHidden:YES];
    } else {
        [self.haveNothingNotificationView setHidden:YES];
        [self.birthdayTableView setHidden:NO];
    }
    return [[storage birthdaysArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"TATableViewCell";
    TATableViewCell *cell = [self.birthdayTableView dequeueReusableCellWithIdentifier:identifier];
    TABirthday *birthday = [[[TAApplicationStorage sharedLocator] birthdaysArray] objectAtIndex:indexPath.row];
    
    //TITLE
    cell.titleLable.text = birthday.title;
    
    //ENABLE/DISABLE
    [cell.enableSwitch setOn:birthday.enable];
    
    //DATE
    if (birthday.date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //[formatter setDateFormat:@"HH:mm dd.MM.yyyy"];
        [formatter setDateFormat:@"dd.MM.yyyy"];
        cell.dateLabel.text = [formatter stringFromDate:birthday.date];
    } else {
        cell.dateLabel.text = @"не установлено";
    }
    
    //PEOPLE COUNTER
    cell.peopleCounterLabel.text = [NSString stringWithFormat:@"%d", birthday.subscribers.count];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}



#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.birthdayTableView deselectRowAtIndexPath:indexPath animated:YES];
    [[TAApplicationStorage sharedLocator] startChangingBirthdayAtIndex:indexPath.row];
    ChangingViewController *changintVC = [[ChangingViewController alloc] init];
    [self.navigationController pushViewController:changintVC animated:YES];
}

#pragma mark - TANavigationBarDelegate
- (void) navigationBar:(TANavigationBar *)navBar addButtonClicked:(UIButton *)button
{
    [[TAApplicationStorage sharedLocator] createNewBirthdayAndStartChanging];
    ChangingViewController *changintVC = [[ChangingViewController alloc] init];
    [self.navigationController pushViewController:changintVC animated:YES];
}

@end
