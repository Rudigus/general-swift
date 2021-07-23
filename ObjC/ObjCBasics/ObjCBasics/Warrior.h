//
//  Warrior.h
//  ObjCBasics
//
//  Created by Rudigus on 22/07/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Warrior : NSObject

@property NSString *name;

@property float attack;
@property float health;

@property float weight;
@property float height;

- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

- (NSString *)description;

- (float)attackWarrior:(Warrior *)warrior;

@end

NS_ASSUME_NONNULL_END
