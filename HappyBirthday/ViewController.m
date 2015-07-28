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


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, TANavigationBarDelegate>
@property (strong, nonatomic) TANavigationBar *navBar;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.birthdaysArray = [[NSMutableArray alloc] init];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 1"]];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 2"]];
        [self.birthdaysArray addObject:[[TABirthday alloc]initWithTitle:@"some name 3"]];
    }
    return self;
}


- (IBAction)addNewBirthday:(id)sender
{
    ChangingViewController *changintVC = [[ChangingViewController alloc] initWithBirthdaysArray:self.birthdaysArray  atIndex:(NSInteger)self.birthdaysArray.count];
    [self.navigationController pushViewController:changintVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.birthdayTableView.dataSource = self;
    self.birthdayTableView.delegate = self;
    self.navBar = [[TANavigationBar alloc] initWithType:TANavigationBarTypeBackSearchAdd andTitle:@"Ваши сообщения"];
    [self.view addSubview: self.navBar.view];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.birthdayTableView reloadData];
}
          
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.birthdaysArray.count == 0) {
        [self.haveNothingNotificationView setHidden:NO];
        [self.birthdayTableView setHidden:YES];
    } else {
        [self.haveNothingNotificationView setHidden:YES];
        [self.birthdayTableView setHidden:NO];
    }
    return self.birthdaysArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"birthday";
    UITableViewCell *cell = [self.birthdayTableView dequeueReusableCellWithIdentifier:identifier];
    UISwitch *onOffSwitch = nil;
    TABirthday *birthday = [self.birthdaysArray objectAtIndex:indexPath.row];
    if (cell == nil) {
        //cell customize
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",birthday.subscribers.count];
        cell.backgroundColor = [UIColor colorWithRed:0.91f green:0.91f blue:0.91f alpha:1.f];
        [cell.textLabel setTextColor:[UIColor colorWithRed:0.627f green:0.627f blue:0.627f alpha:1.f]];
        
        //switch customize
        onOffSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
        [onOffSwitch setCenter: CGPointMake(cell.frame.size.width - onOffSwitch.frame.size.width/2-10, cell.center.y)];
        [onOffSwitch setOnTintColor:[UIColor colorWithRed:0.075f green:0.75f blue:0.86f alpha:1.f]];
        [onOffSwitch setTag:100];
        [onOffSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        [cell.contentView addSubview:onOffSwitch];
    } else {
        onOffSwitch = (UISwitch*) [cell.contentView viewWithTag:100];
    }
    cell.textLabel.text = birthday.title;
    [onOffSwitch setOn:birthday.enable];
    return cell;
}

- (void) switchValueChanged:(UISwitch*)sender
{
    UITableViewCell *cell = (UITableViewCell*) [[sender superview] superview];
    NSIndexPath *indexpath = [self.birthdayTableView indexPathForCell:cell];
    TABirthday *birthday = [self.birthdaysArray objectAtIndex:indexpath.row];
    [birthday setEnable:sender.isOn];
}

#pragma mark - UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.birthdayTableView deselectRowAtIndexPath:indexPath animated:YES];
        ChangingViewController *changintVC = [[ChangingViewController alloc] initWithBirthdaysArray:self.birthdaysArray  atIndex:(NSInteger)indexPath.row];
    [self.navigationController pushViewController:changintVC animated:YES];
}

@end
