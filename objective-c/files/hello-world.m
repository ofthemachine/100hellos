#import <Foundation/Foundation.h>

#import <stdio.h>

// BEGIN_FRAGLET
@interface Greeting : NSObject {
}

- (void)greet: (char *)noun;
@end

@implementation Greeting
-(void) greet: (char *)noun
{
    printf("Hello %s!\n", noun);
}
@end

int main(int argv, char* argc[])
{
    id greeting = [Greeting new];

    [greeting greet: "World"];
    
    return 0;
}
// END_FRAGLET
