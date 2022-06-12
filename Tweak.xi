
#import "xctheos.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "TheosTempelete.h"

typedef void(^LogTestBlk)(void);


@interface ViewController: UIViewController

@property (nonatomic, strong) UIImage *img;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, copy) LogTestBlk logTest;

- (void)testXcTheosLogos;
@end


HOOK(ViewController)

+ (void)load {
    testlog();
    
    [TheosTempelete sum:1 add:2];
}

END()
