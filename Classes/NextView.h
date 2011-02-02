//
//  NextView.h
//  Tetris
//
//  Created by dm4 on 2010/2/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FieldModel;

@interface NextView : UIView {
	FieldModel *model;
}

@property (nonatomic, retain) FieldModel *model;

@end
