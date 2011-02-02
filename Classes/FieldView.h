//
//  FieldView.h
//  Tetris
//
//  Created by dm4 on 2011/1/29.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import <UIKit/UIKit.h>

@class FieldModel;

@protocol FieldViewDataSource
- (int)getX:(int)x Y:(int)y;
@end


@interface FieldView : UIView {
    FieldModel *model;
}

@property (nonatomic, retain) FieldModel *model;

@end
