//
//  TouchDrawView.h
//  DrawTutorial
//
//  Created by Sidney on 1/9/15.
//  Copyright (c) 2015 Sidney. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface TouchDrawView : UIView

@property (nonatomic) Line *currentLine;
@property (nonatomic) NSMutableArray *linesCompleted;
@property (nonatomic) UIColor *drawColor;
@property (nonatomic) BOOL canDraw;

- (void)undo;

- (void)initButton;
- (void)switchVisible;
@end
