//
//  OptionViewController.m
//  Tetris
//
//  Created by dm4 on 2011/1/28.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import "OptionViewController.h"
#import "GameControlViewController.h"


@implementation OptionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL ghost = [[NSUserDefaults standardUserDefaults] boolForKey:@"ghost"];
    [ghostButton setTitle:ghost?@"On":@"Off" forState:UIControlStateNormal];
    float repeat = [[NSUserDefaults standardUserDefaults] floatForKey:@"repeat"];
    repeatLabel.text = [NSString stringWithFormat:@"%.2f", repeat];
    repeatSlider.value = repeat;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark IBAction

- (IBAction)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)ghostChange:(UIButton *)button {
    BOOL ghost;
    if ([button.titleLabel.text isEqualToString:@"On"])
        ghost = NO;
    else
        ghost = YES;
    [ghostButton setTitle:ghost?@"On":@"Off" forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setBool:ghost forKey:@"ghost"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)repeatChange:(UISlider *)slider {
    repeatLabel.text = [NSString stringWithFormat:@"%.2f", slider.value];
    [[NSUserDefaults standardUserDefaults] setFloat:slider.value forKey:@"repeat"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)setGameControl {
    GameControlViewController *controlVC = [[GameControlViewController alloc] initWithNibName:@"GameControlViewController" bundle:nil];
    [self.navigationController pushViewController:controlVC animated:YES];
    [controlVC release];
}

#pragma mark -

- (void)dealloc {
    [super dealloc];
}


@end
