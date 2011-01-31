//
//  TetrisAppDelegate.h
//  Tetris
//
//  Created by dm4 on 2011/1/27.
//  Copyright 2011 Meng-Han Lee, dm4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TetrisAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navi;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navi;

@end

