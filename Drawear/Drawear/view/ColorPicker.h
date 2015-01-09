//
//  ColorPicker.h
//  DrawTutorial
//
//  Created by Sidney on 1/9/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate <NSObject>
@optional
-(void)aColorPickerIsSelected:(UIColor *)color;
@end

@interface ColorPicker : UIView

@property (nonatomic,retain) id<ColorPickerDelegate> delegate;

@end
