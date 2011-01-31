//
//  OptionViewController.h
//  Tetris
//
//  Created by dm4 on 2011/1/28.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OptionViewController : UIViewController {
    IBOutlet UIButton *ghostButton;
    IBOutlet UILabel *repeatLabel;
    IBOutlet UISlider *repeatSlider;
}

- (IBAction)back;
- (IBAction)ghostChange:(UIButton *)button;
- (IBAction)repeatChange:(UISlider *)slider;
- (IBAction)setGameControl;

@end
