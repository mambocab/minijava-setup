## Getting Started

I've only ever got this to build on Ubuntu. I used [Vagrant][vagrant] to create an isolated Ubuntu environment. I've only used Vagrant on OS X, so YMMV. Vagrant depends on Ruby.

Use [this Vagrantfile][vagrantfile] to set up a VM.


It'll automatically download the VM you need. If you don't want to/can't use Vagrant, the `root_script` and `user_script` variables contain the scripts you need to run to get going.

You may need to manually set the JDK you use as described [here](https://help.ubuntu.com/community/Java#Choosing_the_default_Java_to_use).

## Implementation

Notifications, in this system, are `Diagnostic`s. So are the actual errors raised when problems are encountered are also `Diagnostic`s. I've separated these out into two subclasses, `ThrownError`s and tktktktktk. Each `ThrownError` subclass is (should be?) unique to the site at which it's thrown -- that is to say, tktktktk is only thrown in a single file, exactly where that error is applicable.

[vagrant]: https://www.vagrantup.com/
[vagrantfile]: https://github.com/mambocab/minijava-setup/blob/master/Vagrantfile
