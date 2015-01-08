//
//  EditorController.m
//  Drawear
//
//  Created by Sidney on 1/4/15.
//  Copyright (c) 2015 DrawearGroup. All rights reserved.
//

#import "EditorController.h"
#import "UIImageViewEx.h"
#import "UITextFieldEx.h"

@interface EditorController (){
    
}

//@property (strong, nonatomic) IBOutlet UIView *drawView;
@property (weak, nonatomic) IBOutlet UIView *drawView;

@end

@implementation EditorController

@synthesize picker = _picker;

UIView *currTop;
UIImageViewEx *background;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: adjust draw board frame
    [self initDrawBoard];

    // add sample images
    [self addImageByPath:@"wukong.png"];
    [self addImageByPath:@"juhua.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)initDrawBoard {
    // init default background
    background = [[UIImageViewEx alloc] init];
    [background setCenter:self.drawView.center];
    [background setFrame:self.drawView.frame];
    [background setContentMode: UIViewContentModeScaleAspectFit];
    [background setController: self];
    [background enableTapAsBackground];
    
    [self setBackgroundByPath: @"T-shirt.png"];
    
    [self.drawView addSubview:background];
    
}

- (IBAction)addPictureTapped:(id)sender {
    if (self.picker == nil) {
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.allowsEditing = NO;
    }
    [self presentViewController:_picker animated:YES completion:nil];
}

- (IBAction)addTextTapped:(id)sender {
    [self addTextByText:@"请输入文字"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *fullImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self addImageByImage:fullImage];
}

- (void)setCurrTop: (UIView*) view {
    if (view == nil) {
        currTop = nil;
    }
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: NO];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: NO];
        }
        
    }
    currTop = view;
    [self.drawView bringSubviewToFront:currTop];
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: YES];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: YES];
            [(UITextFieldEx *)currTop resignFirstResponder];
        }
        
    }
}

- (void)addImageByView: (UIImageViewEx *) view {
    [view setCenter: self.drawView.center];
    [view setController: self];
    [view enablePan];
    [view enableScaleAndRotation];
    [view enableDelete];
    
    [self.drawView addSubview:view];
}

- (void)addImageByImage: (UIImage *) image {
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)addImageByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    UIImageViewEx *imageView = [[UIImageViewEx alloc] initWithImage: image];
    [self addImageByView:imageView];
}

- (void)addTextByView: (UITextFieldEx *) textField {
    [textField setCenter:self.drawView.center];
    [textField setController: self];
    [textField enablePan];
    [textField enableScaleAndRotation];
    [textField enableDelete];
    
    [self.drawView addSubview:textField];
}

- (void)addTextByText: (NSString *) text {
    UITextFieldEx *textField = [[UITextFieldEx alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [textField initWithTextAttribute];
    textField.text = text;

    [self addTextByView:textField];
}

- (void)setBackgroundByImage: (UIImage *) image {
    [background setImage:image];
}

- (void)setBackgroundByPath: (NSString *) path {
    UIImage *image = [UIImage imageNamed:path];
    [background setImage:image];
}

- (void)tapBackground
{
    if(currTop != nil){
        if ([currTop isKindOfClass:[UIImageViewEx class]]) {
            [(UIImageViewEx *)currTop setTop: NO];
        }
        if ([currTop isKindOfClass:[UITextFieldEx class]]) {
            [(UITextFieldEx *)currTop setTop: NO];
            [(UITextFieldEx *)currTop resignFirstResponder];
        }
        currTop = nil;
    }
}


@end
