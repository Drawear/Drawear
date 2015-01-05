//
//  EditorController.h
//  Drawear
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditorController : UIViewController<UIGestureRecognizerDelegate>
{
    UIView *drawBoard; // draw board
}

@property (nonatomic,retain) UIView *drawBoard;

- (void)addImageByView: (UIImageView *) view; // add image passing UIImageView
- (void)addImageByImage: (UIImage *) image; // add image passing UIImage
- (void)addImageByPath: (NSString *) path; // add image passing String

- (void)setBackgroundByImage: (UIImage *) image; // set background passing UIImage
- (void)setBackgroundByPath: (NSString *) path; // set background passing String

- (void)initDrawBoard; // initialize draw board

- (void)setCurrTop: (UIImageView *) view;
- (void)tapBackground;

@end
