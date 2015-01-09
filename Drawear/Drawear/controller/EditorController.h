//
//  EditorController.h
//  Drawear
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorPicker.h"
#import "TouchDrawView.h"
#import "DecorateViewController.h"

@interface EditorController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITabBarDelegate, UIActionSheetDelegate, UIScrollViewDelegate,ColorPickerDelegate,addItemDelegate>
{
    BOOL isSelectedColor;
}

@property (strong, nonatomic) UIImagePickerController *picker;
@property (nonatomic) TouchDrawView *drawArea;

- (void)addImageByView: (UIImageView *) view; // add image passing UIImageView
- (void)addImageByImage: (UIImage *) image; // add image passing UIImage
- (void)addImageByPath: (NSString *) path; // add image passing String

- (void)addTextByView: (UITextField *) textField; // add text passing UITextView
- (void)addTextByText: (NSString *) text; // add text passing String

- (void)setBackgroundByImage: (UIImage *) image; // set background passing UIImage
- (void)setBackgroundByPath: (NSString *) path; // set background passing String

- (void)initDrawBoard; // initialize draw board

- (void)setCurrTop: (UIView *) view;
- (void)tapBackground;

@end
