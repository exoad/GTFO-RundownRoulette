# Rundown Roulette

A randomizer to make your vanilla GTFO experience more fun!

> [!WARNING]
> A lot of the code here is dreamt up by at like 4-6am so it might not be the best :)

## Usage

You can either use it right in your browser here: https://exoad.github.io/GTFO-RundownRoulette/

Or

Download it as a Windows program here: https://github.com/exoad/GTFO-RundownRoulette/releases

## Modes

> You can either download it for Windows or use it right in your web browser.

Currently, there is only one mode actually implemented and being worked on which is the
**Generic** mode which is just a raw randomizer. It allows you to filter and stuffs. There are also
additional planned modes that will be documented below and implemented in the future.

### Generic

This mode is the default and vanilla randomizer. It features a complete randomization of the loadout
and rundown. You can assign filters to this mode by using the control buttons at the top of the page,
this way you can limit your run to certain weapons and with certain tools.

The items generated are using Dart's `Random` class and with the complete randomization, it can
generate some comedic moments when you get an E-tier mission with 4 biotrackers, 4 burst pistols, and
4 short rifles.

Otherwise, it is the easiest to follow and there are also a set of suggested rules you can play by
to make it so that it isn't too repetitive:

1. After each successful run, both the rundown and the loadout will be randomized. The randomization process can utilize a dice or any other method to determine how many times the randomization should occur.
2. A majority vote can be used to trigger a reroll of the loadout or rundown. This can occur either once after the initial randomization or after a failed attempt.
3. Boosters are optional and not mandatory. If a player is unable to bring a specific tier of booster(s), they are allowed to forgo bringing any boosters at all.

### Blind

This mode is very simple and follows similar rules to the **Generic** mode, but instead of everything being
randomized, players have the option to decide what they want to choose to remain static and what to remain
randomized. When you make something static, this is known as *blocking* and everything here can be blocked:

1. Primary Weapon
2. Special Weapon
3. Tool
4. Melee
5. Rundown

Here are some common blocking methods:

#### Open Blind

This is when players block certain parts or all of their loadout, but the rundown is known later. You can
also unblock certain areas of the loadout; for example, only blocking guns and melees but not tools.

There is a lot of things you can do with this, but it is limited due to potential for meta loadouts when players
are allowed to block their entire loadout.

#### Closed Blind

This is when the players block the rundown, but are not blocking certain parts or all of their loadouts which is
known later.

This is good for relearning or potentially experimenting with a rundown, but it can short due to player's poor
decisions on what rundown to go with.

### Auction

This mode is an attempt to solve problems dealt by the **Blind** mode, but it still has shortcomings of its own.
The core mechanic revolves a pool of loadouts players can choose as well as either one unknown rundown or a pool
of unknown rundowns.

Players are given a pool of weapons for all of their loadout slots and they must choose using also a generated pool
of rundown(s).

This mode falls victim to the fact that players can discuss and make the run a lot easier by handing better weapons
to more skilled players and selecting easier rundowns for less penalties.
